	global	printnum
	
	section	.text

;===================
; Inputs:	RAX - number to print
;		RBX - base
; Outputs:	number in base to stdout
; Destructs:	RAX, RSI, RDX
;===================
printnum:
	mov	rsi, buffer + bufsize

convert:
; convert {
	dec	rsi

	xor	rdx, rdx		; rdx = 0
	div	rbx			; rdx = r, rax = q
	
	mov	dl, [dict + rdx]
	mov	[rsi], dl

	cmp	rax, 0h
	jne	convert
; } convert

	mov	rdx, buffer + bufsize
	sub	rdx, rsi

; WRITE(STDOUT, RSI, RDX) {
	mov	rax, 1h
	mov	rdi, 1h
	
	syscall
; }
	ret

	section	.data
dict:	db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
buffer:	times 64 db 0
bufsize	equ $ - buffer
