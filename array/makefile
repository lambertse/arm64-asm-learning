CSOBJS = codesnippets.o
ARROBJS = array.o
L2UOBJS = lower_to_upper.o

DEBUGFLGS = -g

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 

%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: codesnippets array lower_to_upper

codesnippets: $(CSOBJS)
	ld -o codesnippets $(LDFLAGS) $(CSOBJS)

array: $(ARROBJS)
	ld -o array $(LDFLAGS) $(ARROBJS)

lower_to_upper: $(L2UOBJS)
	ld -o lower_to_upper $(LDFLAGS) $(L2UOBJS)

clean:
	rm *.o codesnippets array lower_to_upper 

