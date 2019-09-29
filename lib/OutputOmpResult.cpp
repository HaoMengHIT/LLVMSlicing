#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <iomanip>
#include <queue>
#include <sys/sysinfo.h>
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
   class OutputOmpResult : public ModulePass{
      public:
         static char ID;//pass Identification

         OutputOmpResult():ModulePass(ID){}
         bool runOnModule(Module &M) override;
   };

}

char OutputOmpResult::ID = 0 ;

//regite pass
static RegisterPass<OutputOmpResult> X("output-omp-results","输出OMP Profile结果",false,false);

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

bool OutputOmpResult::runOnModule(Module &M){

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

   long long NumBlocks = 0;
   vector<long long> EachBBInstNum;
   for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
      if (F->isDeclaration()) continue;
      StringRef fname = F->getName();
      if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
         int forkNum = 0;
         int instNumTmp = 0;
         for(BasicBlock::iterator IB = BB->begin(), IE = BB->end(); IB != IE; ++IB)
         {
            Instruction* ins = &*IB;
            instNumTmp++;
            if(CallInst* CI = dyn_cast<CallInst>(ins))
            {
               Function* callee = CI->getCalledFunction();
               if(callee->getName().startswith("__kmpc_fork_call"))
               {
                  EachBBInstNum.push_back(instNumTmp);
                  instNumTmp=0;
                  NumBlocks++;
               }

            }
         }
         EachBBInstNum.push_back(instNumTmp);
         NumBlocks++;
      }
   }
   errs()<<"#BB: "<<NumBlocks<<"\n";
   int NumCores = get_nprocs_conf();
   errs()<<"Core Num \t "<<NumCores<<"\n";
   errs()<<"BB Num \t" << bbfreq.size()/NumCores<<"\n";

   long long instNum = 0;
   for(int i = 0;i < bbfreq.size();i++)
   {
      instNum += (bbfreq[i]*EachBBInstNum[i%NumBlocks]);
      errs()<< bbfreq[i]<<"\t"<<EachBBInstNum[i%NumBlocks]<<"\n";
   }


   errs()<<"============\n";
   errs()<<"Inst Num \t";
   std::cout<<instNum<<"\t";
   std::cout<<setprecision(5)<<(double)instNum<<std::endl;;
   errs()<<"It's Over!\n";

   return true;
}







