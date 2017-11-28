#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <set>
#include <map>

#include "DataFlow.h"

using namespace llvm;

namespace lle{

   class ReachingDefinitionsDataFlow : public DataFlow {

      protected:
         BitVector applyMeet(std::vector<BitVector> meetInputs); 

         TransferResult applyTransfer(const BitVector& value, DenseMap<Value*, int> domainEntryToValueIdx, BasicBlock* block); 
   };

   class ReachingDefinitions {
      public:

         ReachingDefinitions() {}
         std::map<Value*, std::set<Value*> > InsReach; 

         void dealFunction(Function& F);
   };

}
