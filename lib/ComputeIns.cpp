#include <iostream>
#include <fstream>
#include <vector>
#include <string>
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

using std::string;
using std::vector;
using namespace std;
using namespace llvm;
namespace{
   class ComputeIns : public ModulePass{
      public:
         static char ID;//pass Identification
         int BBNum;//store BB number;
         vector<vector<int>> BBFreq; //store the BBFrequency, every thread(core)'s information in every internal vector 
         vector<vector<int>> vec;//store the store,add and load instructions' number of ervey BB 

         map<string,double> time_map;
         ComputeIns() : ModulePass(ID){}
         vector<vector<int>> BinaryOPNum;
         //the instruction's number with frequency;
         vector<vector<int>> LoadAndStore;
         vector<vector<int>> OPNum;

         vector<double> allInsTime;

         bool runOnModule(Module &M) override;
         void getTime(string s);//get instruction time
         void getProTime();
         void getBBNum(Module &M); //get BB numbers
         void getBBFrequency(string s);//read the .txt name and get BB num_array
         void getInsKind(Module &M);//get the store compute and load instruction's number in every BB
         void printInformation();
         void getBinaryOPNum(Module &M);
         void getBinaryOPNumAll();
   };

}

char ComputeIns::ID = 0 ;

//regite pass
static RegisterPass<ComputeIns> X("compute-BBnum","compute basic block's number and instrument",false,false);

void ComputeIns::getBinaryOPNumAll(){
   //每个基本块中的运算符
   vector<vector<int>>::iterator BBLable;
   vector<int> BBLable_temp;
   vector<int>::iterator OPNum;

   //线程层
   vector<vector<int>>::iterator ThreadLable;
   vector<int> ThreadLable_temp;
   vector<int>::iterator bbFreq;

   vector<int> allOPInBB;

   for(ThreadLable = this->BBFreq.begin(); ThreadLable != this->BBFreq.end(); ThreadLable++){
      ThreadLable_temp = *ThreadLable;
      for(bbFreq = ThreadLable_temp.begin(), BBLable = this->BinaryOPNum.begin(); bbFreq != ThreadLable_temp.end(), BBLable != this->BinaryOPNum.end(); bbFreq++, BBLable ++){
         BBLable_temp = *BBLable;
         for(OPNum = BBLable_temp.begin(); OPNum!= BBLable_temp.end(); OPNum++){
            int OPNum_tmp = *OPNum * (*bbFreq);
            allOPInBB.push_back(OPNum_tmp);
         }
         this->OPNum.push_back(allOPInBB);
         allOPInBB.clear();
      }
   }


}
//getBinaryOPNum is to get the number of any compute instruction in every block, like add sub.etc
void ComputeIns::getBinaryOPNum(Module &M){

   vector<int> bb; //store the BinaryOP number of every Block
   int add=0,fadd=0,mul=0,fmul=0,sub=0,fsub=0,udiv=0,sdiv=0,fdiv=0,urem=0,srem=0,frem=0;

   for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
      for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
         for(auto IB = BB->begin(), IE = BB->end(); IB!=IE ; ++IB){
            Instruction* ins = &*IB;

            unsigned Op = IB->getOpcode();
            switch(Op){
               case Instruction::FAdd:
                  fadd++;
                  break;
               case Instruction::Add:
                  add++;
                  break;
               case Instruction::Mul:
                  mul++;
                  break;
               case Instruction::FMul:
                  fmul++;
                  break;
               case Instruction::Sub:
                  sub++;
                  break;
               case Instruction::FSub:
                  fsub++;
                  break;
               case Instruction::UDiv:
                  udiv++;
                  break;
               case Instruction::SDiv:
                  sdiv++;
                  break;
               case Instruction::FDiv:
                  fdiv++;
                  break;
               case Instruction::URem:
                  urem++;
                  break;
               case Instruction::SRem:
                  srem++;
                  break;
               case Instruction::FRem:
                  frem++;
                  break;
               default:
                  break;
            }

            if(CallInst* CI = dyn_cast<CallInst>(ins)){
               Function* callee = CI->getCalledFunction();
               if(callee->getName().startswith("__kmpc_fork_call")){
                  bb.push_back(add);
                  bb.push_back(fadd);
                  bb.push_back(sub);
                  bb.push_back(fsub);
                  bb.push_back(mul);
                  bb.push_back(fmul);
                  bb.push_back(udiv);
                  bb.push_back(sdiv);
                  bb.push_back(fdiv);
                  bb.push_back(urem);
                  bb.push_back(srem);
                  bb.push_back(frem);
                  add=0,fadd=0,mul=0,fmul=0,sub=0,fsub=0,udiv=0,sdiv=0,fdiv=0,urem=0,srem=0,frem=0;
                  this->BinaryOPNum.push_back(bb);
                  bb.clear();
               }
            }
         }
         bb.push_back(add);
         bb.push_back(fadd);
         bb.push_back(sub);
         bb.push_back(fsub);
         bb.push_back(mul);
         bb.push_back(fmul);
         bb.push_back(udiv);
         bb.push_back(sdiv);
         bb.push_back(fdiv);
         bb.push_back(urem);
         bb.push_back(srem);
         bb.push_back(frem);
         add=0,fadd=0,mul=0,fmul=0,sub=0,fsub=0,udiv=0,sdiv=0,fdiv=0,urem=0,srem=0,frem=0;
         this->BinaryOPNum.push_back(bb);
         bb.clear();
      }


   }


}
void ComputeIns::getBBNum(Module &M){
   int number = 0;
   for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
      for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
         number ++;
         for(auto IB = BB->begin(), IE = BB->end(); IB!=IE ;++IB){
            Instruction* ins = &*IB;
            if(CallInst* CI = dyn_cast<CallInst>(ins))
            {
               Function* callee = CI->getCalledFunction();
               if(callee->getName().startswith("__kmpc_fork_call"))
               {
                  number++;
               }

            }
         }
      }
   }

   this->BBNum = number;
}


