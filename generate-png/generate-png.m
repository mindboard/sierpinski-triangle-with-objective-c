@import Foundation;

@interface PngUtil : NSObject {}
@end

@implementation PngUtil

+ (CGContextRef)
   	contextWithWidth : (int)width
   	andHeight        : (int)height {

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(
		   	nil,
		   	width,
		   	height,
		   	8,     // bitsPerComponent
		   	0,     // bytesPerRow 
		   	colorSpace,
		   	kCGImageAlphaPremultipliedFirst);
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

int main(int argc, const char * argv[]){
	CGContextRef ctx = [PngUtil contextWithWidth:500 andHeight:500];
	[PngUtil export:ctx withFilePath:@"result.png"];
	CFRelease(ctx);
	return (0);
}
