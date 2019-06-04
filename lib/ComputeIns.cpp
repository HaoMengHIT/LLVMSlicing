#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
#include <queue>
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
#include <llvm/Analysis/CallGraph.h>

using std::string;
using std::vector;
using std::map;
using std::pair;
using std::queue;
using namespace std;
using namespace llvm;
namespace{
	class ComputeIns : public ModulePass{
		public:
			static char ID;//pass Identification
			int BBNum;//store BB number;
			vector<vector<long long>> BBFreq; //store the BBFrequency, every thread(core)'s information in every internal vector 
			vector<vector<int>> vec;//store the store,add and load instructions' number of ervey BB 

			map<string,double> time_map;
			ComputeIns() : ModulePass(ID){}
			vector<vector<int>> BinaryOPNum;
			//the instruction's number with frequency;
			vector<vector<long long>> LoadAndStore;
			vector<vector<long long>> OPNum;

			//judge the BB is or not in Paraller
			map<int,int> isParallel;

			vector<double> timeInf;

			map<string,double> mathTime;
			vector<vector<int>> mathInsNumInBB;
			vector<vector<long long>> mathInsTotal;


			///////add by haomeng
			vector<int> isParaRegion;
			map<Function*, int> parallelRegion;
			void isBBParallel(Module& M, BasicBlock * BB);
			int isIteParallel(Module& M, Function* FF, int regionId, Function* F);
			void judgeIsParallel(Module &M);
			Function* getFunction(Value *Call);
			/////////

			bool runOnModule(Module &M) override;
			void getTime(string s);//get instruction time
			void getProTime();
			void getBBNum(Module &M); //get BB numbers
			void getBBFrequency(string s);//read the .txt name and get BB num_array
			void getInsKind(Module &M);//get the store compute and load instruction's number in every BB
			void printInformation();
			void getBinaryOPNum(Module &M);
			void getBinaryOPNumAll();
			void matchingBBwithParallel(Module& M);//match the basic block with the parallel

			void getMathInsTime(string s);//get the math instruction's time
			void getMathInsNumInBB(Module &M);
			void getMathInsNumTotal();
			void test();
	};

}

char ComputeIns::ID = 0 ;

//regite pass
static RegisterPass<ComputeIns> X("compute-BBnum","compute basic block's number and instrument",false,false);

void ComputeIns::test(){
	map<string,double>::iterator it;
	it = this->mathTime.begin();

	while(it != this->mathTime.end()){
		errs() << it->first << ":\t" <<it->second << "\n";
		it++;
	}

	vector<vector<long long>>::iterator iter;
	vector<long long> iter_tmp;
	vector<long long>::iterator itp;

	int i=0;
	for(iter = this->mathInsTotal.begin() ; iter != this->mathInsTotal.end(); iter++){
		iter_tmp = *iter;
		errs() << i << ":\t";
		for(itp = iter_tmp.begin(); itp != iter_tmp.end() ; itp++){
			errs() << *itp <<"\t";
		}
		i++;
		errs() <<"\n";
	}
}

void ComputeIns::getMathInsTime(string s){


	errs() <<"-------------getMathInsTime()-----------------\n";

	ifstream infile;
	infile.open(s);

	double time;
	vector<double> time_tmp;
	while(!infile.eof()){
		infile >>time;
		time_tmp.push_back(time);

	}
	time_tmp.pop_back();

	infile.close();

	int flag = 0;
	for(auto I : time_tmp){
		switch(flag){
			case 0:
				this->mathTime.insert(pair<string,double>("sqrt",I));
				break;
			case 1:
				this->mathTime.insert(pair<string,double>("fabs",I));
				break;
			case 2:
				this->mathTime.insert(pair<string,double>("log",I));
				break;
			case 3:
				this->mathTime.insert(pair<string,double>("trunc",I));
				break;
			case 4:
				this->mathTime.insert(pair<string,double>("exp",I));
				break;
			case 5:
				this->mathTime.insert(pair<string,double>("cos",I));
				break;
			case 6:
				this->mathTime.insert(pair<string,double>("sin",I));
				break;
			case 7:
				this->mathTime.insert(pair<string,double>("logf",I));
				break;
			case 8:
				this->mathTime.insert(pair<string,double>("pow",I));
				break;
			case 9:
				this->mathTime.insert(pair<string,double>("cabs",I));
				break;
			default:
				break;
		}
		flag++;

	}

	errs() <<"共有数学函数库：\t" << this->mathTime.size() <<"个\n"; 
}

