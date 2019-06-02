
@
@ Data section
@
.data

.set BUFFERSIZE,100
buffer:
    .space BUFFERSIZE,0
@
@ Messages
@
usagemsg:
    .asciz "Usage: guess [number]\n"
splash:
    .asciz "We are guessing the number %d\n"

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
    stmfd sp!,{r4,lr}  @ Save lr on the stack
    cmp r0,#2
    blt usage
    add r1,#4
    ldr r0,[r1]
    bl atoi
    mov r4, r0
    mov r1, r0
    ldr r0,=splash
    bl printf
loop:
    @ fgets(buffer, sizeof(buffer), stdin)
    ldr r0,=buffer      @ Argument 1: buffer address
    ldr r1,=BUFFERSIZE  @ Argument 2: size of the buffer
    ldr r2,=stdin       @ Address of stdin variable in memory
    ldr r2,[r2]         @ Argument 3: value of stdin
    bl fgets

    ldr r0,=buffer
    bl atoi

    cmp r0,r4
    blt toolow
    bgt toohigh

    mov r0,#0

main_return:
    ldmfd sp!,{r4,lr}  @ Restore lr from the stack
    bx lr

usage:
    ldr r0,=usagemsg
    bl printf
    mov r0,#1
    b main_return


toolow:
  b loop

toohigh:
  b loop
