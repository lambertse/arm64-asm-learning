L2UOBJS = l2u_function.o

DEBUGFLGS = -g

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 

%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: l2u_function

l2u_function: $(L2UOBJS)
	ld -o lower_to_upper $(LDFLAGS) $(L2UOBJS)

clean:
	rm *.o l2u_function 


