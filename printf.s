	global	_start

	extern	strlen
	extern	phandle

	section   .text
_start:
	mov	rdi, teststr

	mov	rax, 125
	push	rax

	mov	rax, 'n'
	push	rax

	mov	rsi, inner
	push	rsi

	call	printf	
	
	mov	rax, 60                 ; system call for exit
	xor	rdi, rdi                ; exit code 0
	
	syscall				; invoke operating system to exit
;=====================
;
;
;=====================	
printf:
	xor	rbx, rbx	; rbx = 0 // args counter

	mov	rsi, rdi
	call	strlen
	mov	rdi, rsi

percent_loop:
	mov	al, '%'

	mov	rsi, rdi	; rsi = rdi
	mov	rdx, rcx	; rdx = rcx

	repne	scasb		; finding '%'

	sub	rdx, rcx	; rdx = number of skipped symbols
	
	cmp	rcx, 0h
	je	no_percent	; string ended

	dec	rdx		; rdx = number of symbols before next %

	cmp	rdx, 0h
	je	handle		; if rdx == 0 then dont need to write

; WRITE(STDOUT, RSI, RDX) {
	push	rbx		; save rbx
	push	rcx		; save rcx
	push	rdi		; save rdi	
	
	mov	rax, 1h		; write
	mov	rdi, 1h		; stdout

	syscall

	pop	rdi		; restore rdi
	pop	rcx		; restore rcx
	pop	rbx		; restore rbx
; }

handle:
; HANDLE {
	mov	al, [rdi]			; placeholder to handle	
	lea	rsi, [rsp + 8 + rbx * 8]	; argument
	
	push	rbx		; save rbx
	push	rcx		; save rcx
	push	rdi		; save rdi

	call	phandle

	pop	rdi		; restore rdi
	pop	rcx		; restore rdi
	pop	rbx		; restore rbx
; }

	inc	rbx		; args++
	
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
teststr:	db	"testing a%s%ca cool percent%x", 0h
inner:		db	"inner str", 0h