void ComputeIns::getMathInsNumInBB(Module &M){

	errs() <<"--------------getMathInsNumBB()------------------\n";

	vector<int> bb;

	int sqrt=0,fabs=0,log=0,trunc=0,exp=0,cos=0,sin=0,logf=0,pow=0,cabs=0;
	for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
		if (FB->isDeclaration()) continue;
		StringRef fname = FB->getName();
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
		for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
			for(auto IB = BB->begin(), IE = BB->end(); IB!=IE ; ++IB){
				Instruction* ins = &*IB;
				if(CallInst* CI = dyn_cast<CallInst>(ins)){
					Function* F = CI->getCalledFunction();
					if(F->getName().startswith("sqrt")){
						sqrt++;
					}else if(F->getName().startswith("fabs")){
						fabs++;
					}else if(F->getName().startswith("log")){
						log++;
					}else if(F->getName().startswith("trunc")){
						trunc++;
					}else if(F->getName().startswith("exp")){
						exp++;
					}else if(F->getName().startswith("cos")){
						cos++;
					}else if(F->getName().startswith("sin")){
						sin++;
					}else if(F->getName().startswith("logf")){
						logf++;
					}else if(F->getName().startswith("pow")){
						pow++;
					}else if(F->getName().startswith("cabs")){
						cabs++;
					}
				}

				if(CallInst* CI = dyn_cast<CallInst>(ins)){
					Function* callee = CI->getCalledFunction();
					if(callee->getName().startswith("__kmpc_fork_call")){
						bb.push_back(sqrt);
						bb.push_back(fabs);
						bb.push_back(log);
						bb.push_back(trunc);
						bb.push_back(exp);
						bb.push_back(cos);
						bb.push_back(sin);
						bb.push_back(logf);
						bb.push_back(pow);
						bb.push_back(cabs);
						sqrt=0,fabs=0,log=0,trunc=0,exp=0,cos=0,sin=0,logf=0,pow=0,cabs=0;
						this->mathInsNumInBB.push_back(bb);
						bb.clear();
					}
				}
			}
			bb.push_back(sqrt);
			bb.push_back(fabs);
			bb.push_back(log);
			bb.push_back(trunc);
			bb.push_back(exp);
			bb.push_back(cos);
			bb.push_back(sin);
			bb.push_back(logf);
			bb.push_back(pow);
			bb.push_back(cabs);
			sqrt=0,fabs=0,log=0,trunc=0,exp=0,cos=0,sin=0,logf=0,pow=0,cabs=0;
			this->mathInsNumInBB.push_back(bb);
			bb.clear();

		}

	}

	errs() << "=================" << this->mathInsNumInBB.size() << "\n";

}


void ComputeIns::getMathInsNumTotal(){

	errs() <<"--------------------getMathInsNumTotal()--------------------\n";
	
	
	//每个基本块中的运算符
	vector<vector<int>>::iterator BBLable;
	vector<int> BBLable_temp;
	vector<int>::iterator OPNum;

	//线程层
	vector<vector<long long>>::iterator ThreadLable;
	vector<long long> ThreadLable_temp;
	vector<long long>::iterator bbFreq;

	vector<long long> allOPInBB;

	for(ThreadLable = this->BBFreq.begin(); ThreadLable != this->BBFreq.end(); ThreadLable++){
		ThreadLable_temp = *ThreadLable;
//		errs() << "=======:"<<this->mathInsNumInBB.size() <<"\n";
		for(bbFreq = ThreadLable_temp.begin(), BBLable = this->mathInsNumInBB.begin(); bbFreq != ThreadLable_temp.end(), BBLable != this->mathInsNumInBB.end(); bbFreq++, BBLable ++){
//			errs() << "========\n";
			BBLable_temp = *BBLable;
			for(OPNum = BBLable_temp.begin(); OPNum!= BBLable_temp.end(); OPNum++){		
				
				long long num = *OPNum * (*bbFreq);
				allOPInBB.push_back(num);
			}
			this->mathInsTotal.push_back(allOPInBB);
//			errs()<< "---------------\n";
			allOPInBB.clear();
		}
	}

	errs() <<"=================" << this->mathInsTotal.size() <<"\n";

}
static Value* castoff(Value* v)
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

