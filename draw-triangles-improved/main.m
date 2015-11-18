@import Foundation;

#import "PngUtil.h"
#import "ManyTriangleMaker.h"

int main(int argc, const char * argv[]){

	// 0)
	float width  = 500;
	float height = 500;

	// 1) create ctx
	CGContextRef ctx = [PngUtil contextWithWidth:width andHeight:height];

	// 2) draw many triangles
	ManyTriangleMaker *manyTriangleMaker = [[ManyTriangleMaker alloc] initWithContext:ctx];
	[manyTriangleMaker drawWithWidth:width andHeight:height andRecursionCount:8];

	// 3) save ctx
	[PngUtil export:ctx withFilePath:@"result.png"];

	// 4)
	CFRelease(ctx);

	return (0);
}
