#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <set>
#include <iostream>

using namespace llvm;
using namespace std;
namespace{
   class Test:public ModulePass
   {
      public:
         static char ID;
         Test():ModulePass(ID){}
         bool runOnModule(Module &M) override;
   };
}
char Test::ID = 0;
static RegisterPass<Test> X("Test","My Test",false,false);
bool Test::runOnModule(Module &M){
   int IRCount = 0;
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            IRCount++;
            if(LoadInst* LI = dyn_cast<LoadInst>(IB))
            {
               errs()<<"=======\t"<<*LI<<"\n";
               for(Use& U:LI->operands())
               {
                  User* user = U.getUser();
                  auto next = U.getNext();
                  Instruction* ins = dyn_cast<Instruction>(next);
                  errs()<<*ins<<"\n";
               }
            }

         }
      }
   }
   errs()<<">>>>>>>>>>>>> Instruction Count: "<<IRCount<<"\n";
   return false;
}
