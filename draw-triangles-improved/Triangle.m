@import Foundation;

#import "Triangle.h"
#import "ColorFactory.h"


@implementation Triangle

- (id)
   	initWithContext: (CGContextRef) ctx {

	self = [super init];
	if( self ){
	   	mCtx = ctx;
	}
	return (self);
} 

- (void)
   	drawWithTop    : (CGPoint) topPoint 
	andLeftBottom  : (CGPoint) leftBottomPoint 
	andRightBottom : (CGPoint) rightBottomPoint {

	// 1) color and strokeWidth
	CGColorRef black = [ColorFactory blackColor];
	CGContextSetStrokeColorWithColor(mCtx, black);
	float strokeWidth = 1.0;
	CGContextSetLineWidth(mCtx, strokeWidth);

	// 2) build path
	CGMutablePathRef path = CGPathCreateMutable();

	CGPathMoveToPoint   (path, NULL, topPoint.x,         topPoint.y);
	CGPathAddLineToPoint(path, NULL, leftBottomPoint.x,  leftBottomPoint.y);
	CGPathAddLineToPoint(path, NULL, rightBottomPoint.x, rightBottomPoint.y);
	CGPathCloseSubpath(path);

	CGContextAddPath(mCtx, path);

	// 3) stroke
	CGContextStrokePath(mCtx);

	// 4) release
	CGColorRelease(black);
	CGPathRelease(path);
}

@end
