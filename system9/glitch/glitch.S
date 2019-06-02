.data
  .equ    cell_actual, 0
  .equ    cell_size, 8
  .equ    game_rows, 0  @which is height
  .equ    game_cols, 4  @which is width
  .equ    game_array,8
  .equ    game_size, 12


.text
.global glitch
.global set_pixel
.global get_pixel
.global create_image
@
@ void *glitch(void *src)
@
glitch:
  push {r4-r10,lr}
  
  ldr r9,[r0,#game_cols]  @r9 is the width
  ldr r8,[r0,#game_rows]  @r8 is the height
  
  mov r10,r0  @r10 is the image

  mov r0,r9   @use width and height to create a new empty image
  mov r1,r8
  bl create_image
  
  mov r5,r0 @r5 is the new image
  mov r6,#0 @r6 and r7 are counter
  mov r7,#0

loop1:
  mov r7,#0
  cmp r6,r8 @compare r6 with the rows
  beq glitch_done @if equal, end the program
  and r1,r6,#15 @change the ramdom number every 16 rows
  cmp r1,#0
  beq gli_loop
  bgt loop2

  add r6,r6,#1 
  
  b loop1


gli_loop:
  bl rand   @create the random number
  and r0,r0,#15
  sub r0,r0,#8
  mov r4,r0
loop2:
  cmp r7,r9
  beq loop2_end
  
  add r3,r7,r4  @c+g
  cmp r3,#0   @if less than 0, column == width -1
  blt neg_situation

  cmp r3,r9 @if larger than width, then column ==0
  bge pos_situation


  
  mov r0,r10  @else, just set and get the pixel
  mov r1,r6
  mov r2,r3
  bl get_pixel

  mov r0,r5
  mov r1,r6
  mov r2,r7
  bl set_pixel


  add r7,r7,#1
  b loop2

neg_situation:
  mov r0,r10
  mov r1,r6
  sub r2,r9,#1
  bl get_pixel

  mov r0,r5
  mov r1,r6
  mov r2,r7
  bl set_pixel
  
  add r7,r7,#1
  b loop2

pos_situation:
  mov r0,r10
  mov r1,r6
  mov r2,#0
  bl get_pixel

  mov r0,r5
  mov r1,r6
  mov r2,r7
  bl set_pixel

  add r7,r7,#1
  b loop2

loop2_end:
  add r6,r6,#1
  b loop1
glitch_done:
  
  mov r0,r5
  
  pop {r4-r10,lr}
	bx lr
