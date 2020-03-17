	global	phandle
	extern	printnum
	extern	prints
section	.text

;======================
; Inputs:	AL - placeholder to handle
;		RSI - adress of argument
; Destroys:	RAX, RBX, RCX, RDX, RSI, RDI  
;======================
phandle:
	cmp	al, 's'
	je	string

	cmp	al, 'x'
	je	hexnum

	cmp	al, 'o'
	je	octnum

	cmp	al, 'b'
	je	binnum

	cmp	al, 'c'
	je	char

	ret

string:
	mov	rsi, [rsi]

	call	prints

	ret
	
hexnum:	
	mov	rbx, 16
	jmp	num

octnum:
	mov	rbx, 8
	jmp	num
	
binnum:
	mov	rbx, 2

num:
	mov	rax, [rsi]

	call	printnum
	
	ret

char:
	mov	rdx, 1h
	mov	rax, 1h
	mov	rdi, 1h

	syscall

	ret
