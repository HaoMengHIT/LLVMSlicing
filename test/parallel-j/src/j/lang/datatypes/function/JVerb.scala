package j.lang.datatypes.function

import j.lang.datatypes.JFuncRank
import j.lang.datatypes.JTypeMacros._
import j.lang.datatypes.array.JArray
import j.lang.datatypes.array.JArrayType
import j.lang.datatypes.array.JArrayFrame
import j.lang.datatypes.array.types.JNumberTypes._
import sun.reflect.generics.reflectiveObjects.NotImplementedException

abstract class JVerb[M <: JArrayType : Manifest, D1 <: JArrayType : Manifest, D2 <: JArrayType : Manifest,
  MR <: JArrayType : Manifest, DR <: JArrayType : Manifest]
  (rep: String, val ranks: List[JFuncRank], mdomain: JTypeMacro, d1domain: JTypeMacro, d2domain: JTypeMacro) extends 
  JFunc[JArray[M], JArray[D1], JArray[D2], JArray[MR], JArray[DR]](rep, jVERB, mdomain, d1domain, d2domain) {

  def apply[T <: JArray[M]](y: T) = monad(y)
  
  override def monad[T <: JArray[M]](y: T) = { //some testing with types and shape
	  val jaf = JArrayFrame(ranks.map(_ r1), y)

	   val newCells = if (!JVerb.parallelFlag) {
	    (0 until jaf.frameSize) map { fr =>
	    monadImpl(JArray(jaf.jar.jaType, jaf.cellShape, jaf.jar.ravel.slice(fr*jaf.cellSize, (1+fr)*jaf.cellSize)))
	  }}
	   else {
   	    (0 until jaf.frameSize).par map { fr =>
	    monadImpl(JArray(jaf.jar.jaType, jaf.cellShape, jaf.jar.ravel.slice(fr*jaf.cellSize, (1+fr)*jaf.cellSize)))
	   }}
	  
	  val newShape = jaf.frames.dropRight(ranks.length).foldLeft(List[Int]())(_ ++ _) ++ newCells(0).shape
	  JArray(newCells(0).jaType, newShape, newCells.foldLeft(Vector[MR]())(_ ++ _.ravel))
	}
	
//TODO reflex
  
  	def apply[T1 <: JArray[D1], T2 <: JArray[D2]](x: T1, y: T2) = dyad(x,y)
  	
	override def dyad[T1 <: JArray[D1], T2 <: JArray[D2]](x: T1, y: T2) = {
	  val jafx = JArrayFrame(ranks.map(_ r2), x)
	  val jafy = JArrayFrame(ranks.map(_ r3), y)

	  jafx.shapeAgreement(jafy) match {
	    case None => throw new Exception() //TODO shape error
	    case Some(agree) => {
	      val xreframed = jafx.shapeToNewFrame(agree)
	      val yreframed = jafy.shapeToNewFrame(agree)

	      val xcellShape = jafx.frames.last
	      val xcellSize = xcellShape.foldLeft(1)(_ * _)
	      val ycellShape = jafy.frames.last
	      val ycellSize  = ycellShape.foldLeft(1)(_ * _)
	      val frameSize  = agree.init.foldLeft(1)(_ * _.foldLeft(1)(_ * _))
	      
	      val newCells = if (!JVerb.parallelFlag) { 
	        (0 until frameSize) map { fr =>
	        dyadImpl(JArray(jafx.jar.jaType, xcellShape, xreframed.ravel.slice(fr*xcellSize, (1+fr)*xcellSize)),
	        		 JArray(jafy.jar.jaType, ycellShape, yreframed.ravel.slice(fr*ycellSize, (1+fr)*ycellSize)) )
	      }}
	      else {
	        (0 until frameSize).par map { fr =>
	        dyadImpl(JArray(jafx.jar.jaType, xcellShape, xreframed.ravel.slice(fr*xcellSize, (1+fr)*xcellSize)),
	        		 JArray(jafy.jar.jaType, ycellShape, yreframed.ravel.slice(fr*ycellSize, (1+fr)*ycellSize)) )	        
	      }}

	      val newShape = agree.dropRight(1).foldLeft(List[Int]())(_ ++ _) ++ newCells(0).shape
	      JArray(newCells(0).jaType, newShape, newCells.foldLeft(Vector[DR]())(_ ++ _.ravel))
	    }
	  }
	}
  
 def addRanks(r: JFuncRank) = {
    val thisotherthing = this
    new JVerb[M,D1,D2,MR,DR](
        rep + "(\"" + r + ")",
        ranks :+ r,
        mdomain, d1domain, d2domain) {
     
      override def monadImpl[T <: M : Manifest](y: JArray[T]) = {
        thisotherthing(y)
      }
      override def dyadImpl[T1 <: D1 : Manifest, T2 <: D2 : Manifest](x: JArray[T1], y: JArray[T2]) = 
        thisotherthing(x, y)
    }
  }
  	
  //TODO leverage (implicit ev1: D1 =:= D2, ev2: D2 =:= DR)
  def insert(implicit ev1: JArray[D1] =:= JArray[D2], ev2: JArray[DR] =:= JArray[D2], ev3: JArray[D2] =:= JArray[D1]) = {
    import j.lang.datatypes.array.types.JNumberTypes._
    
    val thisotherthing = this
    new JVerb[D1,D1,D1,D1,D1](
        rep + "/",
        ranks :+ JFuncRank(JInfinity),
        mdomain, d1domain,d2domain
    ){

      protected override def monadImpl[T <: D1 : Manifest](y: JArray[T]) = { 
        y.numItemz match {
        case 0 => throw new Exception() //TODO should fetch identity element
        case 1 => y
        case n: Int => {
        	 (0 until n).map(j => ev1(y(j))).reduce((y1, y2) => {
        	  ev2(thisotherthing.dyad(ev3(y1), y2))
        	})
        }
      }}
      
      protected override def dyadImpl[T1 <: D1 : Manifest, T2 <: D1 : Manifest](x: JArray[T1], y: JArray[T2]) = {
        throw new NotImplementedException()//TODO implement
      }
    }
  }
  
  	def agenda(f: JVerb1Type[JInt], t: JVerb1Type[JInt])(
  	    implicit ev1: JVerb[M,D1,D2,MR,DR] =:= JVerb[JInt, JInt, JInt, JInt, JInt]) = {
  	  
  	  val tref: JVerb[JInt, JInt, JInt, JInt, JInt] = ev1(this)
  	  
  	  new JVerb1Type[JInt](
  	      f.rep + " ` " + t.rep + "@. " + tref.rep,
  	      tref.ranks :+ JFuncRank(JInfinity),
  	      jINT){
  	    
  	    override def monadImpl[T <: JInt : Manifest](y: JArray[T]) = {

  	    	if (tref(y).ravel(0) == JReal.Zero) {
  	    	  f(y)
  	    	}
  	    	else t(y)
  	    }
  	    
  	    override def dyadImpl[T1 <: JInt : Manifest, T2 <: JInt : Manifest](x: JArray[T1], y: JArray[T2]) = {
  	      if (tref(x,y) == JReal.Zero) f(x,y)
  	      else t(x,y)
  	    }
  	  }
  	}
 
  	def power(times: JArray[JInt])(
  	    implicit ev1: JArray[MR] =:= JArray[M], 
  	    ev2: JArray[M] =:= JArray[MR]): JVerb[M,D1,D2,MR,DR] = {
  	  val tref = this
  	  
  	  new JVerb[M,D1,D2,MR,DR](
  	      "(" + tref.rep + "^:" + times + ")",
  	      tref.ranks :+ JFuncRank(JInfinity),
  	      tref.mdomain, tref.d1domain, tref.d2domain){
  	    
  	    override def monadImpl[T <: M : Manifest](y: JArray[T]) = {
  	      var ret: JArray[M] = y
  	      
  	      for (i <- 0 until times.ravel(0).v) {
  	        //val ret = ev1(tref(y))
  	        ret = ev1(tref(ret))
  	      }
  	      
  	      ret
  	    }
  	    
  	    override def dyadImpl[T1 <: D1 : Manifest, T2 <: D2 : Manifest](x: JArray[T1], y: JArray[T2]) = {
  	      throw new NotImplementedException()
  	    }
  	  }
  	}
  	
	protected def monadImpl[T <: M : Manifest](y: JArray[T]): JArray[MR]
	protected def dyadImpl[T1 <: D1 : Manifest, T2 <: D2 : Manifest](x: JArray[T1], y: JArray[T2]): JArray[DR]
}

object JVerb {
  var parallelFlag = false
}
