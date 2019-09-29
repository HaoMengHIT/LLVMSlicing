#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <iomanip>
#include <queue>
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
#include <llvm/Analysis/CallGraph.h>

using namespace std;
using namespace llvm;
namespace{
	class OutputResult : public ModulePass{
		public:
			static char ID;//pass Identification

         OutputResult():ModulePass(ID){}
			bool runOnModule(Module &M) override;
	};

}

char OutputResult::ID = 0 ;

//regite pass
static RegisterPass<OutputResult> X("output-results","输出Profile结果",false,false);

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

bool OutputResult::runOnModule(Module &M){

   char* profileName = getenv("HM_PROFILE");
   if(profileName == NULL || strlen(profileName) == 0)
   {
      errs()<<"Empty, or can not find this file!\n";
      return false;
   }

   Function* main = M.getFunction("main");
   if(main == 0)
   {
      errs()<<"Can not find main function\n";
      return false;
   }

   ifstream data(profileName);
   vector<long long> bbfreq;
   string line;
   while(getline(data,line))
   {
      stringstream ss;
      ss << line;
      if(!ss.eof())
      {
         long long temp;
         while(ss >> temp)
            bbfreq.push_back(temp);
      }
   }

   unsigned i = 0;
   long long instNum = 0;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      StringRef fname = F->getName();
      if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;

      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
      {
         std::cout<<setprecision(5);
         errs()<<"#BB "<<i<<"\t" << (double)bbfreq[i]<<"\n";
         long long instBB = 0;
         for(BasicBlock::iterator I = BB->begin(), IE = BB->end(); I != IE; ++I)
         {
            instBB++;
         }
         instNum += (bbfreq[i]*instBB);

         i++;
      }
   }
   errs()<<"============\n";
   errs()<<"Inst Num \t";
   std::cout<<instNum<<"\t";
   std::cout<<setprecision(5)<<(double)instNum<<std::endl;;
   errs()<<"It's Over!\n";


	return true;
}







