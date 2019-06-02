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
    class BBInstrument:public ModulePass
    {
        public:
            static char ID;
            Function* hook;
            Function* coreFunc;
            CallInst* coreGet;
            long NumBlocks; 
            BBInstrument():ModulePass(ID){}
            void WriteProfile(Module& M, GlobalVariable* CounterArray, long arraySize, Instruction* outputpos);
            void IncrementCounterInBlock(Module& M, Instruction* InsertPos, long CounterNum, GlobalVariable* CounterArray);
            void GetCoreNum(Module& M, Instruction* outputpos);
            bool runOnModule(Module &M) override;
    };
}
char BBInstrument::ID = 0;
static RegisterPass<BBInstrument> X("insert-openmp-profiling","OpenMP 程序的基本块插桩",false,false);

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
void BBInstrument::GetCoreNum(Module& M, Instruction* outputpos)
{
    Type* ETy = Type::getInt64Ty(M.getContext());
    // Create the getelementptr constant expression

    IRBuilder<> builder(outputpos);
    coreGet = builder.CreateCall(coreFunc);

    return;
}

void BBInstrument::WriteProfile(Module& M, GlobalVariable* CounterArray,long arraySize, Instruction* outputpos)
{
    IRBuilder<> Builder(outputpos);
    Type* ETy = Type::getInt64Ty(M.getContext());
    Value* indexList[2] = {ConstantInt::get(ETy, 0),ConstantInt::get(ETy, 0)};
    Value* ElementPtr = Builder.CreateGEP(CounterArray, ArrayRef<Value*>(indexList,2));
    Value* fArgs[2] = {ElementPtr, ConstantInt::get(ETy, arraySize)};
    CallInst* callInst = Builder.CreateCall(hook,ArrayRef<Value*>(fArgs,2));
    return;
}

void BBInstrument::IncrementCounterInBlock(Module& M, Instruction* InsertPos, long CounterNum, GlobalVariable* CounterArray)
{
    //Instruction* InsertPos = BB->getTerminator();
    Type* ETy = Type::getInt64Ty(M.getContext());
    // Create the getelementptr constant expression

    IRBuilder<> builder(InsertPos);

    //CallInst* coreFuncCall = builder.CreateCall(coreFunc);
    Value* Val0 = builder.CreateSExt(coreGet, ETy, "IndexSExt");
    Value* Val1 = builder.CreateMul(Val0,ConstantInt::get(ETy, NumBlocks),"IndexValMul");
    Value* Val2 = builder.CreateAdd(Val1,ConstantInt::get(ETy,CounterNum),"IndexValAdd");

    Value* indexList[2] = {ConstantInt::get(ETy, 0), Val2};
    //Value* indexList[2] = {ConstantInt::get(ETy, 0), ConstantInt::get(ETy,CounterNum)};
    Value* ElementPtr = builder.CreateGEP(CounterArray, ArrayRef<Value*>(indexList,2));
    Value* OldVal = builder.CreateLoad(ElementPtr, "OldBBCounter");
    Value* NewVal = builder.CreateAdd(OldVal, ConstantInt::get(ETy, 1), "NewBBCounter");
    builder.CreateStore(NewVal, ElementPtr);

    return;
}
bool BBInstrument::runOnModule(Module &M) {
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
    Constant* coreConstant = M.getOrInsertFunction("sched_getcpu",Type::getInt32Ty(M.getContext()));
    coreFunc = cast<Function>(coreConstant);

    errs()<<*coreFunc<<"\n";

    std::set<BasicBlock*> BlocksToInstrument;
    NumBlocks = 0;
    for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
        if (F->isDeclaration()) continue;
        StringRef fname = F->getName();
        if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
            int forkNum = 0;
            for(BasicBlock::iterator IB = BB->begin(), IE = BB->end(); IB != IE; ++IB)
            {
                Instruction* ins = &*IB;
                if(CallInst* CI = dyn_cast<CallInst>(ins))
                {
                    Function* callee = CI->getCalledFunction();
                    if(callee->getName().startswith("__kmpc_fork_call"))
                    {
                        forkNum++;
                    }

                }
            }
            NumBlocks+=(forkNum+1);
        }
    }
    errs()<<"#BB: "<<NumBlocks<<"\n";
    int NumCores = get_nprocs_conf();

    Type *ATy = ArrayType::get(Type::getInt64Ty(M.getContext()), NumCores*NumBlocks);
    GlobalVariable *Counters =
        new GlobalVariable(M, ATy, false, GlobalValue::InternalLinkage,
                Constant::getNullValue(ATy), "BBCounters");

    unsigned i = 0;
    for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
        if (F->isDeclaration()) continue;
        StringRef fname = F->getName();
        if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
        
        BasicBlock* firstBB  = &*(F->begin());
        Instruction* firstInsOfBB = &*(firstBB->begin());
        this->GetCoreNum(M, firstInsOfBB);
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
        {
            BasicBlock::iterator beginIte = BB->begin();
            Instruction* beginInst = &*beginIte;
            if(CallInst* isGetCPU = dyn_cast<CallInst>(beginInst))
            {

                  Function* callee = dyn_cast<Function>(isGetCPU->getCalledValue()->stripPointerCasts());
                  if(callee->getName().startswith("sched_getcpu"))
                  {
                     ++beginIte;
                     beginInst = &*(beginIte);
                  }
            }
            else
            {
               while(isa<PHINode>(&*beginIte))
               {
                  ++beginIte;
               }
               beginInst = &*(beginIte);
            }
            this->IncrementCounterInBlock(M, beginInst, i++, Counters);
            for(BasicBlock::iterator IB = BB->begin(), IE = BB->end(); IB != IE; ++IB)
            {
                Instruction* ins = &*IB;
                if(CallInst* CI = dyn_cast<CallInst>(ins))
                {
                    Function* callee = dyn_cast<Function>(CI->getCalledValue()->stripPointerCasts());
                    //Function* callee = CI->getCalledFunction();
                    if(callee->getName().startswith("__kmpc_fork_call"))
                    {
                        errs()<<*CI<<"\n";
                        ++IB;
                        Instruction* nextIns = &*IB;
                        this->GetCoreNum(M,nextIns);
                        this->IncrementCounterInBlock(M, nextIns, i++, Counters);
                        --IB;

                    }

                }
            }
        }
    }

    Instruction *outputpos=nullptr;
    for (inst_iterator I = inst_begin(main), E = inst_end(main); I != E; ++I)
    {
        if(isa<ReturnInst>(*I))
        {
            outputpos = &*I;
            errs()<<*outputpos<<"\n";
            WriteProfile(M, Counters,NumCores*NumBlocks, outputpos);
            break;
        }
    }
    errs()<<get_nprocs_conf()<<"\n";


    return false; 

}