void ComputeIns::getBBFrequency(string s){

   ifstream infile;
   infile.open(s);

   int num;

   int flag = 1;
   vector<int> thread;
   while(!infile.eof()){
      infile >> num;
      if(flag <= this->BBNum){
         thread.push_back(num);
         flag++;
      }else{
         flag = 1;
         this->BBFreq.push_back(thread);
         thread.clear();
         thread.push_back(num);
      }
   }

   thread.pop_back();
   this->BBFreq.push_back(thread);
   infile.close();
}

void ComputeIns::getTime(string s){

   ifstream infile;
   infile.open(s);

   double time;

   int flag = 0;
   while(!infile.eof()){
      infile >> time;
      if(flag == 0){
         this->time_map.insert(pair<string,double>("load",time));
      }else if(flag == 1){
         this->time_map.insert(pair<string,double>("store",time));
      }else if(flag == 2){
         this->time_map.insert(pair<string,double>("add",time));
      }else if(flag == 3){
         this->time_map.insert(pair<string,double>("fadd",time));
      }else if(flag == 4){
         this->time_map.insert(pair<string,double>("mul",time));
      }else if(flag == 5){
         this->time_map.insert(pair<string,double>("fmul",time));
      }else if(flag == 6){
         this->time_map.insert(pair<string,double>("sub",time));
      }else if(flag == 7){
         this->time_map.insert(pair<string,double>("fsub",time));
      }else if(flag == 8){
         this->time_map.insert(pair<string,double>("udiv",time));
      }else if(flag == 9){
         this->time_map.insert(pair<string,double>("sdiv",time));
      }else if(flag == 10){
         this->time_map.insert(pair<string,double>("fdiv",time));
      }else if(flag == 11){
         this->time_map.insert(pair<string,double>("urem",time));
      }else if(flag == 12){
         this->time_map.insert(pair<string,double>("srem",time));
      }else if(flag == 13){
         this->time_map.insert(pair<string,double>("frem",time));
      }
      flag++;
   }
   infile.close();
}


void ComputeIns::getInsKind(Module &M){
   int loadNum=0,storeNum=0,boNum=0;
   vector<int> bb;
   for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
      for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
         errs()<<*BB<<"\n";
         for(auto IB = BB->begin(), IE = BB->end(); IB!=IE ; ++IB){
            Instruction* ins = &*IB;
            if(isa<LoadInst>(IB)){
               loadNum++;
            }else if(isa<StoreInst>(IB)){
               storeNum++;
            }else if(isa<llvm::BinaryOperator>(IB)){
               boNum++;
            }else if(CallInst* CI = dyn_cast<CallInst>(ins)){
               Function* callee = CI->getCalledFunction();
               if(callee->getName().startswith("__kmpc_fork_call")){
                  bb.push_back(loadNum);
                  bb.push_back(storeNum);
                  bb.push_back(boNum);
                  loadNum=0,storeNum=0,boNum=0;
                  this->vec.push_back(bb);
                  bb.clear();
               }
            }else{
               continue;
            }
         }
         bb.push_back(loadNum);
         bb.push_back(storeNum);
         bb.push_back(boNum);
         loadNum=0,storeNum=0,boNum=0;
         this->vec.push_back(bb);
         bb.clear();
      }
   }

}

