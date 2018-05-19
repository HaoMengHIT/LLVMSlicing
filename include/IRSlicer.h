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
using namespace llvm;
using namespace std;
using namespace lle;

namespace lle {
   struct CGFilter
   {
      struct Record {
         unsigned first, last; // range [first, last)
         llvm::CallGraphNode* second;
      };
      llvm::DenseMap<llvm::Function*, Record> order_map;
      std::set<llvm::Value*> Only; // ignore repeat call
      unsigned threshold;
      llvm::Instruction* threshold_inst;
      llvm::Function* threshold_f;
      llvm::CallGraphNode* root;
      CGFilter(llvm::CallGraphNode* main, llvm::Instruction* threshold=nullptr);
      unsigned indexof(llvm::Instruction*);
      void update(llvm::Instruction* threshold);
      bool judgeIns(llvm::Instruction* I, llvm::Instruction* J);
      bool count(llvm::Function* F) {
         return order_map.count(F);
      }
      bool operator()(llvm::Use*);
   };
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
         void getReachDefStoreIns(Instruction* I, std::set<Value*>& storeInsSet);
         void deleteNoUsedFunc(Module &M);
         bool addInsToLive(Instruction* I);
         void findLives(Instruction* I);
         void deleteIns(Module &M);
         void interFunction(Function* M,bool isRetUsed);
         void printUses(Instruction* I);
   };
}

namespace std{
   // return true only if BasicBlock L is 'before' R
   template <>
      struct less<llvm::BasicBlock>
      {
         bool operator()(llvm::BasicBlock*, llvm::BasicBlock* );
      };
   // return true only if Instruction L is 'before' R
   // @note:
   //    you should only use std::less<Instruction>()(L, R)
   //    rather than !std::less<Instruction>()(R, L)
   //    because when it unknow, it would also return false
   template <>
      struct less<llvm::Instruction>
      {
         bool operator()(llvm::Instruction*, llvm::Instruction* );
      };
   // a safe replacement for !std::less<Instruction>()(L, R) // L >= R
   // using std::less_equal<Instruction>()(R, L) R <= L
   template <>
      struct less_equal<llvm::Instruction>
      {
         bool operator()(llvm::Instruction*, llvm::Instruction* );
      };
}
