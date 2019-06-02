.text
.global dumb_divide
.global divide
.global pos_divide
.global neg_divide
.global signed_divide



@
@ Divide two numbers by brute force
@ r0 - First unsigned value, the dividend
@ r1 - Second unsigned value, the divisor
@ Returns r0 / r1, the quotient
@
dumb_divide:
  mov r2, #0
while_begin:
  sub r0, r0, r1
  movs r0,r0
  bmi after_while
@Each time the program run the while loop, count= count+1
@The while loop will break when the dividend is less than 0
  add r2, r2, #1
  b while_begin

after_while:
  mov r0, r2
  bx lr
    







  bx lr

@
@ Divide two numbers efficiently
@ r0 - First unsigned value, the dividend
@ r1 - Second unsigned value, the divisor
@ Returns r0 / r1, the quotient
@

divide:
  mov r3 ,#0
@Start with a left shift of 15 bits
  lsl r1, r1, #15
  mov r2, #1
  lsl r2, #15

forloop:
  orrs r1, #0
@As long as any bits remain in our divisor, the loop keeps running
  beq loopend
@If the the dividend is at least
@as large as the divisor
  cmp r0, r1
  
@Subtract out the shifted divisor
@and set the bit 
  subeq r0, r0, r1
  orreq r3, r3, r2
  subpl r0, r0, r1
  orrpl r3, r3, r2
@ Shift right 1 bit
  lsr r1, r1, #1
  lsr r2, r2, #1

  b forloop


loopend:
  mov r0, r3
  bx lr

@This function is used for getting the positive division result
@Don't care the sign of input numbers
@The rest is the same as the function divide
pos_divide:
  

  mov r3 ,#0
  movs r0, r0
  submi r0, r3, r0
  movs r1, r1
  submi r1, r3, r1


  lsl r1, r1, #15
  mov r2, #1
  lsl r2, #15

forloop1:
  orrs r1, #0
  beq loopend1
  
  cmp r0, r1
  subeq r0, r0, r1
  orreq r3, r3, r2
  subpl r0, r0, r1
  orrpl r3, r3, r2
  lsr r1, r1, #1
  lsr r2, r2, #1

  b forloop1


loopend1:
  mov r0, r3
  bx lr

@This function is used for getting the negative division result
@Don't care the sign of the input numbers
@The rest is the same as the function division
neg_divide:
  

  mov r3 ,#0
  movs r0, r0
  submi r0, r3, r0
  movs r1, r1
  submi r1, r3, r1


  lsl r1, r1, #15
  mov r2, #1
  lsl r2, #15

forloop2:
  orrs r1, #0
  beq loopend2
  
  cmp r0, r1
  
  subeq r0, r0, r1
  orreq r3, r3, r2
  subpl r0, r0, r1
  orrpl r3, r3, r2
  lsr r1, r1, #1
  lsr r2, r2, #1

  b forloop2


loopend2:
  mov r0, r3
  rsb r0, r0, #0
  bx lr


@
@ Divide two signed numbers efficiently
@ r0 - First unsigned value, the dividend
@ r1 - Second unsigned value, the divisor
@ Returns r0 / r1, the quotient

@
signed_divide:

  mov r3, #0
  mov r2, #0
@add 1 to r2 when the divisor or dividend is a negative number
@make all the input number positive
  movs r0, r0
  submi r0, r3, r0
  addmi r2, r2, #1
  movs r1, r1
  submi r1, r3, r1
  addmi r2, r2, #1
@if r2 is 2, then the result is positive
  subs r3, r2, #2
  beq pos_divide
@if r2 is 1, then the result is negative
  subs r3, r2, #1
  beq neg_divide
@if r2 is 0, then the result is positive
  movs r2, r2
  beq pos_divide 


  

