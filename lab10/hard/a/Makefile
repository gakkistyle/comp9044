CC=clang
CFLAGS=-Wall

b: p.o r.o q.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f p.o r.o q.o
clobber: clean
	rm -f b
