@import Foundation;

@interface PngUtil : NSObject

+ (CGContextRef)
   	contextWithWidth : (int)width
   	andHeight        : (int)height ;

+ (void)
   	export       : (CGContextRef) ctx
	withFilePath : (NSString *) outputPngPath ;

@end