void ComputeIns::printInformation(){
   errs() << this->vec.size() << "\n";
   int i = 0;
   vector<vector<int>>::iterator BBLable;
   vector<int> BBLable_temp;
   vector<int>::iterator insInf;

   vector<vector<int>>::iterator ThreadLable;
   vector<int> ThreadLable_temp;
   vector<int>::iterator bbFreq;

   int threadnum = 1;
   for(ThreadLable = this->BBFreq.begin(); ThreadLable != this->BBFreq.end(); ThreadLable++){
      errs() << "CoreNumber is : \t" << threadnum <<"\n";
      errs() << "-----------------------------------------------------------\n";
      ThreadLable_temp = *ThreadLable;
      int flag;
      i=0;
      vector<int> BBInCore;
      for(bbFreq = ThreadLable_temp.begin(),BBLable = this->vec.begin(); bbFreq != ThreadLable_temp.end(),BBLable != this->vec.end(); bbFreq++,BBLable++){
         errs() << "CoreNumber : \t"<< threadnum <<"\tBBLable is : \t" << i ;
         BBLable_temp = *BBLable;
         flag = 0;
         for(insInf = BBLable_temp.begin(); insInf != BBLable_temp.end(); insInf++){
            if(flag == 0){
               errs()<<"\nload instructions' number is:\t" << *insInf * (*bbFreq);
               BBInCore.push_back(*insInf * (*bbFreq));
            }else if(flag == 1){
               errs()<<"\nstore instructions' number is:\t" << *insInf * (*bbFreq);
               BBInCore.push_back(*insInf * (*bbFreq));
            }else if(flag == 2){
               errs()<<"\nBinaryOperator instructions' number is:\t" << *insInf * (*bbFreq)
                  <<"\n" 
                  <<"--------------------------------------------\n";
            }else{
               continue;
            }
            flag++;
         }
         this->LoadAndStore.push_back(BBInCore);
         BBInCore.clear();
         i++;

      }
      threadnum++;
      errs() << "-----------------------------------------------------------\n";

   }
}

void ComputeIns::getProTime(){
   double time_one = 0;
   double time_two = 0;

   vector<vector<int>>::iterator iter;
   vector<int> iter_temp;
   vector<int>::iterator it;

   int insFlag = 1;
   int BBFlag = 1;
   for(iter = this->LoadAndStore.begin() ; iter != this->LoadAndStore.end(); iter++){
      iter_temp = *iter;
      for(it = iter_temp.begin(); it != iter_temp.end(); it++){
         if(BBFlag <= this->BBNum){
            if(insFlag == 1){
               time_one = time_one + ((*it) * (this->time_map.find("load")->second));
               insFlag++;
            }else if(insFlag == 2){
               time_one = time_one + ((*it) * (this->time_map.find("store")->second));
            }
         }else{
            if(insFlag == 1){
               time_two = time_two + ((*it) * (this->time_map.find("load")->second));
               insFlag++;
            }else if(insFlag == 2){
               time_two = time_two + ((*it) * (this->time_map.find("store")->second));
            }
         }
      }
      insFlag = 1;
      BBFlag ++;
   }

   insFlag = 1;
   BBFlag = 1;
   for(iter = this->OPNum.begin() ; iter != this->OPNum.end(); iter++){
      iter_temp = *iter;
      for(it = iter_temp.begin(); it != iter_temp.end(); it++){
         if(BBFlag <= this->BBNum){
            if(insFlag == 1){
               time_one = time_one + ((*it) * (this->time_map.find("add")->second));
               insFlag++;
            }else if(insFlag == 2){
               time_one = time_one + ((*it) * (this->time_map.find("fadd")->second));
               insFlag++;
            }else if(insFlag == 3){
               time_one = time_one + ((*it) * (this->time_map.find("sub")->second));
               insFlag++;
            }else if(insFlag == 4){
               time_one = time_one + ((*it) * (this->time_map.find("fsub")->second));
               insFlag++;
            }else if(insFlag == 5){
               time_one = time_one + ((*it) * (this->time_map.find("mul")->second));
               insFlag++;
            }else if(insFlag == 6){
               time_one = time_one + ((*it) * (this->time_map.find("fmul")->second));
               insFlag++;
            }else if(insFlag == 7){
               time_one = time_one + ((*it) * (this->time_map.find("udiv")->second));
               insFlag++;
            }else if(insFlag == 8){
               time_one = time_one + ((*it) * (this->time_map.find("sdiv")->second));
               insFlag++;
            }else if(insFlag == 9){
               time_one = time_one + ((*it) * (this->time_map.find("fdiv")->second));
               insFlag++;
            }else if(insFlag == 10){
               time_one = time_one + ((*it) * (this->time_map.find("urem")->second));
               insFlag++;
            }else if(insFlag == 11){
               time_one = time_one + ((*it) * (this->time_map.find("srem")->second));
               insFlag++;
            }else if(insFlag == 12){
               time_one = time_one + ((*it) * (this->time_map.find("frem")->second));
            }
         }else{
            if(insFlag == 1){
               time_two = time_two + ((*it) * (this->time_map.find("add")->second));
               insFlag++;
            }else if(insFlag == 2){
               time_two = time_two + ((*it) * (this->time_map.find("fadd")->second));
               insFlag++;
            }else if(insFlag == 3){
               time_two = time_two + ((*it) * (this->time_map.find("sub")->second));
               insFlag++;
            }else if(insFlag == 4){
               time_two = time_two + ((*it) * (this->time_map.find("fsub")->second));
               insFlag++;
            }else if(insFlag == 5){
               time_two = time_two + ((*it) * (this->time_map.find("mul")->second));
               insFlag++;
            }else if(insFlag == 6){
               time_two = time_two + ((*it) * (this->time_map.find("fmul")->second));
               insFlag++;
            }else if(insFlag == 7){
               time_two = time_two + ((*it) * (this->time_map.find("udiv")->second));
               insFlag++;
            }else if(insFlag == 8){
               time_two = time_two + ((*it) * (this->time_map.find("sdiv")->second));
               insFlag++;
            }else if(insFlag == 9){
               time_two = time_two + ((*it) * (this->time_map.find("fdiv")->second));
               insFlag++;
            }else if(insFlag == 10){
               time_two = time_two + ((*it) * (this->time_map.find("urem")->second));
               insFlag++;
            }else if(insFlag == 11){
               time_two = time_two + ((*it) * (this->time_map.find("srem")->second));
               insFlag++;
            }else if(insFlag == 12){
               time_two = time_two + ((*it) * (this->time_map.find("frem")->second));
            }
         }
      }
      insFlag = 1;
      BBFlag ++;
   }

   errs() <<" core : 1 , time is : \t" << time_one << "\n";
   errs() <<" core : 2 , time is : \t" << time_two << "\n";

}

