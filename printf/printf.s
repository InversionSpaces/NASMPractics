	global	_start

	extern	strlen
	extern	phandle

	section   .text
_start:
	mov	rdi, teststr

	mov	rax, 127
	push	rax

	mov	rax, '!'
	push	rax

	mov	rax, 100
	push	rax

	mov	rax, 3802
	push	rax

	mov	rsi, inner
	push	rsi

	call	printf	
	
	mov	rax, 60                 ; system call for exit
	xor	rdi, rdi                ; exit code 0
	
	syscall				; invoke operating system to exit
;=====================
; Inputs:	RDI - address of format string
;		STACK - args top to bottom
; Outputs:	Formatted string to stdout
; Destroys:	RDI, RSI, RAX, RBX, RCX, RDX, R8, R9, R10
;=====================	
printf:
	xor	rbx, rbx	; rbx = 0 // args counter

	mov	rsi, rdi
	call	strlen 		; rcx = string len (excluding null byte)
	mov	rdi, rsi

percent_loop:
	mov	al, '%'

	mov	rsi, rdi	; rsi = rdi
	mov	rdx, rcx	; rdx = rcx

	repne	scasb		; finding '%'

	sub	rdx, rcx	; rdx = number of skipped symbols
	
	cmp	rcx, 0h
	je	no_percent	; string ended

	mov	r10b, [rdi]
	cmp	r10b, '%'
	je	write		; if symbol is '%' - we can just write it

	dec	rdx		; rdx = number of symbols before next %

	cmp	rdx, 0h
	je	handle		; if rdx == 0 then dont need to write

write:
; WRITE(STDOUT, RSI, RDX) {
	mov	r9, rcx		; save rcx
	mov	r8, rdi		; save rdi	
	
	mov	rax, 1h		; write
	mov	rdi, 1h		; stdout

	syscall

	mov	rcx, r9		; restore rcx
	mov	rdi, r8		; restore rdi
; }

	cmp	r10b, '%'
	je	next		; if symbol '%' - dont need to handle it

handle:
; HANDLE {
	mov	al, [rdi]			; placeholder to handle
	lea	rsi, [rsp + 8 + rbx * 8]	; argument

	mov	r8, rbx		; save rbx
	mov	r9, rcx		; save rcx
	mov	r10, rdi	; save rdi

	call	phandle

	mov	rbx, r8		; restore rbx
	mov	rcx, r9		; restore rdi
	mov	rdi, r10	; restore rdi
	
	inc	rbx		; args++
; }

next:	
	inc	rdi		; skip char after %
	dec	rcx		; dec counter of remaining chars

	cmp	rcx, 0h		
	jne	percent_loop	; if chars left - continue
	jmp	printf_end	; if string ended - stop

no_percent:
	cmp	rdx, 0h
	je	printf_end	; if rdx == 0 then dont need to write

; WRITE(STDOUT, RSI, RDX)
	mov	rax, 1
	mov	rdi, 1

	syscall
; }

printf_end:
	ret

	section   .data
teststr:	db	"I %s %x %d%%%c%b", 0h
inner:		db	"love", 0h
