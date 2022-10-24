all: kph 

MYLIBS = libConversions.o 
CC = gcc 

kph: kphMain.o $(MYLIBS) 
	$(CC) $@Main.o $(MYLIBS) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean: 
	rm -f *.o a.out

