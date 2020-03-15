	global	strlen

	section	.text

;=================
; Inputs:	RDI - adress of null-terminated string
; Outputs:	RCX - length of string excluding null byte
; Destroys:	RAX, RDI, RCX
;=================
strlen:
	xor	rcx, rcx
	not	rcx			; rcx = INT_MAX

	xor	rax, rax		; rax = 0

	repne	scasb			; while (!*rdi) rcx--
	
	not	rcx
	dec	rcx
	
	ret

