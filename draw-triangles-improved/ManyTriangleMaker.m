@import Foundation;

#import "Triangle.h"
#import "ManyTriangleMaker.h"


@implementation ManyTriangleMaker

+ (void)
   	drawTriangle    : (Triangle *) triangle
   	andCounter      : (int) counter
   	andStartPoint   : (CGPoint) startPoint
   	andLengthOfSide : (int) lengthOfSide {

	// 1) check counter
	if( counter<0 ){
		return ;
	}

	// 2) draw triangle
	CGPoint bottomLeftPoint  = CGPointMake(
		   	startPoint.x - lengthOfSide/2, startPoint.y + lengthOfSide ); 
	CGPoint bottomRightPoint = CGPointMake(
		   	startPoint.x + lengthOfSide/2, startPoint.y + lengthOfSide ); 

	[triangle drawWithTop:startPoint andLeftBottom:bottomLeftPoint andRightBottom:bottomRightPoint];

	// 3) recursion
	[ManyTriangleMaker
	   	drawTriangle   : triangle
	   	andCounter     : counter-1
	   	andStartPoint  : startPoint
 		andLengthOfSide: lengthOfSide/2 ];
	[ManyTriangleMaker
	   	drawTriangle   : triangle
	   	andCounter     : counter-1
	   	andStartPoint  : bottomLeftPoint
	  	andLengthOfSide: lengthOfSide/2 ];
	[ManyTriangleMaker
	   	drawTriangle   : triangle
	   	andCounter     : counter-1
	   	andStartPoint  : bottomRightPoint
	   	andLengthOfSide: lengthOfSide/2 ];
}

- (id)
   	initWithContext: (CGContextRef) ctx {

	self = [super init];
	if( self ){
	   	mCtx = ctx;
	}
	return (self);
} 

- (void) 
	drawWithWidth     : (float) width
	andHeight         : (float) height
	andRecursionCount : (int) count {

	Triangle *triangle = [[Triangle alloc] initWithContext:mCtx];
	[ManyTriangleMaker drawTriangle:triangle andCounter:count andStartPoint:CGPointMake(width/2, 0) andLengthOfSide: width/2];
}

@end
