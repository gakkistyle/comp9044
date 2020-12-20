CC=clang
CFLAGS=-Wall

p: b.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f b.o
clobber: clean
	rm -f p
