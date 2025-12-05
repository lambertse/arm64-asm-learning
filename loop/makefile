LOOPOBJS = loop.o
WLOBJS = while_loop.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 

%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: loop while_loop

loop: $(LOOPOBJS)
	ld -o loop $(LDFLAGS) $(LOOPOBJS)

while_loop: $(WLOBJS)
	ld -o while_loop $(LDFLAGS) $(WLOBJS)

clean:
	rm *.o loop while_loop 

