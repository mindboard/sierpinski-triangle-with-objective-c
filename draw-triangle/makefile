
clangoptions:=-fobjc-arc -fmodules
frameworks  :=-framework CoreGraphics -framework Foundation

run : draw-triangle
	./$<

draw-triangle : draw-triangle.m
	clang -o $@ $(clangoptions) $(frameworks) $<

clean :
	$(RM) draw-triangle
	$(RM) *.png
