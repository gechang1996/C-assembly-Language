@Data section
@
.data
start: .asciz"\nAll Munchausen numbers from 1 and 1000000:\n\n"
message: .asciz"Munchausen number: %d\n"


@
@Text section
@

.text

.global main
.global tetration
@
@ main(argc, argv)
@ r0: The number of arguments
@ r1: Pointer to an array of string pointers
@ 
main:
  stmfd sp!,{lr}
  .equ number,0
  .equ temp,4
  .equ digit,8
  .equ sum,12
  .equ quotient,16
  .equ remainder,20
  .equ size,24

  sub sp,sp,#size @Allocate space

  ldr r0,=start @print the start message
  bl printf
  
  mov r0,#1 @initialize the number as 1
  str r0,[sp,#number]

main_loop1:

  ldr r0,[sp,#number]
  
  ldr r1,=#1000000
  cmp r0,r1 @compare number with #1000000
  bgt main_end @if equal, end the out loop
  ldr r0,[sp,#number]
  str r0,[sp,#temp] @temp = number
  mov r1,#0
  str r1,[sp,#sum]  @initialize sum to 0

main_loop2:
  ldr r0,[sp,#temp]
  movs r0,r0  @when temp==0, end the inner loop
  beq main_loop3

  add r0,sp,#quotient
  ldr r1,[sp,#temp]
  mov r2,#10 
  bl div  @use div function to get the quotient

  ldr r0,[sp,#quotient]
  ldr r1,[sp,#temp]
  str r0,[sp,#temp]
  mov r2,#10
  mul r0,r0,r2
  sub r2,r1,r0@get the remainder
  
  mov r0,r2
  bl tetration@use function tetration to get the product
  
  ldr r1,[sp,#sum]
  add r1, r1,r0
  str r1,[sp,#sum] @add the product to sum  

  
  b main_loop2

main_loop3:

  ldr r0,[sp,#sum]
  ldr r1,[sp,#number]

  cmp r0,r1 @compare sum and number
  beq print_section@if equal, print the value
 
  ldr r0,[sp,#number] @number+=1
  add r0,r0,#1
  str r0,[sp,#number]
  b main_loop1
print_section:

  ldr r0,=message @print the number
  ldr r1,[sp,#number]
  bl printf
  
   
  ldr r0,[sp,#number] @number+=1
  add r0,r0,#1
  str r0,[sp,#number]

  b main_loop1




main_end:
  mov r0,#0
  add sp, sp,#size   @ Free space
  ldmfd sp!,{lr}
  
  bx lr  

