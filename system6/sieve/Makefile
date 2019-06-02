project = sieve

objs = $(project).o

cc=gcc
CFLAGS := $(CFLAGS) -Wall

all: $(project)

.PHONY: all
all: $(project)


$(project): $(objs)

.PHONY: clean
clean:
	rm -f $(project)
	rm -f *.o
