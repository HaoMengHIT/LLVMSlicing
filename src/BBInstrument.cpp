#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Operator.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/IR/IRBuilder.h>
#include <set>
#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;
namespace{
   class BBInstrument:public ModulePass
   {
      public:
         static char ID;
         BBInstrument():ModulePass(ID){}
	 void WriteProfile(Module& M, GlobalVariable* CounterArray, unsigned numBlocks, Instruction* outputpos);
         void IncrementCounterInBlock(Module& M, Function::iterator BB, unsigned CounterNum, GlobalVariable* CounterArray);
         bool runOnModule(Module &M) override;
   };
}
char BBInstrument::ID = 0;
static RegisterPass<BBInstrument> X("insert-openmp-profiling","OpenMP 程序的基本块插桩",false,false);

void BBInstrument::WriteProfile(Module& M, GlobalVariable* CounterArray, unsigned numBlocks, Instruction* outputpos)
{
	IRBuilder<> Builder(outputpos);
	return;
}

void BBInstrument::IncrementCounterInBlock(Module& M, Function::iterator BB,unsigned CounterNum, GlobalVariable* CounterArray)
{
   Instruction* InsertPos = BB->getTerminator();
   Type* ETy = Type::getInt64Ty(M.getContext());

   // Create the getelementptr constant expression
   Value* indexList[2] = {ConstantInt::get(ETy, 0),ConstantInt::get(ETy, CounterNum)};


   //Constant *ElementPtr = ConstantExpr::getGetElementPtr(ETy,CounterArray, Indices);
   //GetElementPtrInst* ElementPtr = GetElementPtrInst::Create(ETy, CounterArray, ArrayRef<Value*>(indexList, 2), "arrayIdx",InsertPos );
   IRBuilder<> builder(InsertPos);
   Value* ElementPtr = builder.CreateGEP(CounterArray, ArrayRef<Value*>(indexList,2));

   // Load, increment and store the value back.
   Value* OldVal = builder.CreateLoad(ElementPtr, "OldBBCounter");
   //Value *OldVal = new LoadInst(ElementPtr, "OldBBCounter", InsertPos);
   Value* NewVal = builder.CreateAdd(OldVal, ConstantInt::get(ETy, 1), "NewBBCounter");
   //Value *NewVal = BinaryOperator::Create(Instruction::Add, OldVal, ConstantInt::get(ETy, 1),"NewBBCounter", InsertPos);
   builder.CreateStore(NewVal, ElementPtr);
   //new StoreInst(NewVal, ElementPtr, InsertPos);

   return;
}
bool BBInstrument::runOnModule(Module &M) {
   Function* main = M.getFunction("main");
   if(main == 0)
   {
      errs()<<"Can not find main function\n";
      return false;
   }
   std::set<BasicBlock*> BlocksToInstrument;
   unsigned NumBlocks = 0;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
         NumBlocks++;
      }
   }

   Type *ATy = ArrayType::get(Type::getInt64Ty(M.getContext()), NumBlocks);
   GlobalVariable *Counters =
      new GlobalVariable(M, ATy, false, GlobalValue::InternalLinkage,
            Constant::getNullValue(ATy), "BBCounters");
   //errs()<<*Counters<<"\n";

   unsigned i = 0;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      // Create counter for (0,entry) edge.
      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
      {

         this->IncrementCounterInBlock(M, BB, i++, Counters);
      }
   }

   Instruction *outputpos=nullptr;
   for (inst_iterator I = inst_begin(main), E = inst_end(main); I != E; ++I)
   {
	   if(isa<ReturnInst>(*I))
	   {
		   outputpos = &*I;
		   errs()<<*outputpos<<"\n";
		   WriteProfile(M, Counters, NumBlocks, outputpos);
	   }
   }

   
   return false; 

}
