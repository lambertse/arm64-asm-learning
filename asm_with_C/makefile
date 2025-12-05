SPOBJS = simple_printf.o

DEBUGFLGS = -g

GCCFLAGS = -Wall -e _start -arch arm64 
%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: simple_printf

simple_printf: $(SPOBJS)
	gcc -o simple_printf $(GCCFLAGS) $(SPOBJS)

clean:
	rm *.o simple_printf 

