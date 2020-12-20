CC=clang
CFLAGS=-Wall

c: h.o l.o x.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f h.o l.o x.o
clobber: clean
	rm -f c
