@import Foundation;

@interface Triangle : NSObject {
	CGContextRef mCtx;
}

- (id)
   	initWithContext: (CGContextRef) ctx;

- (void)
   	drawWithTop    : (CGPoint) topPoint 
	andLeftBottom  : (CGPoint) leftBottomPoint 
	andRightBottom : (CGPoint) rightBottomPoint; 

@end
