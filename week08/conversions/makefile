all: conversions 

MYLIBS = conversions.o 
CC = gcc 

conversions: conversionsMain.o $(MYLIBS) 
	$(CC) $@Main.o $(MYLIBS) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean: 
	rm -f *.o a.out

