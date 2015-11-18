
clangoptions:=-fobjc-arc -fmodules

run : draw-triangle
	./$<

draw-triangle : draw-triangle.m
	clang -o $@ $(clangoptions) -framework CoreGraphics -framework Foundation $<

clean :
	$(RM) draw-triangle
	$(RM) *.png
