project = munchausen

objs =tetration.o munchausen.o $(project).o
filesdir = /user/cse320/files

CC=gcc
CFLAGS := $(CFLAGS) -Wall
LDLIBS := $(LDLIBS) -L$(filesdir)/lib -l320

all: $(project)

.PHONY: all
all: $(project)

$(project): $(objs)

.PHONY: clean
clean:
	rm -f $(outputfile)
	rm -f *.o
