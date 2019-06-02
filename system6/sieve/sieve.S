@
@ Data section
@
.data
usage:  .asciz "Usage: sieve <size>\n"
minsize: .asciz "Sieve size must be at least 2\n"

primes: .asciz "Primes:"

return: .asciz "\n"

number: .asciz " %d"
@
@ Text section
@

.text
.global main

@
@ main(argc, argv)
@ r0: The number of arguments
@ r1: Pointer to an array of string pointers
@

main:
    stmfd sp!,{r4-r8,lr}
        
    cmp r0,#2       @ Compare argc to 2
    bge args_ok     @ Branch if argc >= 2
                
    ldr r0,=usage   @ Get address of message
    bl printf       @ printf
                        
    mov r0,#1       @ Return value: 1
    b main_return   @ return
args_ok:
    ldr r0,[r1,#4]  @ Get argv[1]
    bl atoi         @ Convert to integer
          
    cmp r0,#2
    bge size_ok

    ldr r0,=minsize @ "Sieve size must be at least 2\n"
    bl printf       @ printf
                          
    mov r0,#1       @ Return value: 1
    b main_return   @ return

size_ok:
    size .req r4    @ Use r4 for size
    mov size, r0      @ size
        
    add r0, size, #1    @ r0 <- size+1
    mov r1, #4      @ Size of an integer
    bl calloc       @ calloc
                    
    sieve .req r5
    mov r5, r0      @ Save the result
                            
    mov r0, sieve 
    mov r1, size    
    bl initialize   @ initialize(sieve, size)
    bl sieve_it     @ sieve_it(sieve, size)
    bl display      @ display(sieve, size) 
    mov r0, sieve
    bl free         @ free

    mov r0,#0

main_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr
            
    .unreq sieve
    .unreq size


@
@ display(int *sieve, int size)
@
display:
    stmfd sp!,{r4-r8,lr}
    size .req r4    @ Use r4 for size
    sieve .req r5   @ Use r5 for sieve

    mov sieve, r0
    mov size, r1

    ldr r0,=primes
    bl printf


    i .req r6
    mov i,#2

display_loop:
    cmp i,size
    bgt display_loop_end
    
    lsl r7,i, #2
    ldr r0, [sieve, r7] @ sieve[i]
    cmp r0,#0           @ == 0?
    beq display_skip    @ Yes, skip    
    ldr r0,=number
    mov r1,i
    bl printf
display_skip:                        
    add i,#1
    b display_loop

display_loop_end:
    ldr r0,=return
    bl printf

display_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr
            
    .unreq sieve
    .unreq size
    .unreq i



initialize:
    stmfd sp!,{r4-r8,lr}
    i .req r4 @use r4 for i
    size .req r5 @use r5 for size
    sieve .req r6 @use r6 for sieve
    mov size,r1
    mov sieve,r0
    mov i, #2
initialize_loop:
    
    cmp i, size
    bgt initialize_return
    
    lsl r7, i, #2
    mov r8,#1
  
    str r8, [r0, r7]

    add i, #1
    b initialize_loop

initialize_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr
    .unreq sieve
    .unreq size
    .unreq i


sieve_it:
    stmfd sp!,{r4-r8,lr}
    j .req r3 @use r3 for j
    i .req r4 @use r4 for i
    size .req r5 @use r5 for size
    sieve .req r6 @use r6 for sieve
    mov size, r1
    mov sieve, r0
    mov i, #2
    lsr r7,size,#1
  
sieve_it_loop:

    cmp i,r7
    bgt sieve_it_return


    lsl j, i, #1
    
sieve_it_loop2:
    cmp j, size
    bgt sieve_it_loop3
    mov r2,#0
    lsl r8, j, #2
    str r2,[r0,r8]
    add j,i
    b sieve_it_loop2
    
sieve_it_loop3:
    add i,#1
    b sieve_it_loop




sieve_it_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr
    .unreq sieve
    .unreq size
    .unreq i
    .unreq j











