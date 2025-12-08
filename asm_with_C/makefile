LIBOBJS = upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

LDFLAGS = -lSystem -lc -e main -arch arm64

all: uppertst

upper.e.o : upper.s
	as -arch arm64e $(DEBUGFLAG) $< -o upper.e.o

%.o : %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

uppertst: uppertst.c upper.s
	clang -o uppertst uppertst.c upper.s

lclean:
	rm -f *.o uppertst
