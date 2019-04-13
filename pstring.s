# 209089960 Chagit Stupel
#all the methods we can use on the pstring

    .section .rodata			
#string inputs for each function
str_invalid_input_mes:  .string "invalid input!\n"

    .text 		               #start of the code
.globl pstrlen 			
.type pstrlen, @function 		

#all the functions
pstrlen:
    movb     (%rdi),%al    #take the first byte and put it in the return val reg %rax
    ret

.globl replaceChar 			
.type replaceChar, @function     
replaceChar:
    pushq    %rbp          #setup
    movq     %rsp, %rbp
    push     %rdi
    
    movb     (%rdi), %r8b   #enter to the last byte of r8(=r8b) the pstring length
    incq     %rdi           #go to the start of the string(always point to one char from the string)
    jmp      .while_loop
    
.setup:
    incq     %rdi           #now rdi go to the next char in the string - start of the string
    decb     %r8b           #decrise the value in %r8b because we passed a char in the string
    
.while_loop:
    testb    %r8b,%r8b      #r8b & r8b will be zero only if r8b is 0
    je      .done           #if %r8b is zero go to done
    cmpb     (%rdi),%sil    #compare between the curent char in the pstring and the char we need to found
    jne     .setup          #if both of the strings are not equals return to the while
    movb    %dl,(%rdi)      #replace the old char with the new char
    jmp     .setup
    
.done:
    popq     %rdi 
    movq     %rdi,%rax      #set the new patring in rax - the value func return
    leave
    ret                     #the result in rax 
    
.globl ‫‪pstrijcpy‬‬ 			
.type ‫‪pstrijcpy‬‬, @function 
‫‪pstrijcpy‬‬:
    pushq    %rbp          #setup
    movq     %rsp, %rbp
    push     %rdi
    
    #check if the input is ok
    cmpb     $0,%dl
    js      .invalid_input1    #if i<0 print error message
    cmpq    %rdx, %rcx
    js      .invalid_input1    #if i>j print error message
    
    movb    (%rdi), %r9b       #saving the length of string1    
    cmpb    %r9b,%cl           #check if j is smaller than the length of the string1  
    jae     .invalid_input1 
    movb    (%rsi), %r9b       #saving the length of string2
    cmpb    %r9b,%cl           #check if j is smaller than the length of the string2
    jae     .invalid_input1 
    
    incq    %rdi               #now rdi go to the next char in the string - start of the string
    incq    %rsi               #now rsi go to the next char in the string - start of the string
  
    addq    %rdx,%rdi          #now rdi points to the 'i' value - when we need to start swap
    addq    %rdx,%rsi          #now rsi points to the 'i' value - when we need to start swap
    jmp     .while_loop2
    
.setup2:
    incq    %rdi               #rdi go to the next char in the string
    incq    %rsi               #rsi go to the next char in the string
    incq    %rdx               #increse the i value
    
.while_loop2:
    cmpb    %cl,%dl            #check if the i(rdx) > j(rcx)
    ja      .done2             #finished the loop
    movb    (%rsi),%r8b        #put the char we wanna replace into temp
    movb    %r8b,(%rdi)        #put the temp into the dst string
    jmp     .setup2
    
.invalid_input1 :
    movq    $str_invalid_input_mes, %rdi    #put the string
    movq    $0 ,%rax                        #put 0 in the return val function
    call    printf
    jmp     .done2
    
.done2:
    popq     %rdi 
    movq     %rdi,%rax      #set the new patring in rax - the value func return
    leave                   #the result in rax
    ret                  

.globl ‫‪swapCase‬‬ 			
.type ‫‪swapCase‬‬, @function     
‫‪swapCase‬‬:
    pushq    %rbp              #setup
    movq     %rsp, %rbp
    push     %rdi
    
    movzbq   (%rdi), %rcx     #enter to rcx the length of the string
    incq     %rdi             #go to the start of the string(always point to one char from the string)
    jmp     .while_loop3
    
.setup3:
    incq     %rdi             #now rdi go to the next char in the string
    decq     %rcx             #decrise the value in %r8b because we passed a char in the string
    
.while_loop3:
    cmpq     $0, %rcx        #stop the loop when we finish to go over the string
    je      .done3           #if %r8b is zero go to done
    movzbq  (%rdi), %r8      #save the letter
    movzbq  (%rdi), %r9      #save the letter
    
    leaq     -97(%r8), %rsi     #we dwcrese 97 which is the ascii value of 'a'
    cmpq     $25, %rsi          #we want that the result will be between 97 - 122
    ja       .chackChangeToSmall
    leaq     -32(%r9), %r9      #change the ascii value to be a capitel letter in the string
    movb     %r9b, (%rdi)       #replace the letter
    jmp      .setup3
    
.chackChangeToSmall:
    leaq     -65(%r8), %rsi     #decrese 65 which is the ascii value of 'A'
    cmpq     $25, %rsi          #the result needs to be between 65 - 90
    ja       .setup3
    leaq     32(%r9), %r9       #change the ascii value to be a small letter in the string
    movb     %r9b, (%rdi)       #replace the char
    jmp     .setup3
    
.done3:
    popq     %rdi 
    movq     %rdi,%rax          #set the new patring in rax - the value func return
    leave
    ret                     #the result in rax 

.globl pstrijcmp 			
.type pstrijcmp, @function    
pstrijcmp:    
    pushq    %rbp              #setup
    movq     %rsp, %rbp
    
    #check if the input is ok
    cmpb     $0,%dl
    js      .invalid_input2      #if i<0 print error message
    cmpq    %rdx, %rcx
    js      .invalid_input2      #if i>j print error message
    
    movb    (%rdi), %r9b       #saving the length of string1    
    cmpb    %r9b,%cl           #check if j is smaller than the length of the string1  
    jae     .invalid_input2 
    movb    (%rsi), %r9b       #saving the length of string2
    cmpb    %r9b,%cl           #check if j is smaller than the length of the string2
    jae     .invalid_input2 
    
    incq    %rdx               #starting the i index one more because of the length
    incq    %rcx               #starting the j index one more because of the length
  
    addq    %rdx,%rdi          #now rdi points to the 'i' value - for starting to compare
    addq    %rdx,%rsi          #now rsi points to the 'i' value - for starting to compare
    
    movq    $0 ,%rax           #initalizing return value to be zero
    jmp     .while_loop4
    
.setup4:
    incq    %rdi               #rdi go to the next char in the string
    incq    %rsi               #rsi go to the next char in the string
    incq    %rdx               #increse the i value
    
.while_loop4:
    cmpb    %cl,%dl            #check if the i(rdx) > j(rcx)
    ja      .done4             #finished the loop
    movb    (%rdi),%r8b        #the char value of first pstring in r8b
    movb    (%rsi),%r9b        #the char value of second pstring in r9b
    cmpb    %r8b,%r9b          #comparing between the 2 chars : src[i]:dst[i]
    jg      .set_minus
    jl      .set_plus
    jmp     .setup4             #if it is equal go to the next char to setup
    
.set_minus:
    movq    $-1,%rax            #setting return val to -1
    jmp     .done4
    
.set_plus:
    movq     $1 ,%rax           #setting return val to 1
    jmp     .done4
    
.invalid_input2 :
    movq     $str_invalid_input_mes, %rdi #put the string
    movq     $0 ,%rax           #put 0 in the return val function
    call     printf
    movq     $-2 ,%rax          #put -2 in the return val function - means error
    jmp     .done4
    
.done4:
    leave                   #the result in rax
    ret           
    