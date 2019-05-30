#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
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
#include <llvm/IR/InstrTypes.h>

using std::string;
using std::vector;
using std::map;
using std::pair;
using namespace std;
using namespace llvm;
namespace{
	class ModuleTest : public ModulePass{
		public:
			static char ID;//pass Identification
         vector<int> isParallel;
         map<Function*, int> parallelRegion;
         bool isBBParallel(BasicBlock * BB);
         void judgeIsParallel(Module &M);

			bool runOnModule(Module &M) override;
	};

}

char ModuleTest::ID = 0 ;

//regite pass
static RegisterPass<ModuleTest> X("module-test","Module Test",false,false);

bool ModuleTest::isBBParallel(BasicBlock * BB)
{
   Function* F = BB->getParent();
   StringRef fname = F->getName();
   if(fname.startswith(".omp_outlined"))
   {
      this->isParallel.push_back(this->parallelRegion[F]);

   }

   return true;
}
void ModuleTest::judgeIsParallel(Module &M)
{
    int regionNum = 1;
    for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
        if (F->isDeclaration()) continue;
        StringRef fname = F->getName();
        if(fname.startswith(".omp_outlined"))
        {
           this->parallelRegion.insert(std::pair<Function*, int>(&*F,regionNum));
           regionNum++;
        }
        if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
           isBBParallel(&*BB);
        }
    }

   return;
}


bool ModuleTest::runOnModule(Module &M){
   errs()<<"Hello world\n";

	return true;
}
