.global _start

.text

_start:
		movq $96, %rbx			# n = 5
		movq $85, %rcx			# k = 13
		movq $0, %r12			# sum = 0
		call fib
		movq (%rsp), %r14
		movq %rax, %rdx 		#final output in %rdx
		jmp exit

fib:
		movq $1, %r10			# f = 1
		movq $2, %r11			# s = 2
		cmp %r10, %rbx		# compute (n-f)
		jge while				# if greater than or equal to zero, jump to 'while' label
		jl fib_next

fib_next:
		movq %r12, %rax			# storing return value in rax
		ret

while:
		cmp %r10, %rbx
		jl fib_next
		movq %r10, %rdi
		call fact 				# call fact procedure
		addq %r12, %rax			# sum = sum + fact(f)
		movq $0, %rdx			# making remainder zero
		divq %rcx				# divides sum with k
		movq %rdx, %r12			# sum = sum % k (remainder)
		
		addq %r10, %r11			# s = s + f
		subq %r11, %r10 		# f = f - s
		neg %r10				# arithmetic negation of f
		jmp while



fact:
		pushq %rbx 				# save %r10
		movq %rdi, %rbx 		# move f as argument
		movq $1, %rax 			# return value = 1
		cmp $1, %rdi			# compute (f-1)
		jle return 				# if lessthan or equal to one, jump to 'return' label
		leaq -1(%rdi), %rdi 	# gives (n-1)
		call fact
		imulq %rbx, %rax 		# n * fact(n-1)
		movq $0, %rdx
		divq %rcx				
		movq %rdx, %rax			# sum = sum % k (remainder)



return:
		popq %rbx 				# pops %r10
		ret

exit:
		mov $60, %rax			# System call 60 is exit
		xor %rdi, %rdi			# returns 0
		syscall
