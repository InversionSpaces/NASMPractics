	global	_start

	extern	strlen

	section   .text
_start:
	mov	rdi, teststr
	call	strlen

	mov	rdi, teststr

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
	push	rdi		; save rdi
	push	rcx		; save rcx

	mov	rax, 1h		; write
	mov	rdi, 1h		; stdout

	syscall

	pop	rcx		; restore rcx
	pop	rdi		; restore rdi
; }

handle:
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
	mov	rax, 60                 ; system call for exit
	xor	rdi, rdi                ; exit code 0
	
	syscall				; invoke operating system to exit

	section   .data
teststr:  db	"testing a%s%aa cool%a percent%t", 0h
