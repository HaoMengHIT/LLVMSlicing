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
            vector<vector<int>> BBFreq; //store the BBFrequency
            vector<vector<int>> vec;//store the store,add and load instructions' number of ervey BB 
            ComputeIns() : ModulePass(ID){}
            bool runOnModule(Module &M) override;
            void getBBNum(Module &M); //get BB numbers
            void getBBFrequency(string s);//read the .txt name and get BB num_array
            void getInsKind(Module &M);//get the store compute and load instruction's number in every BB
            void printInformation();
    };

}

char ComputeIns::ID = 0 ;

//regite pass
static RegisterPass<ComputeIns> X("compute-BBnum","计算基本块频率和指令数",false,false);

void ComputeIns::getBBNum(Module &M){
    int NumBlocks = 0;
    for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
        if (F->isDeclaration()) continue;
        StringRef fname = F->getName();
        if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
            int forkNum = 0;
            for(BasicBlock::iterator IB = BB->begin(), IE = BB->end(); IB != IE; ++IB)
            {
                Instruction* ins = &*IB;
                if(CallInst* CI = dyn_cast<CallInst>(ins))
                {
                    Function* callee = CI->getCalledFunction();
                    if(callee->getName().startswith("__kmpc_fork_call"))
                    {
                        forkNum++;
                    }

                }
            }
            NumBlocks+=(forkNum+1);
        }

        this->BBNum = NumBlocks;
    }
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

void ComputeIns::getInsKind(Module &M){
    int loadNum=0,storeNum=0,boNum=0;
    vector<int> bb;
    for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
        for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
            //errs()<<*BB<<"\n";
            for(auto IB = BB->begin(), IE = BB->end(); IB!=IE ; ++IB){
                if(isa<LoadInst>(IB)){
                    loadNum++;
                }else if(isa<StoreInst>(IB)){
                    storeNum++;
                }else if(isa<llvm::BinaryOperator>(IB)){
                    boNum++;
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

    int flag;
    for(BBLable = this->vec.begin(); BBLable != this->vec.end(); BBLable++){
        errs() << "BBLable is : \t" << i ;
        BBLable_temp = *BBLable;
        flag = 0;
        for(insInf = BBLable_temp.begin(); insInf != BBLable_temp.end(); insInf++){
            if(flag == 0){
                errs()<<"\nload instructions' number is:\t" << *insInf;
            }else if(flag == 1){
                errs()<<"\nstore instructions' number is:\t" << *insInf;
            }else if(flag == 2){
                errs()<<"\nBinaryOperator instructions' number is:\t" << *insInf
                    <<"\n" 
                    <<"--------------------------------------------\n";
            }else{
                continue;
            }
            flag++;
        }
        i++;

    }
}

bool ComputeIns::runOnModule(Module &M){

    string s = "data.txt";
    this->getBBNum(M);
    this->getBBFrequency(s);
    vector<vector<int>>::iterator iter;
    vector<int> iter_temp;
    vector<int>::iterator it;

    errs() << this->BBFreq.size() <<"\n";
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
    this->getInsKind(M);
    this->printInformation();
    return true;
}










