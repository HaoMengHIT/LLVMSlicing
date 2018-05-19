#ifndef DEBUG_H
#define DEBUG_H
//**********************************************
//  Must Include this File After All #include
//**********************************************

#include <llvm/Support/raw_ostream.h>

#ifdef NO_DEBUG
#undef DEBUG
#define DEBUG(expr) 
#undef NDEBUG
#define NDEBUG

#else

#undef DEBUG
#define DEBUG(expr) expr
#undef NDEBUG
#endif

#include <assert.h> // NDEBUG macro would affact this

//disable some output code 
//dont use comment because consider code may used in future
//but comment may be delete sometimes
#define DISABLE(expr) 

// a assert with output llvm values
#define Assert(expr, value) assert( (expr) || (llvm::errs()<<"\n>>>"<<value<<"<<<\n",0) )

// a assert which always need check
#define AssertRuntime(expr, msg) if( !(expr) ){ \
   llvm::errs()<<"Assert Failed:"<<__FILE__<<":"<<__LINE__<<"\n"; \
   llvm::errs()<<msg<<"\n";\
   assert(expr);\
   exit(-1);\
}

class raw_temporary_string_stream: public llvm::raw_string_ostream
{
   std::string str;
   public:
   raw_temporary_string_stream():raw_string_ostream(str) {}
};


#define AssertThrow(expr, except) {if(!(expr)) throw except;}
#define dbg() (raw_temporary_string_stream()<<"")

#define ret_on_failed(expr,msg,ret) { if(!(expr)){llvm::errs()<<"Failed at "<<__LINE__<<":"<<msg<<"\n"; return ret;} }
#define ret_null_fail(expr,msg) ret_on_failed(expr,msg,NULL);

#endif
