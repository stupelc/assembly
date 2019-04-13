# 209089960 Chagit Stupel
#the implementation of run_func which should manage user's choice with swich case

    .section .rodata			
str_format:              .string "%s" #string formats for scanf, printf
int_format:	        .string "%d"  #int formats for scanf, printf
char_format:	        .string " %c" #int formats for scanf, printf
#string inputs for each function
str_result_func50:      .string "first pstring length: %d, second pstring length: %d\n" 
str_result_func51:      .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
str_result_func52:      .string "length: %d, string: %s\n"
str_result_func53:      .string "length: %d, string: %s\n"
str_result_func54:      .string "compare result: %d\n"
str_invalid_input_mes:  .string "invalid input!\n"
str_opetion_input_mes:  .string "invalid option!\n"

.option:                                #switch table
    .quad .option50                     #case50
    .quad .option51                     #case51
    .quad .option52                     #case52
    .quad .option53                     #case53
    .quad .option54                     #case54 

    .text 		               #start of the code
.globl run_func 			
.type run_func, @function 		
    
  run_func:
    pushq    %rbp                            #setup the pointer rbp
    movq     %rsp, %rbp                       #setup the pointer to the end of the stuck

    #save the value of rdi - option, rsi - first argument, rdx - second argument
    movq     %rsi,%r14                        #save the first string in %r14
    movq     %rdx,%r15                        #save the second pstring in %r15 

    #check if the input is ok
    cmpq     $55,%rdi                         #check if the input > 55
    ja       .errorInput                      #error input message
    cmp      $49,%rdi                         #check if the input <= 49 
    jle      .errorInput                      #error input message
    subq     $50,%rdi                         #less 50 from the value that we have and put it in the register
    
    jmp     *.option(,%rdi,8)                 #go to the switch - case tabel
     
    
.option50:                              #function50  
    #the first string
    movq     %r14,%rdi                      #set the first pstring to be the first argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     pstrlen                        #call the pstrlen function
    movq     %rax,%r13                      #save the resulf of len1
    #the second string
    movq     %r15,%rdi                      #set the second string to the first argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     pstrlen                        #call the pstrlen function
    movq     %rax,%r9                       #save the result of len2
    #print the results
    movq     $str_result_func50,%rdi        #put the line
    movq     %r13, %rsi                     #mvoe the first len into the reg %rsi
    movq     %r9, %rdx                      #move the second len into the reg %rdx
    movq     $0,%rax                        #put null in the return value - rax
    call     printf                         #print the result we wants
    jmp     .end   

.option51:                              #function51
    #scan the first char
    movq     $char_format,%rdi              #first parameter that we will send to the scan function
    dec      %rsp                           #leaq place for the char
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r13                   #saving the first int in %r13 register
    
    #scan the second char
    movq     $char_format,%rdi              #first parameter that we will send to the scan function
    dec      %rsp                           #leaq place for the char
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r9                    #saving the second int in %r9 register
    
    #the first string
    movq     %r14,%rdi                      #set the first pstring to be the first argument of the function
    movq     %r13,%rsi                      #set the first char to be the second argument of the function
    movq     %r9,%rdx                       #set thet second char to be the third argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     replaceChar                    #call the replaceChar function
    movq     %rax,%r11                      #save the string1 after the change
    
    #the second strings
    movq     %r15,%rdi                      #set the second string to the first argument of the function
    movq     %r13,%rsi                      #set the first char to be the second argument of the function
    movq     %r9,%rdx                       #set thet second char to be the third argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     replaceChar                    #call the replaceChar function
    movq     %rax,%r12                      #save the string2 after the change
    
    #print the results
    movq     $str_result_func51,%rdi        #put the line
    movq     %r13, %rsi                     #move the first char that we look for into the reg %rsi
    movq     %r9, %rdx                      #move the old char that we look for into the reg %rdx
    incq     %r11                           #increse the pointer in %r11 so we will have only the string
    movq     %r11,%rcx                      #move the new string1 after changing 
    incq     %r12                           #increse the pointer in %r12 so we will have only the string
    movq     %r12,%r8                       #move the new string2 after changing
    movq     $0,%rax                        #put 0 in the return func value
    call     printf                         #print the result we wants
    jmp     .end   
    
