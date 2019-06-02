.text
.balign 4
.global ship

.data
.balign 8
zero:   .double 0
four:   .double 4
two:    .double 2

ship:
  stmfd sp!,{lr}
  ldr r3,=zero
  vldr d2,[r3]  @This is X(initial 0)
  ldr r4,=zero
  vldr d3,[r4]  @This is Y(initial 0)
  mov r3,#0     @This is iteration(initial 0)
  ldr r4,=zero
  vldr d4,[r4]  @This is x^2+y^2
  vldr d6,[r4]  @This is zero

loop1:
  cmp r3,#255
  beq ship_end

loop2:
  ldr r4,=four
  vldr d5,[r4]  @ This is the float 4
  vcmp.f64 d4,d5
  vmrs APSR_nzcv, fpscr   @ move to CPSR
  bge ship_end
  
  vcmp.f64 d2,d6
  vmrs APSR_nzcv, fpscr   @ move to CPSR
  vsublt.f64 d2,d6,d2

  vcmp.f64 d3,d6
  vmrs APSR_nzcv, fpscr   @ move to CPSR
  vsublt.f64 d3,d6,d3

  vmul.f64 d7,d2,d2       @This is x1
  vmul.f64 d5,d3,d3
  vsub.f64 d7,d7,d5
  vadd.f64 d7,d7,d0
  
  vmul.f64 d6,d2,d3       @This is y1
  ldr r5,=two
  vldr d5,[r5]
  vmul.f64 d6,d6,d5
  vadd.f64 d6,d6,d1

  vmov d2,d7    @update x
  vmov d3,d6    @update y

  vmul.f64 d7,d2,d2
  vmul.f64 d6,d3,d3
  vadd.f64 d4,d7,d6 @This is x^2+y^2

  ldr r4,=zero
  vldr d6,[r4]

  add r3,r3,#1



  b loop1
  

ship_end:
  mov r0,r3 @return iteration
  ldmfd sp!,{lr}
  bx lr 

