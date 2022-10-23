all: inches2Ft 

MYLIBS = libConversions.o libTypes.o 
CC = gcc 

inches2Ft: inches2FtMain.o $(MYLIBS) 
	$(CC) $@Main.o $(MYLIBS) -g -o $@ 
	./$@

.s.o: 
	$(CC) $(@:.o=.s) -g -c -o $@ 

clean: 
	rm *.o a.out

