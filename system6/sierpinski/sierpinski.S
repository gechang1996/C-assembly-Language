@system6 Chang Ge


.text
.global sierpinski
.global get_bit
.global set_bit
@
@ sierpinski iteration calculator
@ r0 - int *cells
@ r1 - int size
@
sierpinski:
    stmfd sp!,{r4-r12,lr}
    mov r6, #0  @this is a number for runing sierpinski_loop 32*width times
    lsl r12, r1,#5  @this is 32*width
    lsl r4, r1, #5  @this is 32*width
    sub r4, r4, #1  @this is the number of rightmost bit
    cells .req r8   @use r8 for cells
    mov cells, r0   
    size .req r5    @use r5 for size
    my_ary .req r7  @use r7 for a new array
    mov size,r1
    mov r0,size
    mov r1, #4
    bl calloc
    mov my_ary,r0
    mov r10,#0      @this is a number for running sierpinski_loop 32*width times
sierpinski_loop:
    cmp r6,r4       @when r6 == width*32 -1, end the loop
    bgt sierpinski_loop2 
    mov r11,#0      @this is the sum of this three-bit number
    mov r0, cells   @This is the equation for the sum
    mov r1, size
    sub r2, r6,#1
    bl get_bit
    cmp r2, #0      @check if the bit is -1, if it is, make r0 0
    movlt r0, #0
    lsl r0,r0,#2
    add r11, r11, r0
    mov r0, cells   @This is the equation for the sum

    mov r1, size
    mov r2, r6
    bl get_bit
    lsl r0,r0,#1    
    add r11, r11, r0
    mov r0, cells   @This is the equation for the sum
    mov r1, size
    add r2, r6, #1
    
    bl get_bit
    cmp r2, r12
    moveq r0, #0    @check if the bit is 32*width, if it is,make r0,0
    add r11, r11, r0
    cmp r11, #0     @this is used for geting the setto
    moveq r9, #0
    cmp r11, #1
    moveq r9, #1
    cmp r11, #2
    moveq r9, #0
    cmp r11, #3
    moveq r9, #1
    cmp r11, #4
    moveq r9, #1
    cmp r11, #5
    moveq r9, #0
    cmp r11, #6
    moveq r9, #1
    cmp r11, #7
    moveq r9, #0
    mov r0,my_ary
    mov r1,size
    mov r2, r6      
    mov r3, r9      @use r6 as the desire to set_bit
    bl set_bit      @use r9 as the setto to set_bit
    
    add r6,r6,#1
    b sierpinski_loop




sierpinski_loop2:   @this loop move the bit from my_ary to the original one
    cmp r10,r4      @run it width*32 times  
    bgt sierpinski_return
        
    mov r0, my_ary
    mov r1, size
    mov r2, r10
    bl get_bit
    mov r9, r0
    mov r0,cells
    mov r1, size
    mov r2, r10
    mov r3, r9
    bl set_bit


    add r10, r10,#1
    b sierpinski_loop2


sierpinski_return:
    mov r0, my_ary  @free my_ary
    bl free
    ldmfd sp!,{r4-r12,lr}

    bx lr           @return
    .unreq size
    .unreq cells
    .unreq my_ary