Function* ComputeIns::getFunction(Value *Call)
{
	if(Call==NULL) return NULL;
	CallInst* CI = dyn_cast<CallInst>(Call);
	if(CI==NULL) return NULL;
	return dyn_cast<Function>(castoff(CI->getCalledValue()));
}


int ComputeIns::isIteParallel(Module& M, Function* FF, int regionId, Function* F)
{
	CallGraph CG(M);
	CallGraphNode* fNode = CG[FF];
	queue<CallGraphNode*> Q;
	map<CallGraphNode*, bool> isVisit;
	Q.push(fNode);
	isVisit[fNode] = true;
	while(!Q.empty())
	{
		fNode = Q.front();
		Q.pop();
		for(auto I = fNode->begin(), E = fNode->end(); I!=E; ++I){
			Function* Fn = getFunction(I->first);
			if(F==NULL || (Fn->isDeclaration()))
			  continue; // this is a external function
			if(F == Fn)
			{
				return regionId;
			}
			fNode = CG[Fn];
			if(isVisit.find(fNode) == isVisit.end() || !isVisit[fNode])
			{
				Q.push(fNode);
				isVisit[fNode] = true;
			}

		}

	}
	return 0;

}
void ComputeIns::isBBParallel(Module&M, BasicBlock * BB)
{
	Function* F = BB->getParent();
	StringRef fname = F->getName();
	int regionId = -1;
	if(fname.startswith(".omp_outlined"))
	  regionId = this->parallelRegion[F];
	else
	{
		CallGraph CG(M);
		map<Function*, int>::iterator it;
		for(map<Function*, int>::iterator it = this->parallelRegion.begin();it != this->parallelRegion.end();it++)
		{
			Function* FF = it->first;
			regionId = isIteParallel(M, FF, this->parallelRegion[FF], F);
			if(regionId > 0)
			  break;
		}
	}
	this->isParaRegion.push_back(regionId);

	return;
}
void ComputeIns::judgeIsParallel(Module &M)
{
	int regionNum = 1;
	for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		if (F->isDeclaration()) continue;
		StringRef fname = F->getName();
		if(fname.startswith(".omp_outlined"))
		{
			this->parallelRegion.insert(std::pair<Function*, int>(&*F,regionNum));
			regionNum++;
		}
	}
	for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		if (F->isDeclaration()) continue;
		StringRef fname = F->getName();
		errs()<<"=========="<<fname<<"\n";
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
		for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
			for(BasicBlock::iterator IB = BB->begin(), IE = BB->end(); IB != IE; ++IB)
			{
				Instruction* ins = &*IB;
				if(CallInst* CI = dyn_cast<CallInst>(ins))
				{
					Function* callee = CI->getCalledFunction();
					if(callee->getName().startswith("__kmpc_fork_call"))
					{
						this->isParaRegion.push_back(0);
					}

				}
			}
			isBBParallel(M, &*BB);
		}
	}

	return;
}



