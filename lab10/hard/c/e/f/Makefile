CC=clang
CFLAGS=-Wall

i: a.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f a.o
clobber: clean
	rm -f i
