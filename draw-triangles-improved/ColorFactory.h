@import Foundation;

@interface ColorFactory : NSObject

@property CGFloat a;
@property CGFloat r;
@property CGFloat g;
@property CGFloat b;

+ (CGColorRef) blackColor;

- (id)
   	initWithAlpha: (CGFloat) a
   	andR: (CGFloat) r
   	andG: (CGFloat) g
   	andB: (CGFloat) b;

- (CGColorRef)
   	color; 

@end