void ComputeIns::matchingBBwithParallel(Module& M){

	errs() <<"-------------matchingBBwithParallel()-----------------\n";

	judgeIsParallel(M);

	vector<int>& parallelInf = this->isParaRegion;

	int BBFlag = 1;
	for(auto I : parallelInf){
		errs()<< "--------------"<<I <<"\n";
		this->isParallel.insert(pair<int,int>(BBFlag,I));
		BBFlag++;
	}

	errs() << "----------matchingBBwithParallel--------\n"
		<<"基本块数量：\t"<< this->isParallel.size()<< "\n"
		<<"-----------------------------------------\n";

}
void ComputeIns::getBinaryOPNumAll(){

	errs() <<"-------------getBinaryOPNumAll()-----------------\n";

	//每个基本块中的运算符
	vector<vector<int>>::iterator BBLable;
	vector<int> BBLable_temp;
	vector<int>::iterator OPNum;

	//线程层
	vector<vector<long long>>::iterator ThreadLable;
	vector<long long> ThreadLable_temp;
	vector<long long>::iterator bbFreq;

	vector<long long> allOPInBB;

	for(ThreadLable = this->BBFreq.begin(); ThreadLable != this->BBFreq.end(); ThreadLable++){
		ThreadLable_temp = *ThreadLable;
		for(bbFreq = ThreadLable_temp.begin(), BBLable = this->BinaryOPNum.begin(); bbFreq != ThreadLable_temp.end(), BBLable != this->BinaryOPNum.end(); bbFreq++, BBLable ++){
			BBLable_temp = *BBLable;
			for(OPNum = BBLable_temp.begin(); OPNum!= BBLable_temp.end(); OPNum++){		
				long long num = *OPNum * (*bbFreq);
				allOPInBB.push_back(num);
			}
			this->OPNum.push_back(allOPInBB);
			allOPInBB.clear();
		}
	}

	errs() <<"=================="<< this->OPNum.size() <<"\n";
}
//getBinaryOPNum is to get the number of any compute instruction in every block, like add sub.etc
void ComputeIns::getBinaryOPNum(Module &M){
	errs() <<"-------------getBinaryOPNum()-----------------\n";


	vector<int> bb; //store the BinaryOP number of every Block
	int add=0,fadd=0,mul=0,fmul=0,sub=0,fsub=0,udiv=0,sdiv=0,fdiv=0,urem=0,srem=0,frem=0;	

	for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
		if (FB->isDeclaration()) continue;
		StringRef fname = FB->getName();
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
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
	errs() <<"-------------getBBNum()-----------------\n";

	int number = 0;
	for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
		if (FB->isDeclaration()) continue;
		StringRef fname = FB->getName();
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
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

	errs() <<"-------------getBBFrequency()-----------------\n";

	ifstream infile;
	infile.open(s);

	long long num;

	int flag = 1;
	vector<long long> thread;
	while(!infile.eof()){
		infile >> num;
		if(flag <= this->BBNum){
			thread.push_back(num);
			flag++;
		}else{
			flag = 1;
			//			errs() << "-------------------\n"
			//				<< "该核心线程有：\t" << thread.size() << "\t个基本块\n";
			this->BBFreq.push_back(thread);
			thread.clear();
			thread.push_back(num);
			flag++;
		}
	}

	thread.pop_back();
	this->BBFreq.push_back(thread);

	this->BBFreq.pop_back();
	errs() << "-------------------------\n"
		<<"共有多少个核心？\t" << this->BBFreq.size() <<"\t个\n";
	infile.close();
}

