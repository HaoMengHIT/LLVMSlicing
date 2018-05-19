#include "IRSlicer.h"
#include <llvm/ADT/DepthFirstIterator.h>
#include <llvm/ADT/PostOrderIterator.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/Operator.h>

char IRSlicer::ID = 0;
static RegisterPass<IRSlicer> X("IRSlicer","LLVM IR Slicing Pass", false, false);

Value* castoff(Value* v)
{
   if(ConstantExpr* CE = dyn_cast<ConstantExpr>(v))
      v = CE->getAsInstruction();

   if(CastInst* CI = dyn_cast<CastInst>(v)){
      return castoff(CI->getOperand(0));
   }else
      return v;
}
/*
 * getReachDefStoreIns:
 *
 * This method can find all store instructions before current load instruction
 *
 * For example
 *    BB1:
 *       ...
 *       store i32 0, i32* %i, align 4
 *       ...
 *       br BB2
 *
 *    BB2:
 *       ...
 *       load i32* %i, align 4
 *       ...
 *
 *    BBn:
 *       ...
 *       store i32 %inc, i32* %i, align 4
 *       ...
 *       br BB2
 */
void IRSlicer::getReachDefStoreIns(Instruction* I, std::set<Value*>& storeInsSet)
{
   std::set<Value*>& reachTmp = this->RDef.InsReach[I];
   for(Use& U:I->operands())
   {
      Value* V = U.get();
      for(auto Ins:reachTmp)
      {
         if(StoreInst* SI = dyn_cast<StoreInst>(&*Ins))
         {
            if(V == SI->getOperand(1))
            {
               storeInsSet.insert(SI);
            }
         }
      }

   }
   return;
}

/*
 * findLives:
 *
 * This method can find all instructions on which the current instruction is dependent. 
 */
void IRSlicer::findLives(Instruction* I)
{
   //handle global variable
   //Example:
   //@sum = global i32 0, align 4
   //...
   //call func()    include:  store i32 %12, i32* @sum, align 4
   //...
   //%9 = load i32, i32* @sum, align 4
   //
   //Handle global GEP variable
   //Example:
   //@sum = global [2 x i32] zeroinitializer, align 4
   //...
   //call func()   include:  store i32 %12, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
   //...
   //%2 = load i32, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
   if(isa<LoadInst>(I))
   {
      for (User::op_iterator i = I->op_begin(), e = I->op_end(); i != e; ++i) {
         Value* v = i->get();
         if(isa<GlobalVariable>(v)||isa<GEPOperator>(v))
         {
            errs() << "-----" << *v << "\n"; 
            for(Value::use_iterator j = v->use_begin(), je = v->use_end();j!=je;)
            {
               Use* U = &*j;
               ++j;
               Value* vj = dyn_cast<Value>(U->getUser());
               Instruction* Itmp = dyn_cast<Instruction>(vj);
               if(isa<StoreInst>(Itmp) && CGF->judgeIns(Itmp, I))
                  if(addInsToLive(Itmp)) findLives(Itmp);
                  //errs()<<*vj<<"\n";
            }
         }
      }
   }


   for(Use& U:I->operands())
   {
      Value* V = U.get();

      if(isa<Constant>(V)) continue;
      else if(isa<LoadInst>(I))
      {
         std::set<Value*> reachStore;
         //Apply reaching-definition method to get all store instructions before current load instruction.
         getReachDefStoreIns(I, reachStore);
         for(auto tmp:reachStore)
         {
            Instruction* si = dyn_cast<Instruction>(&*tmp);
            if(addInsToLive(si)) findLives(si);
         }


      }
      if(isa<Instruction>(V))
      {
         Instruction* VI = dyn_cast<Instruction>(V);
         if(addInsToLive(VI)) findLives(VI);
         else return;
      }
   }

   return;
}
bool IRSlicer::addInsToLive(Instruction* I)
{
   if(this->Live.find(I) == this->Live.end())
   {
      DEBUG(errs()<<">>>Insert Instruction:\t" << *I<<"\n");
      this->Live.insert(I);
      return true;
   }
   return false;
}

/*
 * deleteIns:
 * This method can delete instructoins which are not in Live set by the order of down-up
 * */
