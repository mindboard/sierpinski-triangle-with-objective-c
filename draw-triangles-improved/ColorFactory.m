@import Foundation;

#import "ColorFactory.h"


@implementation ColorFactory

+ (CGColorRef) blackColor {
	ColorFactory *black = [[ColorFactory alloc] initWithAlpha:1.0 andR:0 andG:0 andB:0];
	return [black color];
}

- (id)
   	initWithAlpha: (CGFloat) a
   	andR: (CGFloat) r
   	andG: (CGFloat) g
   	andB: (CGFloat) b {

	self = [super init];
	if( self ){
	   	self.a = a;
	   	self.r = r;
	   	self.g = g;
	   	self.b = b;
	}
	return (self);
}

- (CGColorRef) color {
	CGFloat colorRGBA[] = { self.r, self.g, self.b, self.a };
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
   	CGColorRef color = CGColorCreate(space,colorRGBA);
   	CGColorSpaceRelease(space);
	return color;
}

@end
