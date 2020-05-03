	global	printnum
	global 	printbnum
	
	section	.text
;===================
; Inputs:	RAX - number to print
;		CL - power of binary base
; Outputs:	number in base to stdout
; Destructs:	RAX, RCX, RDX, RSI
;===================
printbnum:
	xor 	ch, ch
	inc 	ch
	shl 	ch, cl
	dec 	ch 		; ch = (1 << cl) - 1

	mov	rsi, buffer + bufsize
	xor 	rdx, rdx

.convert:
; convert {
	dec	rsi

	mov 	dl, al
	and 	dl, ch 		; rdx = rax & ch
	shr 	rax, cl 	; rax = rax >> cl
	
	mov	dl, [dict + rdx]
	mov	[rsi], dl

	test	rax, rax
	jne	.convert
; } convert

	mov	rdx, buffer + bufsize
	sub	rdx, rsi 		; rdx = number of chars to write

; WRITE(STDOUT, RSI, RDX) {
	mov	rax, 1h 	; write
	mov	rdi, 1h 	; stdout
	
	syscall
; }

	ret

;===================
; Inputs:	RAX - number to print
;		RBX - base
; Outputs:	number in base to stdout
; Destructs:	RAX, RSI, RDX
;===================
printnum:
	mov	rsi, buffer + bufsize

.convert:
; convert {
	dec	rsi

	xor	rdx, rdx		; rdx = 0
	div	rbx			; rdx = r, rax = q
	
	mov	dl, [dict + rdx]
	mov	[rsi], dl

	cmp	rax, 0h
	jne	.convert
; } convert

	mov	rdx, buffer + bufsize
	sub	rdx, rsi 		; rdx = number of chars to write

; WRITE(STDOUT, RSI, RDX) {
	mov	rax, 1h 	; write
	mov	rdi, 1h 	; stdout
	
	syscall
; }

	ret

	section	.data
dict:	db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
buffer:	times 64 db 0
bufsize	equ $ - buffer
