@import Foundation;

@interface PngUtil : NSObject

+ (CGContextRef)
   	contextWithWidth : (int)width
   	andHeight        : (int)height ;

+ (void)
   	export       : (CGContextRef) ctx
	withFilePath : (NSString *) outputPngPath ;

@end

@implementation PngUtil

+ (CGContextRef)
   	contextWithWidth : (int)width
   	andHeight        : (int)height {

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate( nil, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
   	CGColorSpaceRelease(colorSpace);

	return ctx;
}

+ (CFDictionaryRef)
	optionsWithResolution : (float) resolution {

	CFTypeRef type = CFNumberCreate(NULL,kCFNumberFloatType,&resolution);
	CFDictionaryRef pngOptions = [PngUtil optionsWithType:type];
	CFRelease( type );

	return pngOptions;
}

+ (CFDictionaryRef)
   	optionsWithType : (CFTypeRef) type {

	CFTypeRef keys[2];
	keys[0] = kCGImagePropertyDPIWidth;
   	keys[1] = kCGImagePropertyDPIHeight;

	CFTypeRef values[2];
   	values[0] = type;
   	values[1] = type;

	return CFDictionaryCreate(NULL,keys,values,2,&kCFTypeDictionaryKeyCallBacks,&kCFTypeDictionaryValueCallBacks);
}

+ (CGImageDestinationRef)
	imageDestination : (NSString *) outputPngPath {

	CFURLRef savePngFileUrl = CFURLCreateWithFileSystemPath (NULL, (CFStringRef)outputPngPath, kCFURLPOSIXPathStyle, 0);
	CGImageDestinationRef destination = CGImageDestinationCreateWithURL( savePngFileUrl, kUTTypePNG, 1, nil );
	CFRelease(savePngFileUrl);
	return destination;
}

+ (void)
   	export       : (CGContextRef) ctx
	withFilePath : (NSString *) outputPngPath {

	CGImageDestinationRef destination = [PngUtil imageDestination:outputPngPath];
	CGImageRef            cgImage     = CGBitmapContextCreateImage(ctx);
	CFDictionaryRef       pngOptions  = [PngUtil optionsWithResolution:72.0];

	CGImageDestinationAddImage(destination, cgImage, pngOptions);
	CGImageDestinationFinalize(destination);

	// Memory management
	CFRelease( pngOptions );
	CFRelease( cgImage ); 
	CFRelease( destination ); 
}

@end


@interface ColorFactory : NSObject {}

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
- (CGColorRef) color; 
@end

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


@interface Triangle : NSObject {
	CGContextRef mCtx;
}
- (id) initWithContext: (CGContextRef) ctx;
- (void)
   	drawWithTop    : (CGPoint) topPoint 
	andLeftBottom  : (CGPoint) leftBottomPoint 
	andRightBottom : (CGPoint) rightBottomPoint; 
@end

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



int main(int argc, const char * argv[]){

	// 0)
	float width  = 500;
	float height = 500;

	// 1) create ctx
	CGContextRef ctx = [PngUtil contextWithWidth:width andHeight:height];

	// 2) draw triangle
	CGPoint pt0 = CGPointMake( width/2, 0 );
	CGPoint pt1 = CGPointMake( 0      , height );
	CGPoint pt2 = CGPointMake( width  , height );

	Triangle *triangle = [[Triangle alloc] initWithContext:ctx];
	[triangle drawWithTop:pt0 andLeftBottom:pt1 andRightBottom:pt2];

	// 3) save ctx
	[PngUtil export:ctx withFilePath:@"result.png"];

	// 4)
	CFRelease(ctx);

	return (0);
}