void IRSlicer::deleteIns(Module &M)
{
   vector<Instruction*> worklist; 
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            Instruction* I = dyn_cast<Instruction>(IB);
            worklist.push_back(I);
         }
   for(int i = worklist.size()-1;i>=0;i--)
   {
      Instruction* I = worklist[i];
      if(this->Live.find(I) == this->Live.end())
      {
         DEBUG(errs()<<"Deleting instruction "<<*I<<"......\n");
         for(User* user:I->users())
         {
            Instruction* userIns = dyn_cast<Instruction>(user);
            DEBUG(errs()<<*userIns<<"\n");
         }
         I->replaceAllUsesWith(UndefValue::get(I->getType()));
         I->eraseFromParent();
         //I->removeFromParent();
      }

   }
   return;
}
/*
 * deleteNoUsedFunc:
 * This method can delete all functions of which return results are not used in other functions.
 */
void IRSlicer::deleteNoUsedFunc(Module &M)
{
   for(auto FB = M.begin(),FE = M.end();FB!=FE;)
   {  Function* F = &*FB;
      ++FB;
         errs()<<"Deleting function "<<F->getName()<<"\n";
      //Contain Not declaration function and delete noused declaration function 
      //if(this->UsedFunc.find(F) == this->UsedFunc.end() && F->isDeclaration())
      if(this->UsedFunc.find(F) == this->UsedFunc.end())
      {
         DEBUG(errs()<<"Deleting function "<<F->getName()<<"\n");
         M.getFunctionList().erase(F);
      }
   }
   return;
}

/*
 * interFunction:
 * This method is used to judge whether the the return value of current function is used in other functions.
 * If not, replace the return value by undef value, 
 * otherwise, store the return instruction and its dependent instructions into Live set.
 */
void IRSlicer::interFunction(Function* FB, bool isRetUsed)
{
   this->UsedFunc.insert(FB);
   if(FB->isDeclaration()) return;
   DEBUG(errs()<<"Strat dealing functoin "<<FB->getName()<<"\n");     
   errs()<<"Strat dealing functoin "<<FB->getName()<<"\n";     
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(ReturnInst* RI = dyn_cast<ReturnInst>(ins))
      {
         errs()<<*RI<<"-------------\n";
         if(isRetUsed == false)
         {
            Value* Ret = RI->getReturnValue(); 
            if(Ret != NULL)
            {
            errs()<<*Ret<<"\n";
               ReturnInst* newRet = ReturnInst::Create(FB->getContext(), UndefValue::get(Ret->getType()));
               BasicBlock::iterator ii(RI);
               ReplaceInstWithInst(RI->getParent()->getInstList(),ii,newRet);
               addInsToLive(newRet);
            }
            else
            {
               addInsToLive(RI);
            }
         }
         else
         {
            if(addInsToLive(ins)) findLives(ins);
         }
      }
   }
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(CallInst* CI = dyn_cast<CallInst>(ins))
      {
         Function* callee = CI->getCalledFunction();
         bool isUsed = false;
         for(User* U:CI->users())
         {
            if(Instruction* I = dyn_cast<Instruction>(U))
            {
               if(this->Live.find(I) != this->Live.end())
               {
                  isUsed = true;
                  interFunction(callee,isUsed);
                  break;
               }
            }
         }
         if(!isUsed)
         {
            interFunction(callee,isUsed);
         }
      }
   }

   return;
}

void IRSlicer::printUses(Instruction* I)
{
   //unsigned us = CGF->indexof(I);
   //errs()<<">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"<<*I<<"\n";
   //errs()<<us<<"\n";
}

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

bool IRSlicer::runOnModule(Module &M){
   CallGraph CG(M);
   Function* Main = M.getFunction("main");
   auto root = Main?CG[Main]:CG.getExternalCallingNode();
   CGF = new CGFilter(root,NULL);

   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      this->RDef.dealFunction(*FB);
   }
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      DEBUG(errs()<<FB->getName()<<"==========================================\n");
      errs()<<FB->getName()<<"==========================================\n";
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         DEBUG(errs()<<BB->getName()<<"-----\n");
         auto Term = BB->getTerminator();
         if(isa<BranchInst>(Term)||isa<SwitchInst>(Term))
         {
            Instruction* TI = dyn_cast<Instruction>(Term);
            if(addInsToLive(TI)) findLives(TI);
            else continue;
         }
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            printUses(&*IB);
            if(CallInst* CI = dyn_cast<CallInst>(IB))
            {
               Function* callee = CI->getCalledFunction();
               if(!(callee->isDeclaration()))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
            }

         }
      }
   }
   errs()<<"Hello world\n";
   DEBUG(errs()<<this->Live.size()<<"\n");
   interFunction(M.getFunction("main"),false);
   DEBUG(errs()<<this->Live.size()<<"\n");
   deleteIns(M);
   errs()<<"Function Over!\n";
   deleteNoUsedFunc(M);
   return false;
}