bool ComputeIns::runOnModule(Module &M){

   string s = "data.txt";
   string t = "time.txt";
   this->getTime(t);
   this->getBBNum(M);
   this->getBBFrequency(s);

   errs() << "time size is :" << this->time_map.size()<< "\n";

   vector<vector<int>>::iterator iter;
   vector<int> iter_temp;
   vector<int>::iterator it;

   errs() << this->BBFreq.size() <<"\n";
   //test and print the basic blocks' frequency  
   /**
     int i = 1;
     for(iter = this->BBFreq.begin() ; iter != this->BBFreq.end() ; iter++){
     iter_temp = *iter;
     errs()
     << "thread num :\t" << i << "\n";
     for(it = iter_temp.begin() ; it != iter_temp.end() ; it++){
     errs() << *it <<"\n";
     }
     i++;
     }
    **/
   this->getInsKind(M);
   this->printInformation();

   this->getBinaryOPNum(M);
   //test and print the binary operator of every block 
   /**
     int BBnum = 0;
     for(iter = this->BinaryOPNum.begin() ; iter != this->BinaryOPNum.end(); iter++){
     iter_temp = *iter;
     errs()<< "bb number is : \t " << BBnum <<"\n";
     for(it = iter_temp.begin(); it != iter_temp.end(); it++){
     errs() << *it <<"\n";
     }
     BBnum++;
     }

     errs()<<"--------------------------------------------\n";
    **/
   this->getBinaryOPNumAll();
   //test and pirnt all the binary operator , load and store instruction with frequency
   /**
     intBBnum = 1;
     for(iter = this->OPNum.begin() ; iter != this->OPNum.end(); iter++){
     iter_temp = *iter;
     errs()<< "BB number is : \t " << BBnum <<"\n";
     for(it = iter_temp.begin(); it != iter_temp.end(); it++){
     errs() << *it <<"\n";
     }
     BBnum++;
     }

     BBnum = 1;
     for(iter = this->LoadAndStore.begin() ; iter != this->LoadAndStore.end(); iter++){
     iter_temp = *iter;
     errs()<< "BB number is : \t " << BBnum <<"\n";
     for(it = iter_temp.begin(); it != iter_temp.end(); it++){
     errs() << *it <<"\n";
     }
     BBnum++;
     }

    **/
   this->getProTime();
   return true;
}











