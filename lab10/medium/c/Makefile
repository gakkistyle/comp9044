CC=clang
CFLAGS=-Wall

d: p.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f p.o
clobber: clean
	rm -f d
