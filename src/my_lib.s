.data
	format:   	.asciz      "%ld\n"
	values:  	.quad 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text

# Variables
.global format
.global values

#Functions
.global lntwo
.global gcd
.global factorial
.global compare
.global equal
.global not_equal

lntwo:
	xor 	%rsi,	%rsi
	movq	$1,		%rsi 	
	movq	$0,		%r8		
lntwo_check:
	movq	$0,		%rdx	
	movq	$1,		%rcx	
	call	compare			
	cmpq	$1, 	%rax	
	jz		lntwo_ret		
	imul	$2,		%rsi
	add		$1,		%r8
	jmp		lntwo_check
lntwo_ret:
	movq	%r8, 	%rax	
	ret

gcd:
	xor			%rdx,	%rdx
	idivq 		%rbx
	movq		%rbx, 	%rax
	movq		%rdx, 	%rbx
	cmpq		$0, 	%rdx
	jne			gcd
	ret

factorial:
	cmpq 	$1, 	%rdi
	jle 	base_case
	pushq 	%rdi
	decq 	%rdi
	call 	factorial
	popq 	%rdi
	imul 	%rdi,	%rax
	ret
base_case:
	movq 	$1,		%rax
	ret

compare:
	movq	$0, 	%rax
	cmpq	$0, 	%rdx
	je 		less_than
	jg 		greater_than
	ret
less_than:
	sub 	%rsi,	%rdi
	cmpq	$0, 	%rdi
	jl 		is_true
	cmpq	$1, 	%rcx
	je		or_equal
	jmp		compare_ret
greater_than:
	sub 	%rsi,	%rdi
	cmpq	$0, 	%rdi
	jg 		is_true
	cmpq	$1, 	%rcx
	je		or_equal
	jmp		compare_ret
or_equal:
	cmpq	$0, 	%rdi
	je		is_true
	jmp		compare_ret
not_equal:
	movq	$0, 	%rax
	sub 	%rsi,	%rdi
	cmpq	$0, 	%rdi
	jne		is_true
	jmp		compare_ret
equal:
	movq	$0, 	%rax
	sub 	%rsi,	%rdi
	cmpq	$0, 	%rdi
	je		is_true
	jmp		compare_ret
is_true:
	movq 	$1,		%rax
	jmp		compare_ret
compare_ret:
	ret
