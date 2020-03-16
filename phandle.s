	global	phandle

section	.text

phandle:
	mov	rax, [rdi]
	
	cmp	rax, 's'
	je	string

	cmp	rax, 'x'
	je	hexnum

	cmp	rax, 'o'
	je	octnum

	cmp	rax, 'b'
	je	binnum

	cmp	rax, 'c'
	je	char

	jmp	return
	
string:
	

return:
	ret
