CC=clang
CFLAGS=-Wall

m: o.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f o.o
clobber: clean
	rm -f m
