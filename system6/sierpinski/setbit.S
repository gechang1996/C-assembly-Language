.text
.global set_bit

@
@ r0 - Array of integers
@ r1 - Size of the array
@ r2 - Desired bit
@ r3 - Non-zero to set
@
set_bit:
    stmfd sp!,{r4-r8,lr}
    mov r4, r2
    lsr r4, r4, #5 @use r4 for quotient
    cmp r4, r1
    bge set_bit_return
    lsl r5, r4, #5
    sub r5, r2, r5 @use r5 for remainder
    rsb r5, r5, #31
    lsl r4, r4, #2
    add r0, r4, r0 @r4 is now a address
    ldr r6,[r0] @use r6 for element
    cmp r3, #0
    beq set_bit_zero


    mov r7, #1
    lsl r7,r7,r5
    orr r6,r6,r7
    str r6,[r0]
set_bit_return: 
    ldmfd sp!,{r4-r8,lr}
    bx lr           @ return


set_bit_zero:
    mov r7, #1
    lsl r7,r7,r5
    bic r6,r6,r7
    str r6,[r0]
    b set_bit_return

    
    
