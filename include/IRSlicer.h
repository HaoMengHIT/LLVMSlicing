#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include <set>
#include <map>
#include <vector>
#include <iostream>
#include "ReachingDef.h"
#include "debug.h"
using namespace llvm;
using namespace std;
using namespace lle;

namespace lle {
   class IRSlicer:public ModulePass{
      public:
         static char ID;
         IRSlicer():ModulePass(ID){}
         bool runOnModule(Module &M) override;
      private:
         set<Instruction*> Live;
         set<Function*> UsedFunc;
         ReachingDefinitions RDef; 
         void getReachDefStoreIns(Instruction* I, std::set<Value*>& storeInsSet);
         void deleteNoUsedFunc(Module &M);
         bool addInsToLive(Instruction* I);
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void interFunction(Function* M,bool isRetUsed);
   };
}

