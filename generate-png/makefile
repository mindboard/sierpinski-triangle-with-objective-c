
clangoptions:=-fobjc-arc -fmodules
frameworks  :=-framework CoreGraphics -framework Foundation

run : generate-png
	./$<

generate-png : generate-png.m
	clang -o $@ $(clangoptions) $(frameworks) $<

clean :
	$(RM) generate-png
	$(RM) *.png
