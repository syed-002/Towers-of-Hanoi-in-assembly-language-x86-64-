.global _start

.text

_start:
		movq $47, %rbx			# A = 30
		movq $27, %rcx			# B = 8
		movq $1, %r8			# i = 1
		movq $0, %r12			# sum = 0

loop1:
		#inc %r8
		movq %rbx, %rax			# $rax = A
		movq $0, %rdx			# making remainder zero
		divq %r8				# co mputes A/i
		cmp $0, %rdx			# checks if remiander is zero
		je check 				# if zero, jump to label check
		jne loop1				# jump to loop1 again

check:
		cmp %rax, %r8			# computes i-(A/i)
		jge max					# if positive, jump to label max
		jl min					# if negative, jump to label min

min:
		movq %rax, %r9			# $r9 = x (x = x/i)
		movq %r9, %rax			# $rax = x
		movq %rcx, %r10			# temp = B
		jmp gcd 				# jump to gcd unconditionally

max:
		movq %r8, %r9			# $r9 = x (x = i)
		movq %r9, %rax			# $rax = x
		movq %rcx, %r10			# temp = B
		jmp gcd 				# jump to gcd unconditionally

gcd:
		movq $0, %rdx			# making remainder %rdx = 0
		divq %r10				# compute x/temp
		movq %r11, %rdx			# y = x%temp
		movq %r11, %r10 		# temp = y 
		cmp $0, %r10			# checking if temp is zero or not
		je gcd_check			# jump to gcd_check if is zero
		movq %r10, %rax			# x = temp
		jmp gcd 				# jump to gcd unconditionally
		
gcd_check:
		cmp $1, %rax			# checks if gcd is 1
		je finale 				# jump to finale 
		jne loop1				# jump to  loop1

finale:
		mov %r12, %rdx			# final answer in rdx
		cmp $0, %r9				# check if x is zero
		je exit 				# if zero, jump to exit
		movq %r9, %rax			# $rax = x
		movq $0, %rdx			# making reaminder %rdx = 0
		movq $10, %r10			# $r10 =10
		divq %r10				# computing x/10
		movq %rax, %r9			# x = x/10
		addq %rdx, %r12			# sum = sum + remainder
		jmp finale 				# jump to finale unconditionally
		
exit:
		mov $60, %rax			# System call 60 is exit
		xor %rdi, %rdi			# returns 0
		syscall					# Invokes Operating system to exit
