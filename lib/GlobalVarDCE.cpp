#include <llvm/Transforms/IPO.h>
#include <llvm/ADT/SmallPtrSet.h>
#include <llvm/ADT/Statistic.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Module.h>
#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include "GlobalVarDCE.h"
using namespace llvm;
using namespace std;
using namespace lle;


bool GlobalVarDCE::runOnModule(Module &M) {
   bool Changed = false;

   // Loop over the module, adding globals which are obviously necessary.
   for (Module::iterator I = M.begin(), E = M.end(); I != E; ++I) {
      Changed |= RemoveUnusedGlobalValue(*I);
      // Functions with external linkage are needed if they have a body
      if (!I->isDiscardableIfUnused() &&
            !I->isDeclaration() && !I->hasAvailableExternallyLinkage())
         GlobalIsNeeded(&*I);
   }

   for (Module::global_iterator I = M.global_begin(), E = M.global_end();
         I != E; ++I) {
      Changed |= RemoveUnusedGlobalValue(*I);
      // Externally visible & appending globals are needed, if they have an
      // initializer.
      if (!I->isDiscardableIfUnused() &&
            !I->isDeclaration() && !I->hasAvailableExternallyLinkage())
      {
         GlobalIsNeeded(&*I);
      }
   }

   for (Module::alias_iterator I = M.alias_begin(), E = M.alias_end();
         I != E; ++I) {
      Changed |= RemoveUnusedGlobalValue(*I);
      // Externally visible aliases are needed.
      if (!I->isDiscardableIfUnused())
         GlobalIsNeeded(&*I);
   }

   // Now that all globals which are needed are in the AliveGlobals set, we loop
   // through the program, deleting those which are not alive.
   //

   // The first pass is to drop initializers of global variables which are dead.
   std::vector<GlobalVariable*> DeadGlobalVars;   // Keep track of dead globals
   for (Module::global_iterator I = M.global_begin(), E = M.global_end();
         I != E; ++I)
      if (!AliveGlobals.count(&*I)) {
         DeadGlobalVars.push_back(&*I);         // Keep track of dead globals
         I->setInitializer(0);
      }

   // The second pass drops the bodies of functions which are dead...
   std::vector<Function*> DeadFunctions;
   for (Module::iterator I = M.begin(), E = M.end(); I != E; ++I)
      if (!AliveGlobals.count(&*I)) {
         DeadFunctions.push_back(&*I);         // Keep track of dead globals
         if (!I->isDeclaration())
            I->deleteBody();
      }

   // The third pass drops targets of aliases which are dead...
   std::vector<GlobalAlias*> DeadAliases;
   for (Module::alias_iterator I = M.alias_begin(), E = M.alias_end(); I != E;
         ++I)
      if (!AliveGlobals.count(&*I)) {
         DeadAliases.push_back(&*I);
         I->setAliasee(0);
      }

   if (!DeadFunctions.empty()) {
      // Now that all interferences have been dropped, delete the actual objects
      // themselves.
      for (unsigned i = 0, e = DeadFunctions.size(); i != e; ++i) {
         RemoveUnusedGlobalValue(*DeadFunctions[i]);
         M.getFunctionList().erase(DeadFunctions[i]);
      }
      //NumFunctions += DeadFunctions.size();
      Changed = true;
   }

   if (!DeadGlobalVars.empty()) {
      for (unsigned i = 0, e = DeadGlobalVars.size(); i != e; ++i) {
         RemoveUnusedGlobalValue(*DeadGlobalVars[i]);
         M.getGlobalList().erase(DeadGlobalVars[i]);
      }
      //NumVariables += DeadGlobalVars.size();
      Changed = true;
   }

   // Now delete any dead aliases.
   if (!DeadAliases.empty()) {
      for (unsigned i = 0, e = DeadAliases.size(); i != e; ++i) {
         RemoveUnusedGlobalValue(*DeadAliases[i]);
         M.getAliasList().erase(DeadAliases[i]);
      }
      //NumAliases += DeadAliases.size();
      Changed = true;
   }

   // Make sure that all memory is released
   AliveGlobals.clear();
   SeenConstants.clear();

   return Changed;
}

/// GlobalIsNeeded - the specific global value as needed, and
/// recursively mark anything that it uses as also needed.
void GlobalVarDCE::GlobalIsNeeded(GlobalValue *G) {
   // If the global is already in the set, no need to reprocess it.
   if (AliveGlobals.count(G))
   {
      return;
   }
   AliveGlobals.insert(G);

   if (GlobalVariable *GV = dyn_cast<GlobalVariable>(G)) {
      // If this is a global variable, we must make sure to add any global values
      // referenced by the initializer to the alive set.
      if (GV->hasInitializer())
         MarkUsedGlobalsAsNeeded(GV->getInitializer());
   } else if (GlobalAlias *GA = dyn_cast<GlobalAlias>(G)) {
      // The target of a global alias is needed.
      MarkUsedGlobalsAsNeeded(GA->getAliasee());
   } else {
      // Otherwise this must be a function object.  We have to scan the body of
      // the function looking for constants and global values which are used as
      // operands.  Any operands of these types must be processed to ensure that
      // any globals used will be marked as needed.
      Function *F = cast<Function>(G);

      if (F->hasPrefixData())
         MarkUsedGlobalsAsNeeded(F->getPrefixData());

      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
         for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E; ++I)
            for (User::op_iterator U = I->op_begin(), E = I->op_end(); U != E; ++U)
               if (GlobalValue *GV = dyn_cast<GlobalValue>(*U))
                  GlobalIsNeeded(GV);
               else if (Constant *C = dyn_cast<Constant>(*U))
                  MarkUsedGlobalsAsNeeded(C);
   }
}

void GlobalVarDCE::MarkUsedGlobalsAsNeeded(Constant *C) {
   if (GlobalValue *GV = dyn_cast<GlobalValue>(C))
      return GlobalIsNeeded(GV);

   // Loop over all of the operands of the constant, adding any globals they
   // use to the list of needed globals.
   for (User::op_iterator I = C->op_begin(), E = C->op_end(); I != E; ++I) {
      // If we've already processed this constant there's no need to do it again.
      Constant *Op = dyn_cast<Constant>(*I);
      if (Op && !SeenConstants.count(Op))
      {
         SeenConstants.insert(Op);
         MarkUsedGlobalsAsNeeded(Op);
      }
   }
}

// RemoveUnusedGlobalValue - Loop over all of the uses of the specified
// GlobalValue, looking for the constant pointer ref that may be pointing to it.
// If found, check to see if the constant pointer ref is safe to destroy, and if
// so, nuke it.  This will reduce the reference count on the global value, which
// might make it deader.
//
bool GlobalVarDCE::RemoveUnusedGlobalValue(GlobalValue &GV) {
   if (GV.use_empty()) return false;
   GV.removeDeadConstantUsers();
   return GV.use_empty();
}
