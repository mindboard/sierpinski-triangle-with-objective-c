
clangoptions:=-fobjc-arc -fmodules
frameworks  :=-framework CoreGraphics -framework Foundation
objs:=PngUtil.o Triangle.o ManyTriangleMaker.o ColorFactory.o


%.o : %.m
	clang -c $< $(clangoptions)


run : main 
	./$<

main : main.m $(objs)
	clang -o $@ $(clangoptions) $(frameworks) $< $(objs)

clean :
	$(RM) main
	$(RM) *.o
	$(RM) *.png
