AS=nasm
SRCS=$(wildcard *.s)
OBJS=$(SRCS:%.s=%.o)

%.o: %.s
	$(AS) -felf64 $< -o $@

all: $(OBJS)
	ld $(OBJS) -o printf

clean:
	rm -f $(OBJS)
