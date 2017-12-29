#include "IRSlicer.h"

char IRSlicer::ID = 0;
static RegisterPass<IRSlicer> X("IRSlicer","LLVM IR Slicing Pass", false, false);

Value* castoff(Value* v)
{
   if(ConstantExpr* CE = dyn_cast<ConstantExpr>(v))
      v = CE->getAsInstruction();

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
      errs()<<">>>Insert Instruction:\t" << *I<<"\n";
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
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            Instruction* I = dyn_cast<Instruction>(IB);
            worklist.push_back(I);
         }
   for(int i = worklist.size()-1;i>=0;i--)
   {
      Instruction* I = worklist[i];
      if(this->Live.find(I) == this->Live.end())
      {
         errs()<<"Deleting instruction "<<*I<<"......\n";
         for(User* user:I->users())
         {
            Instruction* userIns = dyn_cast<Instruction>(user);
            errs()<<*userIns<<"\n";
         }
         I->replaceAllUsesWith(UndefValue::get(I->getType()));
         I->eraseFromParent();
         //I->removeFromParent();
      }

   }
   return;
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
      if(this->UsedFunc.find(F) == this->UsedFunc.end() && F->isDeclaration())
      {
         errs()<<"Deleting function "<<F->getName()<<"\n";
         M.getFunctionList().erase(F);
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
   this->UsedFunc.insert(FB);
   if(FB->isDeclaration()) return;
   errs()<<"Strat dealing functoin "<<FB->getName()<<"\n" ;     
   for(auto Ite = inst_begin(FB), E = inst_end(FB); Ite!=E;)
   {
      Instruction* ins = &*Ite;
      ++Ite;
      if(ReturnInst* RI = dyn_cast<ReturnInst>(ins))
      {
         if(isRetUsed == false)
         {
            Value* Ret = RI->getReturnValue(); 
            ReturnInst* newRet = ReturnInst::Create(FB->getContext(), UndefValue::get(Ret->getType()));
            BasicBlock::iterator ii(RI);
            ReplaceInstWithInst(RI->getParent()->getInstList(),ii,newRet);
            addInsToLive(newRet);
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

bool IRSlicer::runOnModule(Module &M){

   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      this->RDef.dealFunction(*FB);
   }
   for(auto FB=M.begin(),FE=M.end();FB!=FE;++FB)
   {
      if(FB->isDeclaration()) continue;
      errs()<<FB->getName()<<"==========================================\n";
      for(auto BB=FB->begin(),BE=FB->end();BB!=BE;++BB)
      {
         errs()<<BB->getName()<<"-----\n";
         auto Term = BB->getTerminator();
         if(isa<BranchInst>(Term)||isa<SwitchInst>(Term))
         {
            Instruction* TI = dyn_cast<Instruction>(Term);
            if(addInsToLive(TI)) findLives(TI);
            else continue;
         }
         for(auto IB=BB->begin(),IE=BB->end();IB!=IE;++IB)
         {
            if(CallInst* CI = dyn_cast<CallInst>(IB))
            {
               Function* callee = CI->getCalledFunction();
               if(!(callee->isDeclaration()))
               {
                  if(addInsToLive(CI)) findLives(CI);
                  else continue;
               }
            }

         }
      }
   }
   errs()<<this->Live.size()<<"\n";
   interFunction(M.getFunction("main"),false);
   errs()<<this->Live.size()<<"\n";
   deleteIns(M);
   deleteNoUsedFunc(M);
   return false;
}
