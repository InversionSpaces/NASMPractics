	global	phandle
	extern	printnum
	extern 	printbnum
	extern 	strlen
section	.text

;======================
; Inputs:	AL - placeholder to handle
;		RSI - adress of argument
; Destroys:	RAX, RBX, RCX, RDX, RSI, RDI  
;======================
phandle:
	sub 	al, 'b' 	; ||
	mov 	bl, al 		; ||
	xor 	rax, rax 	; ||
	mov 	al, bl 		; \/
	shl 	rax, 0x3 	; rax = (al - 'b') * 8

	mov 	rbx, jtable
	add 	rbx, rax 	; rbx = table + rax

	cmp 	rbx, jtable_end
	jg	.default
	jmp 	[rbx]

.default:
	ret

.string:
	mov	rsi, [rsi] 	; rsi = address of string	
	mov	rdi, rsi
	call	strlen 		; rcx = string len (excluding null byte)
	mov	rdx, rcx

; WRITE(STDOUT, RSI, RDX) {
	mov	rax, 1h 	; write 
	mov	rdi, 1h 	; stdout

	syscall
; }

	ret
	
.hexnum:	
	mov 	cl, 4
	jmp 	.bnum
.octnum:
	mov	rbx, 8
	jmp	.bnum
.binnum:
	mov	rbx, 2
.bnum:
	mov	rax, [rsi]
	
	call 	printbnum
	
	ret

.decnum:
	mov	rbx, 10
	mov	rax, [rsi]
	
	call	printnum

	ret

.char:
; WRITE(STDOUT, RSI, RDX) {
	mov	rdx, 1h 	; len = 1
	mov	rax, 1h 	; write
	mov	rdi, 1h 	; stdout

	syscall
; }

	ret

	section .data
jtable:		dq phandle.binnum,
		dq phandle.char,
		dq phandle.decnum,
		times 10 dq phandle.default,
		dq phandle.octnum,
		times 3 dq phandle.default,
		dq phandle.string,
		times 4 dq phandle.default,
		dq phandle.hexnum
jtable_end: 	dq phandle.default
