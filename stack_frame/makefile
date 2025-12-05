L2UOBJS = l2u_function.o
FIBOOBJS = fibonaci.o

DEBUGFLGS = -g

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 
%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: l2u_function fibonaci test_ldur

l2u_function: $(L2UOBJS)
	ld -o l2u_function $(LDFLAGS) $(L2UOBJS)

fibonaci: $(FIBOOBJS)
	gcc -o fibonaci $(FIBOOBJS)

test_ldur: test_ldur.o
	ld -o test_ldur $(LDFLAGS) test_ldur.o 

clean:
	rm *.o l2u_function fibonaci test_ldur 


