.data
  @
  @ The Game cell data structure
  @ This is the contents of a location in the array
  @
  .equ    cell_expected, 0
  .equ    cell_actual, 4
  .equ    cell_size, 8


  @
  @ The Game description data structure
  @
  .equ    game_rows, 0
  .equ    game_cols, 4
  .equ    game_array,8
  .equ    game_size, 12

  item: .asciz "  %c"
  col_item: .asciz "  %d"
  row_item: .asciz "%d"
  col_item_hard: .asciz " %d"
  empty: .asciz " "
  next_line: .asciz "\n"

.text
.global create_game
@
@ Create the game abstract data type
@ void *create_game(int rows, int cols)
@
create_game:
	push {r4-r8, lr}
  mov r4, r0
  mov r5, r1
  
	mov r0,#1
  mov r1, #game_size
  bl calloc       @ allocate

  str r4,[r0,#game_rows]
  str r5,[r0,#game_cols]
  
  mov r6,r0

  mul r0,r4,r5
  mov r1,#cell_size
  bl calloc

  str r0,[r6,#game_array]
  mov r0,r6

create_game_done:
	pop {r4-r8, lr}
	bx lr
	
	
.global destroy_game
@
@ void destroy_game(void *game)
@ Destroy the game, freeing all memory
@
destroy_game:
	push {r4, lr}
  mov r4,r0
  ldr r0,[r0,#game_array]
  bl free @first free the array
  mov r0,r4
  bl free @then free the game
	pop {r4, lr}
	bx lr
	
.global get_rows
@
@ Get the number of rows in the game
@ int get_rows(void *game)
@
get_rows:
	ldr r0,[r0,#game_rows]
	bx lr

.global get_cols
@
@ Get the number of columns in the game
@ int get_cols(void *game)
@
get_cols:
	ldr r0,[r0,#game_cols]
	bx lr

.global display_game
@
@ Display the game
@
display_game:
	push {r4-r10,lr}
  mov r10,r0
  ldr r7,[r10,#game_array]
  ldr r8,[r10,#game_rows]
  ldr r9,[r10,#game_cols]
  mov r3,#0
  mov r4,#0
  mov r5,#0
first_loop:
  cmp r4,#0   
  beq print_first @print the first empty string


  cmp r4,r9
  bgt new_line
  
  cmp r5,#10
  blt normal_loop1
  bge normal_loop2
normal_loop1:
  ldr r0,=col_item
  mov r1,r4
  bl printf   @print the column number
  
  add r4,r4,#1
  add r5,r5,#1
  b first_loop

normal_loop2:
  ldr r0,=col_item_hard
  mov r1,r4
  bl printf
  add r4,r4,#1
  add r5,r5,#1
  b first_loop



print_first:
  ldr r0,=empty
  bl printf
  add r4,r4,#1
  b first_loop
new_line:
  ldr r0,=next_line
  bl printf   @change to a new line
  b first_loop_end
first_loop_end:
  mov r5,#0
  mov r6,#0
second_loop:
  cmp r5,r8 
  bge display_game_done @This loop will run row times
   
  add r5,r5,#1
  ldr r0,=row_item
  mov r1,r5
  bl printf   @print the number of rows

third_loop:
  cmp r6,r9
  beq third_loop_end
  
  ldr r0,=item
  ldr r1,[r7,#cell_actual]
  bl printf @print the character in each cell

  add r6,r6,#1  
  add r7,r7,#cell_size  @get to the next cell
  b third_loop

third_loop_end: @change to a new line
  ldr r0,=next_line
  bl printf
  mov r6,#0

  b second_loop

display_game_done:
	pop {r4-r10,lr}
	bx lr

.global set_cell_actual
@
@ int set_cell_actual(void *game, int row, int col, char ch);
@ Returns: 1 if the answer value is correct
@
set_cell_actual:
	push {r4-r8,lr}
  
  mov r4,r3
  bl game_index

  str r4,[r0,#cell_actual]

  ldr r5,[r0,#cell_expected]
  
  mov r0,#0
  cmp r4,r5
  moveq r0,#1
  

	
set_cell_actual_done:
	pop {r4-r8,lr}
	bx lr

.global set_cell_expected
@
@ void set_cell_expected(void *game, int row, int col, char ch);
@
set_cell_expected:
	push {r4-r8,lr}
	
	mov r4,r3           @ save ch in r4
  bl game_index

  str r4,[r0,#cell_expected]  @ save ch into game
  pop {r4-r8,lr}
	bx lr


.global game_win
@
@ int game_win(void *game)
@ Returns true when the game is done/won
@
game_win:
	push {r4-r8,lr}
  ldr r1,[r0,#game_rows]
  ldr r2,[r0,#game_cols]
  mul r1, r1,r2
  ldr r2,[r0,#game_array]

loop1:
  cmp r1,#0
  beq loop1_end
  ldr r3,[r2,#cell_actual]
  ldr r4,[r2,#cell_expected]
  cmp r3,r4
  bne game_lose_done

  add r2,r2,#cell_size
  sub r1,r1,#1
  b loop1

loop1_end:
  mov r0,#1
  b game_win_done


  
game_win_done:
	pop {r4-r8,lr}
	bx lr

game_lose_done:
  mov r0,#0
  pop {r4-r8,lr}
  bx lr

.global game_index
@
@ int *game_index(void *game, int row, int col)
@ Get the address of a row and column in the cells
@	
game_index:
  push {r4-r8,lr}
  sub r3, r1,#1
  ldr r4,[r0,#game_cols]
  mul r3, r3,r4
  add r3, r3,r2
  sub r3, r3,#1
  mov r4, #cell_size
  mul r3, r3,r4   @the formula
	ldr r0,[r0,#game_array] @address of the array

  add r0,r0,r3  @add the formula and the address
  pop {r4-r8,lr}
  bx lr
	
	