.option52: #function52
   
    movb     (%r15),%r12b                   #save the length of the second string 
    #scan i
    movq     $int_format,%rdi               #first parameter that we will send to the scan function
    subq     $4,%rsp                        #leaq place for scanning int value
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r13                   #saving the first int in %r13 register
    #scan j
    movq     $int_format,%rdi               #first parameter that we will send to the scan function
    subq     $4,%rsp                        #leaq place for scanning int value
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r9                    #saving the second int in %r9 register
    
    #the first string
    movq     %r14,%rdi                      #set the first pstring to be the first argument of the function
    movq     %r15,%rsi                      #set the second pstring to be the second argument of the function
    movq     %r13,%rdx                      #set i to be the third argument of the function
    movq     %r9,%rcx                       #set j to be the third argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     ‫‪pstrijcpy‬‬                      #call the ‪pstrijcpy‬ function
    movq     %rax,%r11                      #save the string1 after the change
    
    #print the first atring (the one that changes)
    movq     $str_result_func52,%rdi        #put the line in reg %rdi
    movzbq   (%r11), %rsi                   #move the first char that we look for into the reg %rsi
    incq     %r11                           #move the point 1 step so it will point to the start of the string 
    movq     %r11, %rdx                     #put the string after changing in %rdx
    movq     $0,%rax                        #put 0 in the return func value
    call     printf                         #print the result we wants
    
    #print the second string (the one that doesnt changes)
    movq     $str_result_func52,%rdi        #put the line in reg %rdi
    movzbq   %r12b, %rsi                    #move the first char that we look for into the reg %rsi
    incq     %r15                           #move the point 1 step so it will point to the start of the string 
    movq     %r15, %rdx                     #put the string after changing in %rdx
    movq     $0,%rax                        #put 0 in the return func value
    call     printf                         #print the result we wants
    jmp      .end 
    
.option53: #function53
    #the first string
    movq     %r14,%rdi                      #set the first pstring to be the first argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     ‫‪swapCase‬‬                       #call the pstrlen function
    movq     %rax,%r13                      #save the resulf of str1 after changing
    
    #print the first atring 
    movq     $str_result_func53,%rdi        #put the line in reg %rdi
    movzbq   (%r13), %rsi                   #move the first string len into %rsi
    incq     %r13                           #increment the string so it will point to the start of the string
    movq     %r13, %rdx                     #put the string after changing in %rdx
    movq     $0,%rax                        
    call     printf                         #print the result we wants
    
    #the second string
    movq     %r15,%rdi                      #set the second string to the first argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     ‫‪swapCase‬‬                       #call the pstrlen function
    movq     %rax,%r10                      #save the resulf of str2 after changing
    
    #print the second string 
    movq     $str_result_func53,%rdi        #put the line in reg %rdi
    movzbq   (%r10), %rsi                   #move the second string len into %rsi
    incq     %r10                           #increment the string so it will point to the start of the string
    movq     %r10, %rdx                     #put the string after changing in %rdx
    movq     $0,%rax                        #put 0 in the return func value
    call     printf                         #print the result we wants
                            
    jmp      .end 
    
.option54: #function54
    #scan i
    movq     $int_format,%rdi               #first parameter that we will send to the scan function
    subq     $4,%rsp                        #leaq place for scanning int value
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r13                   #saving the first int in %r13 register
    #scan j
    movq     $int_format,%rdi               #first parameter that we will send to the scan function
    subq     $4,%rsp                        #leaq place for scanning int value
    movq     %rsp,%rsi                      #second parameter that we will send to the scan function
    movq     $0,%rax                        #put 0 in the return func value
    call     scanf                          #call the scanf function
    movzbq   (%rsp), %r9                    #saving the second int in %r9 register
    
    #the first string
    movq     %r14,%rdi                      #set the first pstring to be the first argument of the function
    movq     %r15,%rsi                      #set the second pstring to be the second argument of the function
    movq     %r13,%rdx                      #set i to be the third argument of the function
    movq     %r9,%rcx                       #set j to be the third argument of the function
    movq     $0,%rax                        #put 0 in the return func value
    call     pstrijcmp                      #call the ‪pstrijcpy‬ function
    movq     %rax,%r11                      #save the result of the compare between the 2 strings
    
    #print the result from comparing the 2 string
    movq     $str_result_func54,%rdi        #put the line in reg %rdi
    movq     %r11, %rsi                     #put the result from the compring between the 2 strings
    movq     $0,%rax                        #put 0 in the return func value
    call     printf                         #print the result we wants
    
    jmp     .end 

.errorInput:
    #if there are error input
    movq    $str_opetion_input_mes,%rdi    #put the line in reg %rdi
    movq    $0,%rax                        #put 0 in the return func value
    call    printf                         #print the result we wants
    leave
    ret          
    
.end: 
    movq    $0,%rax
    leave
    ret
    