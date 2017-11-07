#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <set>
#include <map>
#include <vector>
#include <iostream>
using namespace llvm;
using namespace std;

namespace{
   class IRSlicer:public ModulePass{
      public:
         static char ID;
         IRSlicer():ModulePass(ID){}
         bool runOnModule(Module &M) override;
      private:
         set<Instruction*> Live;
         map<BasicBlock*,int> BBMap;
         map<Instruction*, int> IMap;
         void constructMap(Module& M);
         bool addInsToLive(Instruction* I);
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void handleStoreIns();
         void handleCallIns(Module &M);
         void interFunction(Module &M);
   };
}

char IRSlicer::ID = 0;
static RegisterPass<IRSlicer> X("IRSlicer","LLVM IR Slicing Pass", false, false);

void IRSlicer::constructMap(Module &M)
{
   return;
}

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
      if(isa<Instruction>(V))
      {
         Instruction* VI = dyn_cast<Instruction>(V);
         if(addInsToLive(VI)) findLives(VI);
         else return;
      }
   }

   return;
}
/*Handle store instructions*/
void IRSlicer::handleStoreIns()
{
   errs()<<"Handle store instruction!!!\n";
   for(auto ite:this->Live)
   {
      for(User* user:ite->users())
      {
         if(StoreInst* I = dyn_cast<StoreInst>(user))
         {
            if(ite != I->getOperand(1)) continue;
            auto firstOp = I->getOperand(0);
            if(addInsToLive(I))
            {
               if(isa<Constant>(I->getOperand(0)))
               {
                  errs()<<*firstOp<<"\n";
                  continue;
               }
               else
               {
                  Instruction* firstOpIns = dyn_cast<Instruction>(firstOp);
                  if(addInsToLive(firstOpIns)) findLives(firstOpIns);
               }
            }
         }
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
/*Handle inter-function cases*/
void IRSlicer::handleCallIns(Module &M)
{
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            if(CallInst* CI = dyn_cast<CallInst>(IB))
            {
               for(User* user:CI->users())
               {
                  if(StoreInst* I = dyn_cast<StoreInst>(user))
                  {
                     if(addInsToLive(CI))
                     {
                        vector<Use*> CIUse;
                        for(Use& U:CI->operands())
                        {
                           Use* tmp = &U;
                           CIUse.push_back(tmp);
                        }
                        errs()<<CIUse.size()<<"\n";
                        for(int i = 0;i < CIUse.size()-1;i++)
                        {
                           Instruction* ins = dyn_cast<Instruction>(CI->getOperand(i));
                           if(addInsToLive(ins)) findLives(ins);
                        }
                     }
                     Instruction* secondOp = dyn_cast<Instruction>(I->getOperand(1));
                     addInsToLive(secondOp);
                  }
               }
            }
         }
   return ;
}
/*Deete instructoins which are not in Live set by the order of down-up*/
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
         errs()<<"Deleting instruction "<<*I<<"......\n";
         for(User* user:I->users())
         {
            errs()<<*user<<"\n";
         }
         I->eraseFromParent();
      }

   }
   return;
}
void IRSlicer::interFunction(Module &M)
{
   for(auto FB = M.begin(),FE = M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      errs()<<"Strat dealing functoin "<<FB->getName()<<"\n" ;     
      if(FB->getName() == "main")
      {
         for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
            for(auto IB = BB->begin(),IE = BB->end();IB!=IE;++IB)
            {
               auto Ins = IB;
               ReturnInst* RI = dyn_cast<ReturnInst>(IB);
               if(RI == NULL) continue;
               Value* Ret = RI->getReturnValue(); 
               ReturnInst* newRet = ReturnInst::Create(FB->getContext(), UndefValue::get(Ret->getType()), RI->getParent());
               Ins->eraseFromParent();
               addInsToLive(newRet);
            }
      }
   }
   errs()<<"ok\n";
   return;
}

bool IRSlicer::runOnModule(Module &M){

   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
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
   //   handleStoreIns();
   //   handleCallIns(M);
   errs()<<this->Live.size()<<"\n";
   interFunction(M);
   errs()<<this->Live.size()<<"\n";
   deleteIns(M);
   return false;
}
