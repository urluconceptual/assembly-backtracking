.data
	str: .space 2000
	x: .space 2000
	n: .long 0
	m: .long 0
	nr: .long 0
	i: .long 0
	trei: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	inapoi: .long 0
	in: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	chdelim: .asciz " "
	formatscanf: .asciz "%[^\n]s"
	formatprintf: .asciz "%d "
	final: .asciz "\n"
	k: .long 0
	ind: .long 0
	nul: .asciz "-1\n"
	ls: .long 0
	li: .long 0
	e: .long 1

.text
ok:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	xorl %eax, %eax
	movl (%esi, %ebx, 4), %ebx
	cmp $3, (%edi, %ebx, 4)
	je ok_exit

	movl $1, %eax
ok_exit:
	popl %ebp
	ret

solutie:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	xorl %eax, %eax
	incl %ebx
	cmp nr, %ebx
	je solutie_exit

	movl $1, %eax
solutie_exit:
	popl %ebp
	ret

distanta:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	subl m, %ebx

	movl $1, %eax

	movl %ebx, li
	addl m, %ebx
	addl m, %ebx
	addl $1, %ebx
	movl %ebx, ls
	movl li, %ebx

	cmp $0, %ebx
	jl for3

	movl ls, %ebx
	cmp nr, %ebx
	jg for2

	movl li, %ebx
for1:
	cmp ls, %ebx
	je distanta_exit

	cmp k, %ebx
	je for1cont

	movl (%esi, %ebx, 4), %edx
	pushl %ebx
	movl k, %ebx
	movl (%esi, %ebx, 4), %eax
	popl %ebx
	cmp %edx, %eax
	je return0
for1cont:
	incl %ebx
	jmp for1
for2:
	movl li, %ebx
loopfor2:
	cmp nr, %ebx
	je distanta_exit

	cmp k, %ebx
	je for2cont

	movl (%esi, %ebx, 4), %edx
	pushl %ebx
	movl k, %ebx
	movl (%esi, %ebx, 4), %eax
	popl %ebx
	cmp %edx, %eax
	je return0
for2cont:
	incl %ebx
	jmp loopfor2
for3:
	xorl %ebx, %ebx
loopfor3:
	cmp ls, %ebx
	je distanta_exit

	cmp k, %ebx
	je for3cont

	movl (%esi, %ebx, 4), %edx
	pushl %ebx
	movl k, %ebx
	movl (%esi, %ebx, 4), %eax
	popl %ebx
	cmp %edx, %eax
	je return0
for3cont:
	incl %ebx
	jmp loopfor3
return0:
	xorl %eax, %eax
distanta_exit:
	popl %ebp
	ret
	
backtr:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %edx
	movl %edx, k
	movl 12(%ebp), %ecx
	movl %ecx, ind
	movl (%esi, %edx, 4), %eax
	cmp $0, %eax
	jg nenule
gol:
	cmp n, %ecx
	jg nenule
for:
	movl %ecx, (%esi, %edx, 4)
	pushl k
	call ok
	popl k

	cmp $0, %eax
	je maxim
dist:
	pushl %edx
	pushl k
	call distanta
	popl k
	popl %edx

	cmp $0, %eax
	je maxim

	movl $0, inapoi
	addl $1, (%edi, %ecx, 4)
verificare:
	pushl k
	call solutie
	popl k

	cmp $0, %eax
	je backtr_exit
callbacktr:
	addl $1, %edx
	pushl $1
	pushl %edx
	call backtr
	popl %ebx
	popl %ebx
	jmp backtr_exit
maxim:
	cmp n, %ecx
	jl contfor
estemaxim:
	movl $0, (%esi, %edx, 4)
	movl $1, inapoi
	cmp $0, k
	jl imposibil
pasinapoi:
	decl %edx
	movl (%esi, %edx, 4), %ebx
	movl %ebx, ind
	addl $1, ind

	movl $in, %edi
	cmp $0, (%edi, %edx, 4)
	jne pasinapoi
	
	cmp n, %ebx
	je resetare

	movl $trei, %edi
	decl (%edi, %ebx, 4)
	movl $0, (%esi, %edx, 4)
	jmp callbacktr1
resetare:
	movl $trei, %edi
	decl (%edi, %ebx, 4)
	movl $0, (%esi, %edx, 4)
	jmp pasinapoi
contfor:
	movl $trei, %edi
	incl %ecx
	jmp for
nenule:
	cmp $0, inapoi
	je verificare

	jmp pasinapoi
imposibil:
	movl $0, e
	jmp backtr_exit
callbacktr1:
	pushl ind
	pushl %edx
	call backtr
	popl %ebx
	popl %ebx 
backtr_exit:
	popl %ebp
	ret

.global main
main:
	movl $x, %esi
	movl $in, %edi

	pushl $str
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $chdelim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx
	movl %eax, n

	pushl $chdelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx
	movl %eax, m

	xorl %edx, %edx
	movl $3, %eax
	movl n, %ebx
	mull %ebx
	movl %eax, nr

	xorl %ebx, %ebx
strtoint:
	cmp nr, %ebx
	je cateori

	pushl %ebx

	pushl $chdelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx

	popl %ebx
adaugvector:
	movl %eax, (%esi, %ebx, 4)

	cmp $0, %eax
	jne inin
	
	incl %ebx
	jmp strtoint
inin:
	movl $1, (%edi, %ebx, 4)
	
	incl %ebx
	jmp strtoint
cateori:
	movl $trei, %edi
	xorl %ecx, %ecx
forcateori:
	pushl %ecx

	cmp nr, %ecx
	je prelucrare

	movl (%esi, %ecx, 4), %eax
	addl $1, (%edi, %eax, 4)

	incl %ecx
	jmp forcateori
prelucrare:
	pushl $1
	pushl $0
	call backtr
	popl %ebx
	popl %ebx
	
	cmp $0, e
	je nuexista
afis:
	xorl %ecx, %ecx
forafis:
	pushl %ecx

	cmp nr, %ecx
	je exit
	
	pushl (%esi, %ecx, 4)
	pushl $formatprintf
	call printf
	popl %ebx
	popl %ebx
		
	pushl $0
	call fflush
	popl %ebx
	
	popl %ecx

	incl %ecx
	jmp forafis
nuexista:
	movl $4, %eax
	movl $1, %ebx
	movl $nul, %ecx
	movl $3, %edx
	int $0x80
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
exit:
	movl $4, %eax
	movl $1, %ebx
	movl $final, %ecx
	movl $2, %edx
	int $0x80
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
