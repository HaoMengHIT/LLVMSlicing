#include "IRSlicer.h"
#include <llvm/ADT/DepthFirstIterator.h>
#include <llvm/ADT/PostOrderIterator.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/Operator.h>
#include <llvm/Transforms/IPO/GlobalDCE.h>
#include <llvm/Transforms/IPO.h>
#include <llvm/IR/InstIterator.h>

char IRSlicer::ID = 0;
static RegisterPass<IRSlicer> X("IRSlicer","LLVM IR Slicing Pass", false, false);

Value* castoff(Value* v)
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
/*
 * getReachDefStoreIns:
 *
 * This method can find all store instructions before current load instruction
 *
 * For example
 *    BB1:
 *       ...
 *       store i32 0, i32* %i, align 4
 *       ...
 *       br BB2
 *
 *    BB2:
 *       ...
 *       load i32* %i, align 4
 *       ...
 *
 *    BBn:
 *       ...
 *       store i32 %inc, i32* %i, align 4
 *       ...
 *       br BB2
 */

void IRSlicer::getReachDefStoreIns(Instruction* I, std::set<Value*>& storeInsSet)
{
   std::set<Value*>& reachTmp = this->RDef.InsReach[I];
   for(Use& U:I->operands())
   {
      Value* V = U.get();
      for(auto Ins:reachTmp)
      {
         if(StoreInst* SI = dyn_cast<StoreInst>(&*Ins))
         {
            if(V == SI->getOperand(1))
            {
               storeInsSet.insert(SI);
            }
         }
      }

   }
   return;
}

/*
 * findLives:
 *
 * This method can find all instructions on which the current instruction is dependent. 
 */
void IRSlicer::findLives(Instruction* I)
{
   //handle global variable
   //Example:
   //@sum = global i32 0, align 4
   //...
   //call func()    include:  store i32 %12, i32* @sum, align 4
   //...
   //%9 = load i32, i32* @sum, align 4
   //
   //Handle global GEP variable
   //Example:
   //@sum = global [2 x i32] zeroinitializer, align 4
   //...
   //call func()   include:  store i32 %12, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
   //...
   //%2 = load i32, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
   if(isa<LoadInst>(I))
   {
      for (User::op_iterator i = I->op_begin(), e = I->op_end(); i != e; ++i) {
         Value* v = i->get();
         if(isa<GlobalVariable>(v)||isa<GEPOperator>(v))
         {
            for(Value::use_iterator j = v->use_begin(), je = v->use_end();j!=je;)
            {
               Use* U = &*j;
               ++j;
               Value* vj = dyn_cast<Value>(U->getUser());
               Instruction* Itmp = dyn_cast<Instruction>(vj);
               if(isa<StoreInst>(Itmp) && CGF->judgeIns(Itmp, I))
                  if(addInsToLive(Itmp)) findLives(Itmp);
               //errs()<<*vj<<"\n";
            }
         }
      }
   }


   for(Use& U:I->operands())
   {
      Value* V = U.get();

      if(isa<Constant>(V)) continue;
      else if(isa<LoadInst>(I))
      {
         std::set<Value*> reachStore;
         //Apply reaching-definition method to get all store instructions before current load instruction.
         getReachDefStoreIns(I, reachStore);
         for(auto tmp:reachStore)
         {
            Instruction* si = dyn_cast<Instruction>(&*tmp);
            if(addInsToLive(si)) findLives(si);
         }


      }
      else if(isa<AllocaInst>(V))
      {
         std::set<Value*> reachStore;
         //Apply reaching-definition method to get all store instructions before current load instruction.
         getReachDefStoreIns(I, reachStore);
         for(auto tmp:reachStore)
         {
            Instruction* si = dyn_cast<Instruction>(&*tmp);
            if(addInsToLive(si)) findLives(si);
         }

      }
      if(isa<Instruction>(V))
      {
         Instruction* VI = dyn_cast<Instruction>(V);
         if(addInsToLive(VI)) findLives(VI);
         else return;
      }
   }

   return;
}
bool IRSlicer::addInsToLive(Instruction* I)
{
   if(this->Live.find(I) == this->Live.end())
   {
      DEBUG(errs()<<">>>Insert Instruction:\t" << *I<<"\n");
      this->Live.insert(I);
      return true;
   }
   return false;
}

/*
 * deleteIns:
 * This method can delete instructoins which are not in Live set by the order of down-up
 * */
