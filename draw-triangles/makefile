
clangoptions:=-fobjc-arc -fmodules
frameworks  :=-framework CoreGraphics -framework Foundation

run : draw-triangles
	./$<

draw-triangles : draw-triangles.m
	clang -o $@ $(clangoptions) $(frameworks) $<

clean :
	$(RM) draw-triangles
	$(RM) *.png
