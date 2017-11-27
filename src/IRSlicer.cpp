#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include <set>
#include <map>
#include <vector>
#include <iostream>
#include "ReachingDef.h"
using namespace llvm;
using namespace std;
using namespace lle;

namespace {
   class IRSlicer:public ModulePass{
      public:
         static char ID;
         IRSlicer():ModulePass(ID){}
         bool runOnModule(Module &M) override;
      private:
         set<Instruction*> Live;
         set<Function*> UsedFunc;
         void deleteNoUsedFunc(Module &M);
         bool addInsToLive(Instruction* I);
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void interFunction(Function* M,bool isRetUsed);
   };
}

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
void IRSlicer::findLives(Instruction* I)
{
   for(Use& U:I->operands())
   {
      Value* V = U.get();
      if(isa<Constant>(V)) continue;
      if(isa<LoadInst>(I))
      {
         Use* next = &U;
         do
         {
            auto Tmp = next->getUser();
            if(isa<StoreInst>(Tmp) && Tmp->getOperand(1) == next->get())
            {
               Instruction* ins = dyn_cast<Instruction>(Tmp);
               if(addInsToLive(ins)) findLives(ins);
               break;
            }
         }
         while((next = next->getNext()));
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
      errs()<<">>>Insert Instruction:\t" << *I<<"\n";
      this->Live.insert(I);
      return true;
   }
   return false;
}
/*Deete instructoins which are not in Live set by the order of down-up*/
void IRSlicer::deleteIns(Module &M)
{
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
      {
         Instruction* ins = &*Ite;
         ++Ite;
      }

   }

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
         errs()<<"Deleting instruction "<<*I<<"......\n";
         for(User* user:I->users())
         {
            Instruction* userIns = dyn_cast<Instruction>(user);
            errs()<<*userIns<<"\n";
         }
         I->replaceAllUsesWith(UndefValue::get(I->getType()));
         I->eraseFromParent();
         //I->removeFromParent();
      }

   }
   return;
}
void IRSlicer::deleteNoUsedFunc(Module &M)
{
   for(auto FB = M.begin(),FE = M.end();FB!=FE;)
   {  Function* F = &*FB;
      ++FB;
      if(this->UsedFunc.find(F) == this->UsedFunc.end())
      {
         errs()<<"Deleting function "<<F->getName()<<"\n";
         M.getFunctionList().erase(F);
      }
   }
   return;
}
void IRSlicer::interFunction(Function* FB, bool isRetUsed)
{
   this->UsedFunc.insert(FB);
   if(FB->isDeclaration()) return;
   errs()<<"Strat dealing functoin "<<FB->getName()<<"\n" ;     
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(ReturnInst* RI = dyn_cast<ReturnInst>(ins))
      {
         if(isRetUsed == false)
         {
            Value* Ret = RI->getReturnValue(); 
            ReturnInst* newRet = ReturnInst::Create(FB->getContext(), UndefValue::get(Ret->getType()));
            BasicBlock::iterator ii(RI);
            ReplaceInstWithInst(RI->getParent()->getInstList(),ii,newRet);
            addInsToLive(newRet);
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
         for(User* U:CI->users())
         {
            if(Instruction* I = dyn_cast<Instruction>(U))
            {
               if(this->Live.find(I) != this->Live.end())
               {
                  interFunction(callee,true);
                  break;
               }
            }
         }
      }
   }
  
   return;
}

bool IRSlicer::runOnModule(Module &M){

   ReachingDefinitions RDef;
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      RDef.dealFunction(*FB);
   }
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      errs()<<FB->getName()<<"==========================================\n";
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         errs()<<BB->getName()<<"-----\n";
         auto Term = BB->getTerminator();
         if(isa<BranchInst>(Term)||isa<SwitchInst>(Term))
         {
            Instruction* TI = dyn_cast<Instruction>(Term);
            if(addInsToLive(TI)) findLives(TI);
            else continue;
         }
      }
   }
   errs()<<this->Live.size()<<"\n";
   interFunction(M.getFunction("main"),false);
   errs()<<this->Live.size()<<"\n";
   deleteIns(M);
   deleteNoUsedFunc(M);
   return false;
}
