@import Foundation;

@interface ManyTriangleMaker : NSObject {
	CGContextRef mCtx;
}

- (id)
   	initWithContext: (CGContextRef) ctx;

- (void) 
	drawWithWidth     : (float) width
	andHeight         : (float) height
	andRecursionCount : (int) count ;

@end
