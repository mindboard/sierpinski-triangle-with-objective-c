
clangoptions:=-fobjc-arc -fmodules

run : generate-png
	./$<

generate-png : generate-png.m
	clang -o $@ $(clangoptions) -framework CoreGraphics -framework Foundation $<

clean :
	$(RM) generate-png
	$(RM) *.png
