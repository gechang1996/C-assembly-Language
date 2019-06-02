@system5,by Chang Ge
@data part
@we initialize two element(n-1) and (n-2)
@Then we initialize a count for deciding updating which element
@set three text 
@set a const size
@set a 100 size buffer filled with 0
.data
first: .word 0
second: .word 1
count: .word 0

.set BUFFERSIZE,100
buffer:
  .space BUFFERSIZE,0
start:
  .asciz "Enter first number : "
warning:
  .asciz "Silly Rabbit, there is no %dth Fibonacci number\n"
result:
  .asciz "The %dth Fibonacci number is %d\n"


.text
.global main

main:
  stmfd sp!,{r4-r8,lr}
  ldr r0,=start
  bl printf
  ldr r0,=buffer      @buffer address
  ldr r1,=BUFFERSIZE  @size of the buffer
  ldr r2,=stdin       @address of stdin variable in memory
  ldr r2,[r2]         @value of stdin
  bl fgets

  @convert of an integer

  ldr r0,=buffer
  bl atoi
 
  
  mov r3,r0           @if input is 0, return The 0th Fibonacci number is 0.
  mov r4,r0           @if input is 1, return the 1th Fibonacci number is 1.
  movs r3,r3
  bmi main_fail
  movs r3, r3 
  beq special_case

  cmp r3,#1
  beq main_success

@This loop is used for updating the (n-2)th and (n-1)th Fibonacci numbers.
@This loop will end when the input number is reduced to 1.
loop:
  cmp r4,#1           
  bgt loop2         
  beq main_success
    
    


loop2:
@count is used for deciding which element(first or second)should be updated.
@if the count is 1, update second
@if the count is 0, update first
@each time we run this loop, count +=1, and if count ==2, make it 0
@The new element is the sum of the previous two
  ldr r5,=first
  ldr r5,[r5]
  ldr r6,=second
  ldr r6,[r6]
  add r8,r5,r6
  ldr r5,=count
  ldr r6,[r5]
  cmp r6,#0
  ldreq r7,=first
  streq r8,[r7]
  cmp r6,#1
  ldreq r7,=second
  streq r8,[r7]
  adds r6,r6,#1
  cmp r6,#2
  moveq r6,#0
  str r6,[r5]
  sub r4, r4, #1
  b loop

@This is used for print the warning text(when input <0) and return 1  
main_fail:
  ldr r0,=warning
  mov r1,r3
  bl printf
  mov r0,#1
 
  ldmfd sp!,{r4-r8,lr}
  bx lr

  
@This is used for print the correct result text(when input>=0) and return 0
@and use count to decide which element(first or second) should be print out.
@If count ==0,print second
@If count ==1,print first
main_success:
  ldr r4,=count
  ldr r4,[r4]
  cmp r4,#0
  ldreq r2,=second
  cmp r4,#1
  ldreq r2,=first
  ldr r2,[r2]
  

  ldr r0,=result
  mov r1,r3
  mov r2,r2
  bl printf
   
  mov r0,#0
  ldmfd sp!,{r4-r8,lr}
  bx lr
@This is a special case, When input is 0, we print the correct result
@Return 0
special_case:
  ldr r0,=result
  mov r1, #0
  mov r2, #0
  bl printf
  mov r0, #0
  ldmfd sp!,{r4-r8,lr}
  bx lr