void IRSlicer::deleteIns(Module &M)
{
   vector<Instruction*> worklist; 
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB){
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            Instruction* I = dyn_cast<Instruction>(IB);
            worklist.push_back(I);
         }
   }
   for(int i = worklist.size()-1;i>=0;i--)
   {
      Instruction* I = worklist[i];
      if(this->Live.find(I) == this->Live.end() && !isa<ReturnInst>(I))
      {
         DEBUG(errs()<<"Deleting instruction "<<*I<<"......\n");
         for(User* user:I->users())
         {
            Instruction* userIns = dyn_cast<Instruction>(user);
            DEBUG(errs()<<*userIns<<"\n");
         }
         I->dropAllReferences();
         I->replaceAllUsesWith(UndefValue::get(I->getType()));
         I->eraseFromParent();
         //I->removeFromParent();
      }

   }
   return;
}
bool RemoveUnusedGlobalValue(GlobalValue &GV) {
   if (GV.use_empty()) return false;
   GV.removeDeadConstantUsers();
   return GV.use_empty();
}
/*
 * deleteNoUsedFunc:
 * This method can delete all functions of which return results are not used in other functions.
 */
void IRSlicer::deleteNoUsedFunc(Module &M)
{
   for(auto FB = M.begin(),FE = M.end();FB!=FE;)
   {  Function* F = &*FB;
      ++FB;
      //Contain Not declaration function and delete noused declaration function 
      //if(this->UsedFunc.find(F) == this->UsedFunc.end() && F->isDeclaration())
      if(this->UsedFunc.find(F) == this->UsedFunc.end() && !F->isDeclaration())
      {
         for(auto IB = inst_begin(F), IE = inst_end(F); IB != IE;)
         {
            Instruction* I = &*IB;
            ++IB;
            if(!isa<ReturnInst>(I))
            {
               I->dropAllReferences();
               I->replaceAllUsesWith(UndefValue::get(I->getType()));
               I->eraseFromParent();
            }
         }
      }
      if(this->UsedFunc.find(F) == this->UsedFunc.end() && F->isDeclaration())
      {
         M.getFunctionList().erase(F);

      }
   }
   for(auto FB = M.begin(),FE = M.end();FB!=FE;)
   {  Function* F = &*FB;
      ++FB;
      //Contain Not declaration function and delete noused declaration function 
      //if(this->UsedFunc.find(F) == this->UsedFunc.end() && F->isDeclaration())
      if(this->UsedFunc.find(F) == this->UsedFunc.end() && !F->isDeclaration())
      {
         DEBUG(errs()<<"Deleting function "<<F->getName()<<"\n");
         F->removeDeadConstantUsers();
         if(F->use_empty())
         {
            //FB = M.getFunctionList().erase(F);
         }
      }
   }

   return;
}

/*
 * interFunction:
 * This method is used to judge whether the the return value of current function is used in other functions.
 * If not, replace the return value by undef value, 
 * otherwise, store the return instruction and its dependent instructions into Live set.
 */
void IRSlicer::interFunction(Function* FB, bool isRetUsed)
{
   errs()<<"Strat dealing functoin "<<FB->getName()<<"\n";     
   this->UsedFunc.insert(FB);
   if(FB->isDeclaration()) return;
   DEBUG(errs()<<"Strat dealing functoin "<<FB->getName()<<"\n");     
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(ReturnInst* RI = dyn_cast<ReturnInst>(ins))
      {
         //handle ret void
         if(RI->getNumOperands() == 0)
         {
            errs()<<*RI<<"\n";
            addInsToLive(RI);
            continue;
         }
         else if(isRetUsed == false)
         {
            Value* Ret = RI->getReturnValue(); 
            if(Ret != NULL)
            {
               ReturnInst* newRet = ReturnInst::Create(FB->getContext(), UndefValue::get(Ret->getType()));
               BasicBlock::iterator ii(RI);
               ReplaceInstWithInst(RI->getParent()->getInstList(),ii,newRet);
               addInsToLive(newRet);
            }
            else
            {
               addInsToLive(RI);
            }
         }
         else
         {
            if(addInsToLive(ins)) findLives(ins);
         }
      }
   }
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(CallInst* CI = dyn_cast<CallInst>(ins))
      {
         Function* callee = CI->getCalledFunction();
         bool isUsed = false;
         if(callee->getName().startswith("__kmpc_fork_call"))
         {
            errs()<<callee->getName()<<"----------------------------\n";
            for(Use& U:CI->operands())
            {
               Value* V = U.get();
               auto Test = V->stripPointerCasts();
               if(Function* kmpcCall = dyn_cast<Function>(Test))
               {
                  if(kmpcCall->getName().startswith(".omp_"))
                  {
                     errs()<<kmpcCall->getName()<<"\n";
                     interFunction(kmpcCall,isUsed);
                  }
               }
            }
         }
         for(User* U:CI->users())
         {
            if(Instruction* I = dyn_cast<Instruction>(U))
            {
               if(this->Live.find(I) != this->Live.end())
               {
                  isUsed = true;
                  interFunction(callee,isUsed);
                  break;
               }
            }
         }
         if(!isUsed)
         {
            interFunction(callee,isUsed);
         }
      }
      if(InvokeInst* CI = dyn_cast<InvokeInst>(ins))
      {
         Function* callee = CI->getCalledFunction();
         bool isUsed = false;
         if(callee->getName().startswith("__kmpc_fork_call"))
         {
            errs()<<callee->getName()<<"----------------------------\n";
            for(Use& U:CI->operands())
            {
               Value* V = U.get();
               auto Test = V->stripPointerCasts();
               if(Function* kmpcCall = dyn_cast<Function>(Test))
               {
                  if(kmpcCall->getName().startswith(".omp_"))
                  {
                     errs()<<kmpcCall->getName()<<"\n";
                     interFunction(kmpcCall,isUsed);
                  }
               }
            }
         }
         for(User* U:CI->users())
         {
            if(Instruction* I = dyn_cast<Instruction>(U))
            {
               if(this->Live.find(I) != this->Live.end())
               {
                  isUsed = true;
                  interFunction(callee,isUsed);
                  break;
               }
            }
         }
         if(!isUsed)
         {
            interFunction(callee,isUsed);
         }
      }
   }

   return;
}

