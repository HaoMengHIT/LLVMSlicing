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
#include <sys/sysinfo.h>

using namespace llvm;
using namespace std;
namespace{
   class BBProfiling:public ModulePass
   {
      public:
         static char ID;
         Function* hook;
         long NumBlocks; 
         BBProfiling():ModulePass(ID){}
         void WriteProfile(Module& M, GlobalVariable* CounterArray, long arraySize, Instruction* outputpos);
         void IncrementCounterInBlock(Module& M, BasicBlock* BB, unsigned CounterNum, GlobalVariable* CounterArray);
         bool runOnModule(Module &M) override;
   };
}
char BBProfiling::ID = 0;
static RegisterPass<BBProfiling> X("insert-BB-profiling","串行程序的基本块插桩",false,false);

void BBProfiling::IncrementCounterInBlock(Module& M, BasicBlock* BB, unsigned CounterNum, GlobalVariable* CounterArray)
{
    Instruction* InsertPos = BB->getTerminator();
    Type* ETy = Type::getInt64Ty(M.getContext());
    // Create the getelementptr constant expression
    while (isa<AllocaInst>(InsertPos))
       ++InsertPos;

    IRBuilder<> builder(InsertPos);

    Value* indexList[2] = {ConstantInt::get(ETy, 0), ConstantInt::get(ETy,CounterNum)};
    Value* ElementPtr = builder.CreateGEP(CounterArray, ArrayRef<Value*>(indexList,2));
    Value* OldVal = builder.CreateLoad(ElementPtr, "OldBBCounter");
    Value* NewVal = builder.CreateAdd(OldVal, ConstantInt::get(ETy, 1), "NewBBCounter");
    builder.CreateStore(NewVal, ElementPtr);

    return;
}

static Value* castoff(Value* v)
{
   if(ConstantExpr* CE = dyn_cast<ConstantExpr>(v))
   {
      v = CE->getAsInstruction();
   }

   if(CastInst* CI = dyn_cast<CastInst>(v)){
      return castoff(CI->getOperand(0));
   }else
      return v;
}

void BBProfiling::WriteProfile(Module& M, GlobalVariable* CounterArray,long arraySize, Instruction* outputpos)
{
   IRBuilder<> Builder(outputpos);
   Type* ETy = Type::getInt64Ty(M.getContext());
   Value* indexList[2] = {ConstantInt::get(ETy, 0),ConstantInt::get(ETy, 0)};
   Value* ElementPtr = Builder.CreateGEP(CounterArray, ArrayRef<Value*>(indexList,2));
   Value* fArgs[2] = {ElementPtr, ConstantInt::get(ETy, arraySize)};
   CallInst* callInst = Builder.CreateCall(hook,ArrayRef<Value*>(fArgs,2));
   return;
}

bool BBProfiling::runOnModule(Module &M) {
   Function* main = M.getFunction("main");
   if(main == 0)
   {
      errs()<<"Can not find main function\n";
      return false;
   }
   Function* writeFunc = nullptr;
   for(Module::iterator F = M.begin(), E = M.end(); F!=E;++F)
   {
      if(F->isDeclaration()) continue;
      StringRef fname = F->getName();
      if (fname.find("WriteOpenMPProfile")!=fname.npos) writeFunc = &*F;

   }

   hook = writeFunc;

   std::set<BasicBlock*> BlocksToInstrument;
   NumBlocks = 0;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      StringRef fname = F->getName();
      if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
            NumBlocks++;
      }
   }
   errs()<<"#BB: "<<NumBlocks<<"\n";

   Type *ATy = ArrayType::get(Type::getInt64Ty(M.getContext()), NumBlocks);
   GlobalVariable *Counters =
      new GlobalVariable(M, ATy, false, GlobalValue::InternalLinkage,
            Constant::getNullValue(ATy), "BBCounters");

   unsigned i = 0;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      StringRef fname = F->getName();
      if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;

      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
      {
         this->IncrementCounterInBlock(M, &*BB, i++, Counters);
      }
   }

   Instruction *outputpos=nullptr;
   for (inst_iterator I = inst_begin(main), E = inst_end(main); I != E; ++I)
   {
      if(isa<ReturnInst>(*I))
      {
         outputpos = &*I;
         errs()<<*outputpos<<"\n";
         WriteProfile(M, Counters,NumBlocks, outputpos);
         break;
      }
   }
   errs()<<"It's Over!\n";


   return false; 

}
