#include <llvm/Transforms/IPO.h>
#include <llvm/ADT/SmallPtrSet.h>
#include <llvm/ADT/Statistic.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Module.h>
#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/Support/raw_ostream.h>
#include "debug.h"
using namespace llvm;
using namespace std;

namespace lle
{
   class GlobalVarDCE
   {
      public:
         GlobalVarDCE(){}
         bool runOnModule(Module &M);
      private:
         SmallPtrSet<GlobalValue*, 32> AliveGlobals;
         SmallPtrSet<Constant*, 8> SeenConstants;

         /// GlobalIsNeeded - mark the specific global value as needed, and
         /// recursively mark anything that it uses as also needed.
         void GlobalIsNeeded(GlobalValue *GV);
         void MarkUsedGlobalsAsNeeded(Constant *C);

         bool RemoveUnusedGlobalValue(GlobalValue &GV);
   };
}
