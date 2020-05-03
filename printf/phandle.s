	global	phandle
	extern	printnum
	extern 	strlen
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
	
	cmp	al, 'd'
	je	decnum

	ret

string:
	mov	rsi, [rsi] 	; rsi = address of string
	
	mov	rdi, rsi
	call	strlen 		; rcx = string len (excluding null byte)

	mov	rdx, rcx
	mov	rax, 1h 	; write 
	mov	rdi, 1h 	; stdout

	syscall

	ret
	
hexnum:	
	mov	rbx, 16
	jmp	num

octnum:
	mov	rbx, 8
	jmp	num
	
binnum:
	mov	rbx, 2
	jmp	num

decnum:
	mov	rbx, 10

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
