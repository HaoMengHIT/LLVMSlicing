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
    class ModuleTest:public ModulePass{
        public:
            static char ID;//pass Identification
            ModuleTest():ModulePass(ID){}
            vector<int> isParallel;
            map<Function*, int> parallelRegion;
            void isBBParallel(Module& M, BasicBlock * BB);
            int isIteParallel(Module& M, Function* FF, int regionId, Function* F);
            void judgeIsParallel(Module &M);
            Function* getFunction(Value *Call);
            bool runOnModule(Module &M) override;
    };

}

char ModuleTest::ID = 0 ;

//regite pass
static RegisterPass<ModuleTest> X("module-test","Module Test",false,false);

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

Function* ModuleTest::getFunction(Value *Call)
{
    if(Call==NULL) return NULL;
    CallInst* CI = dyn_cast<CallInst>(Call);
    if(CI==NULL) return NULL;
    return dyn_cast<Function>(castoff(CI->getCalledValue()));
}


int ModuleTest::isIteParallel(Module& M, Function* FF, int regionId, Function* F)
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
void ModuleTest::isBBParallel(Module&M, BasicBlock * BB)
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
    this->isParallel.push_back(regionId);

    return;
}
void ModuleTest::judgeIsParallel(Module &M)
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
            isBBParallel(M, &*BB);
        }
    }

    return;
}


bool ModuleTest::runOnModule(Module &M){
    errs()<<"Hello world\n";
    judgeIsParallel(M);

    for(int i = 0; i < this->isParallel.size();i++)
    {
        errs()<< i<<"\t"<<this->isParallel[i]<<"\n";
    }
    return true;
}
