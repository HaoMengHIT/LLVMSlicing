#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <set>
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
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void handleStoreIns();
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
      if(isa<Instruction>(V))
      {
         Instruction* VI = dyn_cast<Instruction>(V);
         if(this->Live.find(VI)!=this->Live.end()) return;
         else
         {
            this->Live.insert(VI);
            errs()<<">>>Insert Instruction:\t"<<*VI<<"\n";
            findLives(VI);
         }
      }
   }

   return;
}
void IRSlicer::handleStoreIns()
{
   for(auto ite:this->Live)
   {
      errs()<<"(((((((((((((("<<*(dyn_cast<Instruction>(ite))<<"\n";
      for(User* user:ite->users())
      {
         if(StoreInst* I = dyn_cast<StoreInst>(user))
         {
            errs()<<*I<<"===============================================\n";

            if(this->Live.find(I) == this->Live.end())
            {
               errs()<<">>>Insert Instruction:\t"<<*I<<"\n";
               this->Live.insert(I);
            }
         }
      }
   }
   return;
}
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

bool IRSlicer::runOnModule(Module &M){

   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      errs()<<FB->getName()<<"==========================================\n";
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         errs()<<BB->getName()<<"-----\n";
         auto Term = BB->getTerminator();
         if(isa<BranchInst>(Term)||isa<SwitchInst>(Term)||isa<ReturnInst>(Term)||isa<CallInst>(Term))
         {
            Instruction* TI = dyn_cast<Instruction>(Term);
            if(this->Live.find(TI)!=this->Live.end()) continue;
            else
            {
               this->Live.insert(TI);
               errs()<<">>>Insert Instruction:\t"<<*TI<<"\n";
               findLives(TI);
            }
         }
      }
   }
   handleStoreIns();
   errs()<<this->Live.size()<<"\n";
   deleteIns(M);
   return false;
}
