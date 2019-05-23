#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Operator.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <set>
#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;
namespace{
   class Test:public FunctionPass
   {
      public:
         static char ID;
         Test():FunctionPass(ID){}
         bool runOnFunction(Function &F) override;
   };
}
char Test::ID = 0;
static RegisterPass<Test> X("Test","My Test",false,false);
bool isRefGlobal(Value* V, GlobalVariable** pGV, Use** pGEP)
{
   Use* U = NULL;
   User* UU;
   while(!isa<GlobalVariable>(V)){
      unsigned opcode = 0;
      UU = dyn_cast<User>(V);
      if (Instruction* I = dyn_cast<Instruction>(V))
      {
         opcode = I->getOpcode();
      }
      else if (ConstantExpr* CE = dyn_cast<ConstantExpr>(V))
      {
         opcode = CE->getOpcode();
      }
      else return false;
      if(opcode == Instruction::Load || Instruction::isCast(opcode))
         V = (U = &UU->getOperandUse(0))->get();
      else if(opcode == Instruction::GetElementPtr){
         if(pGEP) *pGEP = U;
         V = (U = &UU->getOperandUse(0))->get();
      } 
      else return false;
   }
   if(pGV) 
   {
      *pGV = cast<GlobalVariable>(V);
      errs()<<**pGV<<"!!!!!!!!!!!!!!!!!!!!!!\n";
   }
   return true;
}

bool Test::runOnFunction(Function &F) {
   if(F.isDeclaration())
      return false;
   errs()<<"================"<<F.getName()<<"\n";
   std::vector<Instruction*> worklist;
   for(inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I){
      worklist.push_back(&*I);
   }

   // def-use chain for Instruction
   for(std::vector<Instruction*>::iterator iter = worklist.begin(); iter != worklist.end(); ++iter){
      Instruction* instr = *iter;
      errs() << "def: " <<*instr << "\n"; 
      for(Value::use_iterator i = instr->use_begin(), ie = instr->use_end(); i!=ie; ++i){
         Instruction *vi = dyn_cast<Instruction>(&*i);
         errs() <<"-----" << *vi << "\n"; 
      }
   } 
   // use-def chain for Instruction 
   for(std::vector<Instruction*>::iterator iter = worklist.begin(); iter != worklist.end(); ++iter){
      Instruction* instr = *iter;
      errs() << "use: " <<*instr << "\n"; 
      for (User::op_iterator i = instr->op_begin(), e = instr->op_end(); i != e; ++i) {
         Value* v = i->get();
         Instruction *vi = dyn_cast<Instruction>(v);
         if(isa<GlobalVariable>(v))
         {
            errs() << "-----" << *v << "\n"; 
            errs() << "-----" << v << "\n"; 
            for(Value::use_iterator j = v->use_begin(), je = v->use_end();j!=je;)
            {
               Use* U = &*j;
               ++j;
               Value* vj = dyn_cast<Value>(U->getUser());
               errs()<<*vj<<"\n";
            }
         }
      }
   } 
   for(std::vector<Instruction*>::iterator iter = worklist.begin(); iter != worklist.end(); ++iter){
      Instruction*  I= *iter;
      errs()<<*I<<"------------------------------------------------\n";
      for (Use &U : (&*I)->operands()) {
         errs()<<*(U.get())<<"==========\n";
         if(auto tmp = U.getNext())
            errs()<<*(tmp->get())<<"===\n";
         if(GlobalVariable * GV = dyn_cast<GlobalVariable>(U)){
            errs()<<*GV<<"+_+++++++++++++++++++++++++++++++++++++++++++\n";
            errs()<<GV<<"\n";
            // Do something with GV
            GV->dump();
         }
         else if (GEPOperator* gepo = dyn_cast<GEPOperator>(&U))
         {
            errs() << "GEPO - " << *gepo << "\n";

            Value* v = dyn_cast<Value>(gepo);
            for(Value::use_iterator j = v->use_begin(), je = v->use_end();j!=je;)
            {
               Use* U = &*j;
               ++j;
               Value* vj = dyn_cast<Value>(U->getUser());
               Instruction* Itmp = dyn_cast<Instruction>(vj);
               errs()<<*vj<<"\n";
            }
            if (GlobalVariable* gv = dyn_cast<GlobalVariable>(gepo->getPointerOperand()))
            {
               errs() << "GV - " << *gv << "\n";
               for(User *Gvu:gv->users())
               {
                  errs()<<*Gvu<<"!!!!!!!!\n";
               }
            }
            for (auto it = gepo->idx_begin(), et = gepo->idx_end(); it != et; ++it)
            {
               errs()<<*(it->get())<<"\n";
               if (GlobalVariable* gv = dyn_cast<GlobalVariable>(*it))
               {
                  errs() << "GVi - " << *gv <<  "\n";
               }
            }
         }
      }

   } 
   for(std::vector<Instruction*>::iterator iter = worklist.begin(); iter != worklist.end(); ++iter){
      Instruction* instr = *iter;
      if(isa<LoadInst>(instr))
      {

         errs()<<*instr<<"\n";
         for (User::op_iterator i = instr->op_begin(), e = instr->op_end(); i != e; ++i) {
            Value* V = i->get();
            GlobalVariable* GV = NULL;
            Use* GEP = NULL;
            if(isRefGlobal(V,&GV,&GEP))
            {
               errs()<<"||||||||||||||||||||\n";
               if(isa<GlobalVariable>(GV))
               {
                  for(Value::use_iterator j = GV->use_begin(), je = GV->use_end();j!=je;)
                  {
                     Use* UU = &*j;
                     ++j;
                     Value* vj = dyn_cast<Value>(UU->getUser());
                     if (GEPOperator* gepo = dyn_cast<GEPOperator>(vj))
                     {

                        errs()<<"Hello world\n";
                     }
                     // if(isa<Use>(vj))
                     errs()<<*vj<<"00000000000000000000000\n";
                     //errs()<<*vj<<"\n";
                  }
               }
               errs()<<"_____________________\n";
            }

         }

      }
   }
   return false; 
}

