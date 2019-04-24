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
			BBInstrument():ModulePass(ID){}
			void WriteProfile(Module& M, GlobalVariable* CounterArray, long arraySize, Instruction* outputpos);
			void IncrementCounterInBlock(Module& M, Function::iterator BB, unsigned CounterNum, GlobalVariable* CounterArray);
			bool runOnModule(Module &M) override;
	};
}
char BBInstrument::ID = 0;
static RegisterPass<BBInstrument> X("insert-openmp-profiling","OpenMP 程序的基本块插桩",false,false);

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

void BBInstrument::IncrementCounterInBlock(Module& M, Function::iterator BB,unsigned CounterNum, GlobalVariable* CounterArray)
{
	Instruction* InsertPos = BB->getTerminator();
	Type* ETy = Type::getInt64Ty(M.getContext());
	// Create the getelementptr constant expression
	Value* indexList[2] = {ConstantInt::get(ETy, 0),ConstantInt::get(ETy, CounterNum)};

	IRBuilder<> builder(InsertPos);
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

	Constant *FuncEntry = M.getOrInsertFunction(writeFunc->getName(),Type::getVoidTy(M.getContext()),(Type*)0);
	hook = cast<Function>(FuncEntry);
	hook = writeFunc;

	std::set<BasicBlock*> BlocksToInstrument;
	unsigned NumBlocks = 0;
	for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		if (F->isDeclaration()) continue;
		for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
			NumBlocks++;
		}
	}
	int NumCores = get_nprocs_conf();

	Type *ATy = ArrayType::get(Type::getInt64Ty(M.getContext()), NumCores*NumBlocks);
	GlobalVariable *Counters =
		new GlobalVariable(M, ATy, false, GlobalValue::InternalLinkage,
				Constant::getNullValue(ATy), "BBCounters");
	//errs()<<*Counters<<"\n";

	unsigned i = 0;
	for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		if (F->isDeclaration()) continue;
		StringRef fname = F->getName();
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
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
			WriteProfile(M, Counters,NumCores*NumBlocks, outputpos);
			break;
		}
	}
	errs()<<get_nprocs_conf()<<"\n";


	return false; 

}
