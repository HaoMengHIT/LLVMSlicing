#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Operator.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <set>
#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;
namespace{
   class MyTest:public FunctionPass
   {
      public:
         static char ID;
         MyTest():FunctionPass(ID){}
         bool runOnFunction(Function &F) override;
   };
}
char MyTest::ID = 0;
static RegisterPass<MyTest> X("MyTest","My Test",false,false);
bool MyTest::runOnFunction(Function &F) {
   if(F.isDeclaration())
      return false;
   errs()<<"================"<<F.getName()<<"\n";
   //F.print(llvm::errs());
   errs()<<F<<"\n";
   return false; 
}