void ComputeIns::getTime(string s){


	errs() <<"-------------getTime()-----------------\n";

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

	errs() <<"-------------getInsKind()-----------------\n";

	int loadNum=0,storeNum=0,boNum=0;
	vector<int> bb;
	for(auto FB = M.begin(),FE = M.end(); FB!=FE ; ++FB){
		if (FB->isDeclaration()) continue;
		StringRef fname = FB->getName();
		if (fname.find("WriteOpenMPProfile")!=fname.npos) continue;
		for(auto BB = FB->begin(), BE = FB->end(); BB!=BE ; ++BB){
			//				errs()<<*BB<<"\n";
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

	errs() <<"-------------printInformation()-----------------\n";

	//	errs() << this->vec.size() << "\n";
	int i = 0;
	vector<vector<int>>::iterator BBLable;
	vector<int> BBLable_temp;
	vector<int>::iterator insInf;

	vector<vector<long long>>::iterator ThreadLable;
	vector<long long> ThreadLable_temp;
	vector<long long>::iterator bbFreq;

	int threadnum = 1;
	for(ThreadLable = this->BBFreq.begin(); ThreadLable != this->BBFreq.end(); ThreadLable++){
		//		errs() << "CoreNumber is : \t" << threadnum <<"\n";
		//		errs() << "-----------------------------------------------------------\n";
		ThreadLable_temp = *ThreadLable;
		int flag;
		i=0;
		vector<long long> BBInCore;
		for(bbFreq = ThreadLable_temp.begin(),BBLable = this->vec.begin(); bbFreq != ThreadLable_temp.end(),BBLable != this->vec.end(); bbFreq++,BBLable++){
			//			errs() << "CoreNumber : \t"<< threadnum <<"\tBBLable is : \t" << i ;
			BBLable_temp = *BBLable;
			flag = 0;
			for(insInf = BBLable_temp.begin(); insInf != BBLable_temp.end(); insInf++){
				if(flag == 0){
					//					errs()<<"\nload instructions' number is:\t" << *insInf * (*bbFreq);
					BBInCore.push_back(*insInf * (*bbFreq));
				}else if(flag == 1){
					//					errs()<<"\nstore instructions' number is:\t" << *insInf * (*bbFreq);
					BBInCore.push_back(*insInf * (*bbFreq));
				}else if(flag == 2){
					//					errs()<<"\nBinaryOperator instructions' number is:\t" << *insInf * (*bbFreq)
					//						<<"\n" 
					//						<<"--------------------------------------------\n";
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
		//		errs() << "-----------------------------------------------------------\n";

	}
}

void ComputeIns::getProTime(){

	errs() <<"-------------getProTime()-----------------\n";

	double time_tmp = 0;

	vector<vector<long long>>::iterator iter;
	vector<long long> iter_temp;
	vector<long long>::iterator it;

	int insFlag = 1;
	int BBFlag = 1;
	for(iter = this->LoadAndStore.begin() ; iter != this->LoadAndStore.end(); iter++){
		iter_temp = *iter;
		for(it = iter_temp.begin(); it != iter_temp.end(); it++){
			if(BBFlag <= this->BBNum){
				if(this->isParallel.find(BBFlag)->second == 0){
					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("load")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("store")->second));
					}	
				}
			}else{
				BBFlag = 1;
				this->timeInf.push_back(time_tmp);
				time_tmp  = 0;
				if(this->isParallel.find(BBFlag)->second == 0){
					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("load")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("store")->second));
					}	
				}
			}
		}
		insFlag = 1;
		BBFlag ++;
	}
	this->timeInf.push_back(time_tmp);
	time_tmp = 0;

	errs() << "共有几个时间信息？\t" << this->timeInf.size() <<"\t个\n";
	insFlag = 1;
	BBFlag = 1;
	int i = 0;
	for(iter = this->OPNum.begin() ; iter != this->OPNum.end(); iter++){
		iter_temp = *iter;
		for(it = iter_temp.begin(); it != iter_temp.end(); it++){
			if(BBFlag <= this->BBNum){
				if(this->isParallel.find(BBFlag)->second == 0){

					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("add")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fadd")->second));
						insFlag++;
					}else if(insFlag == 3){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sub")->second));
						insFlag++;
					}else if(insFlag == 4){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fsub")->second));
						insFlag++;
					}else if(insFlag == 5){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("mul")->second));
						insFlag++;
					}else if(insFlag == 6){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fmul")->second));
						insFlag++;
					}else if(insFlag == 7){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("udiv")->second));
						insFlag++;
					}else if(insFlag == 8){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sdiv")->second));
						insFlag++;
					}else if(insFlag == 9){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fdiv")->second));
						insFlag++;
					}else if(insFlag == 10){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("urem")->second));
						insFlag++;
					}else if(insFlag == 11){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("srem")->second));
						insFlag++;
					}else if(insFlag == 12){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("frem")->second));
					}
				}
			}else{
				BBFlag = 1;
				this->timeInf[i] = this->timeInf[i] + time_tmp;
				time_tmp = 0;
				i++;
				if(this->isParallel.find(BBFlag)->second == 0){
					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("add")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fadd")->second));
						insFlag++;
					}else if(insFlag == 3){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sub")->second));
						insFlag++;
					}else if(insFlag == 4){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fsub")->second));
						insFlag++;
					}else if(insFlag == 5){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("mul")->second));
						insFlag++;
					}else if(insFlag == 6){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fmul")->second));
						insFlag++;
					}else if(insFlag == 7){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("udiv")->second));
						insFlag++;
					}else if(insFlag == 8){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sdiv")->second));
						insFlag++;
					}else if(insFlag == 9){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fdiv")->second));
						insFlag++;
					}else if(insFlag == 10){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("urem")->second));
						insFlag++;
					}else if(insFlag == 11){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("srem")->second));
						insFlag++;
					}else if(insFlag == 12){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("frem")->second));
					}
				}
			}
		}
		insFlag = 1;
		BBFlag ++;
	}

	//----------------------------------mathInsNum-------------------------------------------
	errs() <<"-------------------------------\n";
	insFlag = 1;
	BBFlag = 1;
    i = 0;
	vector<long long> math_vec;
	for(iter = this->mathInsTotal.begin() ; iter != this->mathInsTotal.end(); iter++){
		iter_temp = *iter;
		for(it = iter_temp.begin(); it != iter_temp.end(); it++){
		//	math_vec = *it;
			if(BBFlag <= this->BBNum){
				if(this->isParallel.find(BBFlag)->second == 0){
					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sqrt")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fabs")->second));
						insFlag++;
					}else if(insFlag == 3){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("log")->second));
						insFlag++;
					}else if(insFlag == 4){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("trunc")->second));
						insFlag++;
					}else if(insFlag == 5){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("exp")->second));
						insFlag++;
					}else if(insFlag == 6){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("cos")->second));
						insFlag++;
					}else if(insFlag == 7){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sin")->second));
						insFlag++;
					}else if(insFlag == 8){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("logf")->second));
						insFlag++;
					}else if(insFlag == 9){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("pow")->second));
						insFlag++;
					}else if(insFlag == 10){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("cabs")->second));
						insFlag++;
					}
				}
			}else{
				BBFlag = 1;
				this->timeInf[i] = this->timeInf[i] + time_tmp;
				time_tmp = 0;
				i++;
				if(this->isParallel.find(BBFlag)->second == 0){
					if(insFlag == 1){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sqrt")->second));
						insFlag++;
					}else if(insFlag == 2){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("fabs")->second));
						insFlag++;
					}else if(insFlag == 3){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("log")->second));
						insFlag++;
					}else if(insFlag == 4){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("trunc")->second));
						insFlag++;
					}else if(insFlag == 5){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("exp")->second));
						insFlag++;
					}else if(insFlag == 6){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("cos")->second));
						insFlag++;
					}else if(insFlag == 7){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("sin")->second));
						insFlag++;
					}else if(insFlag == 8){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("logf")->second));
						insFlag++;
					}else if(insFlag == 9){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("pow")->second));
						insFlag++;
					}else if(insFlag == 10){
						time_tmp = time_tmp + ((*it) * (this->time_map.find("cabs")->second));
						insFlag++;
					}

				}
			}
		}	

		insFlag = 1;
		BBFlag ++;
	}



	this->timeInf[i] = this->timeInf[i] + time_tmp;

	errs() << "\n\n\n";
	int p=1;

	double serial_time = 0;
	for(auto I : this->timeInf){

		//	errs() <<" 核心线程:\t" << p <<"\t 串行时间为：\t" << I <<"ns\n";
		serial_time += I;
		p++;
	}


	errs() <<"-----------------------------\n"
		<<"串行域时间为：\t" << serial_time << "\n"
		<<"-------------------------------\n";

	map<int,int>::iterator miter;
	miter = this->isParallel.begin();
	int parallelSize = 0;
	while(miter != this->isParallel.end()){
		if(miter->second >= parallelSize){
			parallelSize =  miter->second;
		}
		miter++;

	}
	errs() <<"----------------------------------------\n";
	errs() << "并行域共有：\t" << parallelSize <<"个\n";

	int threadnum = this->OPNum.size() / this->BBNum;
	//	errs() <<"共有线程数目：\t" << threadnum <<"\n";

	vector<double> parallelTime;
	vector<vector<double>> parallel;
	vector<long long> tmp;
	//第一个核心线程基本块的位置
	int BBLocation;
	//当前的位置
	int BBLocationNow;
	double parallel_time_tmp = 0 ;

	for(int pi = 1; pi <= parallelSize ; pi++){

		for(int z=0 ; z < threadnum ; z++){
			parallelTime.push_back(0);
		}

		miter = this->isParallel.begin();
		while(miter != this->isParallel.end()){
			if(miter->second == pi){
				BBLocation = miter->first - 1;
				//	errs() << "BBLocation is :\t" << BBLocation << "\n";
				BBLocationNow = BBLocation;
				int threadFlag = 0;
				while(BBLocationNow < this->OPNum.size()){			
					parallel_time_tmp = 0;

					tmp = this->LoadAndStore[BBLocationNow];
					//					errs() << "----------"<<tmp[0]<<"---------"<<tmp[1]<<"------\n";
					parallel_time_tmp = parallel_time_tmp + tmp[0] * this->time_map.find("load")->second + tmp[1] * this->time_map.find("store")->second; 

					tmp = this->OPNum[BBLocationNow];
					parallel_time_tmp = parallel_time_tmp
						+tmp[0] * this->time_map.find("add")->second 
						+tmp[1] * this->time_map.find("fadd")->second 
						+tmp[2] * this->time_map.find("sub")->second 
						+tmp[3] * this->time_map.find("fsub")->second 
						+tmp[4] * this->time_map.find("mul")->second 
						+tmp[5] * this->time_map.find("fmul")->second 
						+tmp[6] * this->time_map.find("udiv")->second 
						+tmp[7] * this->time_map.find("sdiv")->second 
						+tmp[8] * this->time_map.find("fdiv")->second 
						+tmp[9] * this->time_map.find("urem")->second 
						+tmp[10] * this->time_map.find("srem")->second
						+tmp[11] * this->time_map.find("frem")->second ;

					parallelTime[threadFlag] = parallelTime[threadFlag] + parallel_time_tmp;

//				errs() << "-----------------mathInsTotal:\t" << this->mathInsTotal.size() <<"-----------------\n";
					tmp = this->mathInsTotal[BBLocationNow];
					parallel_time_tmp = parallel_time_tmp
						+tmp[0] * this->mathTime.find("sqrt")->second
						+tmp[1] * this->mathTime.find("fabs")->second
						+tmp[2] * this->mathTime.find("log")->second
						+tmp[3] * this->mathTime.find("trunc")->second
						+tmp[4] * this->mathTime.find("exp")->second
						+tmp[5] * this->mathTime.find("cos")->second
						+tmp[6] * this->mathTime.find("sin")->second
						+tmp[7] * this->mathTime.find("logf")->second
						+tmp[8] * this->mathTime.find("pow")->second
						+tmp[9] * this->mathTime.find("cabs")->second;

					threadFlag++;
					BBLocationNow = BBLocationNow + this->BBNum;
				}
			}
			miter++;
		}

		parallel.push_back(parallelTime);
		parallelTime.clear();
	}

	errs() << "--------------并行域名执行时间如下-----------------\n";
	vector<vector<double>>::iterator piter;                                                                                                                             
	vector<double> piter_temp;                                                                                                                                      
	vector<double>::iterator pit;   

	int ppflag = 1;
	double pt_tmp = 0;
	for(piter = parallel.begin() ; piter != parallel.end() ; piter++){
		piter_temp = *piter;

		pit = max_element(begin(piter_temp),end(piter_temp));

		errs() <<"并行域\t" << ppflag << "\t时间为：\t" << *pit <<"ns\n";

		pt_tmp  += *pit; 
		ppflag++;
	}

	errs() <<"-------------------------------\n"
		<<"总时间为：\t" << pt_tmp + serial_time << "ns\n";
}
bool ComputeIns::runOnModule(Module &M){

	errs() <<"-------------runOnModule()-----------------\n";

	string s = "data.txt";
	string t = "time.txt";
	string p = "mathTime.txt";
	//获取12条指令的时间
	this->getTime(t);
	//遍历基本块得到基本块数量
	this->getBBNum(M);

	this->getMathInsTime(p);
	this->getMathInsNumInBB(M);
	errs() << "--------------------------------------------\n"
		<<"遍历得到的基本块个数为：\t" << this->BBNum << "\n";


	//根据data.txt文件获取每个基本块的执行次数
	this->getBBFrequency(s);

	errs()<<"-----------------------------------------------\n"
		<< "一共有：\t" << this->time_map.size()<< "\t指令的时间信息\n";	

	this->matchingBBwithParallel(M);

	vector<vector<long long>>::iterator iter;
	vector<long long> iter_temp;
	vector<long long>::iterator it;

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
	/**	errs() << "-----------------各种信息如下---------------\n";
	  int	BBnum = 1;
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

	  errs() <<"-------------------------------------------\n";
	 **/
	this->getMathInsNumTotal();
	this->getProTime();
//	this->test();
	return true;
}







