.text
.global get_bit

@
@ r0 - Array of integers
@ r1 - Size of the array
@ r2 - Desired bit
@
get_bit:
    stmfd sp!,{r4-r8,lr}
        
    lsr r3, r2, #5 @ int
    cmp r3,r1
    movge r0,#0
    bge get_bit_return
    mov r4, r3
    lsl r4, r4, #5 
    sub r4, r2, r4 @ bit
    rsb r4, r4, #31
    lsl r3, r3, #2 
    add r0, r0, r3
    ldr r5, [r0]
    mov r6, #1
    lsl r6, r6, r4
    and r7, r6, r5
    lsr r7, r7, r4
    mov r0,r7
                                                                        
                                                                        
get_bit_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr           @ return

    
    