void IRSlicer::printUses(Instruction* I)
{
   //unsigned us = CGF->indexof(I);
   //errs()<<">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"<<*I<<"\n";
   //errs()<<us<<"\n";
}

void IRSlicer::findAllRelatedIns(Instruction* I)
{
   if(addInsToLive(I)) findLives(I);
   for(User* U:I->users())
   {
      if(Instruction* II = dyn_cast<Instruction>(U))
      {
         addInsToLive(II);
      }
   }


}

bool IRSlicer::runOnModule(Module &M){
   CallGraph CG(M);
   Function* Main = M.getFunction("main");
   auto root = Main?CG[Main]:CG.getExternalCallingNode();
   CGF = new CGFilter(root,NULL);

   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      this->RDef.dealFunction(*FB);
   }
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      DEBUG(errs()<<FB->getName()<<"==========================================\n");
      if(FB->getName().startswith(".omp_task_"))
      {
         for(auto IB = inst_begin(&*FB), IE = inst_end(&*FB); IB != IE;)
         {
            Instruction* I = &*IB;
            ++IB;
            if(addInsToLive(I)) findLives(I);
         }
      }
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         DEBUG(errs()<<BB->getName()<<"-----\n");
         auto Term = BB->getTerminator();
         if(isa<BranchInst>(Term)||isa<SwitchInst>(Term)||isa<UnreachableInst>(Term))
         {
            Instruction* TI = dyn_cast<Instruction>(Term);
            if(addInsToLive(TI)) findLives(TI);
            else continue;
         }
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            errs()<<*IB<<"===========\n";
            if(CallInst* CI = dyn_cast<CallInst>(&*IB))
            {
               Function* callee = CI->getCalledFunction();
               //Handle the callee is NUll
               if(!callee)
                  continue;
               auto callName = callee->getName();
               if(!(callee->isDeclaration()))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
               //Handle fopen function
               else if(callName.startswith("fopen"))
               {
                  findAllRelatedIns(CI);
               }
               else if(callName.startswith("fscanf")||callName.startswith("fclose") || callName.startswith("__kmpc") || callName.startswith(".omp_"))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
            }
            if(isa<InvokeInst>(IB))
            {
               InvokeInst* CI = dyn_cast<InvokeInst>(IB);
               Function* callee = CI->getCalledFunction();
               if(!callee)
                  continue;
               auto callName = callee->getName();
               if(!(callee->isDeclaration()))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
               //Handle fopen function
               else if(callee->getName().startswith("fopen"))
               {
                  findAllRelatedIns(CI);
               }
               else if(callName.startswith("fscanf")||callName.startswith("fclose") || callName.startswith("__kmpc") || callName.startswith(".omp_"))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
            }
         }
      }
   }


   DEBUG(errs()<<this->Live.size()<<"\n");
   interFunction(M.getFunction("main"),false);
   DEBUG(errs()<<this->Live.size()<<"\n");
   deleteIns(M);
   GDce = new GlobalVarDCE();
   GDce->runOnModule(M);
   errs()<<"Hello world\n";
   //deleteNoUsedFunc(M);
   return false;
}
