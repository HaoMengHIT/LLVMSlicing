#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include <list>
#include <tuple>
#include <vector>
#include <unordered_map>
#include <unordered_set>

#include <llvm/Analysis/CallGraph.h>
#include <llvm/ADT/PointerUnion.h>
#include <set>
#include <map>
#include <iostream>
#include "ReachingDef.h"
#include "debug.h"
#include "GlobalVarDCE.h"
#include "CGFilter.h"
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
         CGFilter* CGF;
         GlobalVarDCE* GDce;
         void getReachDefStoreIns(Instruction* I, std::set<Value*>& storeInsSet);
         void deleteNoUsedFunc(Module &M);
         bool addInsToLive(Instruction* I);
         void findAllRelatedIns(Instruction* I);
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void interFunction(Function* M,bool isRetUsed);
         void printUses(Instruction* I);
   };
}

