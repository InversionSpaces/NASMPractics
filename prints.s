	global	prints
	extern	strlen

section	.text
;====================
; Inputs:	RSI - adress of null-terminated string to print 
; Outputs:	String to stdout
; Destroys:	RSI, RDI, RDX, RAX, RCX 
;====================
prints:
	mov	rdi, rsi
	call	strlen

	mov	rdx, rcx
	mov	rax, 1h
	mov	rdi, 1h

	syscall

	ret

section	.data
string:	db "Super string", 0h