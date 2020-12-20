CC=clang
CFLAGS=-Wall

r: r.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f r.o
clobber: clean
	rm -f r
