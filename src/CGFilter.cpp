#include <llvm/ADT/DepthFirstIterator.h>
#include <llvm/ADT/PostOrderIterator.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/Operator.h>
#include <llvm/Transforms/IPO/GlobalDCE.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/IR/InstIterator.h>
#include "CGFilter.h"
using namespace llvm;
using namespace lle;
using namespace std;

bool std::less<BasicBlock>::operator()(BasicBlock* L, BasicBlock* R)
{
   if(L == NULL || R == NULL) return false;
   if(L->getParent() != R->getParent()) return false;
   Function* F = L->getParent();
   if(F==NULL) return false;
   unsigned L_idx = std::distance(F->begin(), Function::iterator(L));
   unsigned R_idx = std::distance(F->begin(), Function::iterator(R));
   return L_idx < R_idx;
}

bool std::less<Instruction>::operator()(Instruction* L, Instruction* R)
{
   if(L == NULL || R == NULL) return false;
   BasicBlock* L_B = L->getParent(), *R_B = R->getParent();
   if(L_B != R_B) return std::less<BasicBlock>()(L_B, R_B);
   if(L_B == NULL) return false;
   unsigned L_idx = std::distance(L_B->begin(), BasicBlock::iterator(L));
   unsigned R_idx = std::distance(R_B->begin(), BasicBlock::iterator(R));
   return L_idx < R_idx;
}

static CallGraphNode* last_valid_child(CallGraphNode* N, set<Value*>& Only)
{
   using RIte = std::reverse_iterator<CallGraphNode::iterator>;
   auto found = find_if(RIte(N->end()), RIte(N->begin()), [&Only](RIte::value_type& P){
            auto F = P.second->getFunction();
            return Only.count(P.first) && F != NULL && !F->isDeclaration();
         });
   if(found == RIte(N->begin())) return NULL;
   else return found->second;
}

CGFilter::CGFilter(CallGraphNode* root_, Instruction* threshold_inst_): root(root_)
{
   using std::placeholders::_1;
   unsigned LastPathLen = 0;
   int i=-1; // for initial
   for(auto N = df_begin(root), E = df_end(root); N!=E; ++N){
      Function* F = N->getFunction();
      if(F && !F->isDeclaration()){

      errs()<<F->getName()<<"\n";
         if(N.getPathLength()>1){
            // first we go through tree, only stores which we visited
            CallGraphNode* Parent = N.getPath(N.getPathLength()-2);
            CallGraphNode* Current = *N;
            auto found = find_if(Parent->begin(), Parent->end(), [Current](CallGraphNode::iterator::value_type& V){
                  return V.second == Current;
                  });
            Only.insert(&*found->first);
         }

         // we caculate [first
         unsigned CurPathLen = N.getPathLength();
         i += LastPathLen - CurPathLen + 2;
         LastPathLen = CurPathLen;
         order_map[F] = {(unsigned)i, 0, *N}; // a function only store minimal idx
      }
   }
   // we caculate last)
   for(auto N = po_begin(root), E = po_end(root); N!=E; ++N){
      Function* F = N->getFunction();
      if(F==NULL || F->isDeclaration()) continue;

      Record& r = order_map[F];
      auto Clast = last_valid_child(*N, Only);
      if(N->empty() || Clast == NULL) r.last = r.first + 1;
      else r.last = order_map[Clast->getFunction()].last + 1;
   }
   threshold = 0;
   threshold_inst = NULL;
   threshold_f = NULL;
   update(threshold_inst_);
}

unsigned CGFilter::indexof(llvm::Instruction *I)
{
   Function* ParentF = I->getParent()->getParent();
   CallGraphNode* Parent = order_map[ParentF].second;
   // this function doesn't in call graph
   if(Parent==NULL) return UINT_MAX;
   if(Parent->empty()) return order_map[ParentF].first;

   Function* Fmatch = NULL;
   for(auto t = Parent->begin(), e = Parent->end(); t!=e; ++t){
      Function* F = t->second->getFunction();
      if(F==NULL || F->isDeclaration()) continue;
      if(t->first == NULL || Only.count(t->first)==0) continue;
      Instruction* call_inst = dyn_cast<Instruction>(&*t->first);
      // last call_inst < threshold_inst < next call_inst
      // then threshold should equal to last call_inst's order
      if(I == call_inst || std::less<Instruction>()(I, call_inst)){
         Fmatch = F;
         break;
      }
   }
   if(Fmatch == NULL)
      return order_map[ParentF].last - 1;
   else
      return order_map[Fmatch].first - 1;
}
void CGFilter::update(Instruction* threshold_inst_)
{
   if(threshold_inst_==NULL) return;
   threshold_inst = threshold_inst_;
   threshold_f = threshold_inst->getParent()->getParent();
   threshold = indexof(threshold_inst);
}
bool CGFilter::operator()(Use* U)
{
   Instruction* I = dyn_cast<Instruction>(U->getUser());
   if(I==NULL) return false;
   BasicBlock* B = I->getParent();
   if(B==NULL) return false;
   Function* F = B->getParent();
   if(F==NULL) return false;

   // quick lookup:
   // it's index > it's function's index > threshold
   unsigned order = order_map[F].first;
   if(order > threshold) return false;

   order = indexof(I);
   if(order == UINT_MAX) return true;
   if(order == threshold){
      AssertRuntime(threshold_f == F, "should be same function "<<order<<":"<<threshold);
      return std::less_equal<Instruction>()(I, threshold_inst);
   }
   return order < threshold;
}
bool CGFilter::judgeIns(llvm::Instruction* I, llvm::Instruction* J)
{
   unsigned indexI = indexof(I);
   unsigned indexJ = indexof(J);
   if(indexI == indexJ)
      return std::less<Instruction>()(I,J);
   else
      return indexI < indexJ;
}
