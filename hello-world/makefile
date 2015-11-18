clangoptions:=-fobjc-arc -fmodules
frameworks  :=-framework Foundation

run : hello-world
	./$<

hello-world : hello-world.m
	clang -o $@ $(clangoptions) $(frameworks) $<

clean : 
	$(RM) ./hello-world
