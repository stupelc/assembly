# 209089960 Chagit Stupel
#the main method - scan the input from the user : the func choise and the 2 strings

    .section .rodata			
str_format:              .string "%s" #string formats for scanf, printf
int_format:	        .string "%d"  #int formats for scanf, printf

    .text 		               #start of the code
.globl main 			
.type main, @function 		

main:
    movq         %rsp, %rbp              #for correct debugging
    pushq	%rbp                    #save the old frame pointer 
    movq    	%rsp, %rbp              #create the new frame pointer
    leaq 	-4(%rsp), %rsp          #allocate memory for the length of first string
    movq 	$int_format, %rdi       #set first argument to scanf(%d)
    movq	        %rsp, %rsi 	       #set second argument to scanf(pointer to end of stack)
    movq 	$0, %rax
    call 	scanf 	               #get size from user

    xorq    	%r8, %r8 		#assign zero to %r8
    movb 	(%rsp), %r8b 		#get the input value as byte from the last bytes of the number
    leaq 	2(%rsp), %rsp 		#free 2 bytes and save one for the '\0' and one in the begining for the size
    subq 	%r8, %rsp 		#allocate the size of the string in the stack
    movb 	%r8b, (%rsp) 		#push the size to the begining of the pstring(currently end of stack)
    movq 	$str_format, %rdi 	#set first argument to scanf(%s)
    leaq 	1(%rsp), %rsi 		#set second argument to scanf(pointer to end of stack)
    movq 	$0, %rax
    call 	scanf 			#get string from user
    movq 	%rsp, %rbx 		#set %rbx to be pointer to the start of the first pstring

    leaq 	-4(%rsp), %rsp 		#allocate memory for the length of second pstring
    movq 	$int_format, %rdi 	#set first argument to scanf(%d)
    movq    	%rsp, %rsi 		#set second argument to scanf(pointer to end of stack)
    movq 	$0, %rax
    call 	scanf 			#get size from user

    xorq 	%r9, %r9 		#assign zero to %r8
    movb 	(%rsp), %r9b 		#get the input value as byte from the last bytes of the number
    leaq 	2(%rsp), %rsp 		#free 2 bytes and save one for the '\0' and one in the begining for the size
    subq 	%r9, %rsp 		#allocate the size of the string in the stack
    movb 	%r9b, (%rsp) 		#push the size to the begining of the pstring(currently end of stack)
    movq 	$str_format, %rdi 	#set first argument to scanf(%s)
    leaq 	1(%rsp), %rsi 		#set second argument to scanf(pointer to end of stack)
    movq 	$0, %rax
    call 	scanf 			#get string from user
    movq 	%rsp, %r14 		#set %r10 to be pointer to the start of the second pstring
    
    leaq 	-4(%rsp), %rsp 		#allocate memory for the choice of the user
    movq 	$int_format, %rdi 	#set first argument to scanf(%d)
    movq    	%rsp, %rsi 		#set second argument to scanf(pointer to end of stack)
    movq 	$0, %rax
    call 	scanf 			#get choice from user

    movl 	(%rsp), %edi 	        #set the first argument to run_func(user choice - int)
    movq 	%rbx, %rsi 		#set the second argument to run_func(pointer to first pstring)
    movq 	%r14, %rdx 		#set the third argument to run_func(pointer to second pstring)
    call 	run_func 		#call the function that manages user's choice

    movq 	$0, %rax			#set return value to 0
    movq 	%rbp, %rsp 		#restore the old stack pointer
    popq    	%rbp 			#restore old frame pointer (the caller function frame)
    ret          
    