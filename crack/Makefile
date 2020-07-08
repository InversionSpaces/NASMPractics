CC=gcc

data:
	./out_crack < crackdata

dynamic:
	$(CC) -fPIC -shared fake_scanf.c -o fake_scanf.so -ldl
	LD_PRELOAD=$(shell pwd)/fake_scanf.so ./out_crack

patch:
	$(CC) patch.c -o patch
	cp out_crack out
	./patch out
	./out

clean:
	rm -f patch
	rm -f fake_scanf.so
