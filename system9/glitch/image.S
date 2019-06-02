.data
  .equ    cell_actual, 0
  .equ    cell_size, 8

  .equ    game_rows, 0  @which is height
  .equ    game_cols, 4  @which is width
  .equ    game_array,8
  .equ    game_size, 12
.text
.global create_image
@
@ void *create_image(int wid, int hit)
@ Create an image ADT and return it.
@
create_image:
	
  push {r4-r8, lr}
  mov r4, r0
  mov r5, r1

  mov r0,#1
  mov r1, #game_size
  bl calloc       @ allocate

  str r4,[r0,#game_cols]
  str r5,[r0,#game_rows]

  mov r6,r0

  mul r0,r4,r5
  mov r1,#cell_size
  bl calloc

  str r0,[r6,#game_array]
  mov r0,r6
create_image_done:
  pop {r4-r8, lr}

	bx lr

.global destroy_image	
@
@ void destroy_image(void *image)
@ Destroy image, freeing memory
@
destroy_image:
  push {r4, lr}
  mov r4,r0
  ldr r0,[r0,#game_array]
  bl free @first free the array
  mov r0,r4
  bl free @then free the game
  pop {r4, lr}
	bx lr

.global get_width
@
@ int get_width(void *image)
@ Get the width of the image
@
get_width:
  push {r4,lr}
	ldr r0,[r0,#game_cols]
  pop {r4,lr}
	bx lr
	
.global get_height
@
@ int get_height(void *height)
@ Get the height of the image
@
get_height:
  push {r4,lr}
	ldr r0,[r0,#game_rows]
  pop {r4,lr}
  bx lr
	
.global set_pixel

@ void set_pixel(void *image, int row, int col, double value)
@
set_pixel:

  push {r4-r8,lr}
  
  
  ldr r4,[r0,#game_cols]
  mul r5, r1,r4
  add r6, r5,r2
  mov r7, #cell_size
  mul r8, r6,r7   @the formula
  ldr r3,[r0,#game_array] @address of the array

  add r0,r8,r3  @add the formula and the address
  
  vstr d0,[r0]

set_pixel_done:
  pop {r4-r8,lr}

	bx lr

.global get_pixel
@
@ double get_pixel(void *image, int row, int col)
@
get_pixel:
  push {r4-r8,lr}
 
  ldr r4,[r0,#game_cols]
  mul r5, r1,r4
  add r6, r5,r2
  mov r7, #cell_size
  mul r8, r6,r7   @the formula
  ldr r3,[r0,#game_array] @address of the array

  add r0,r8,r3  @add the formula and the address

  vldr d0,[r0]
get_pixel_done:
  pop {r4-r8,lr}
	bx lr
