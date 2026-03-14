[org 0x0100]

jmp start

; data section
snake_x:     times 100 db 0    
snake_y:     times 100 db 0    
snake_len:   dw 3               

food_x:      db 40
food_y:      db 12

direction:   db 1               ; 0 up, 1 right, 2 down, 3 left

min_x:       db 1               
max_x:       db 78              
min_y:       db 2               
max_y:       db 23              

score:       dw 0
high_score:  dw 0                    
game_over_msg: db 'GAME OVER!', 0
score_label: db 'Score: ', 0
high_score_label: db 'High Score: ', 0
final_score_label: db 'Final Score: ', 0
play_again_msg: db 'Play Again? (Y/N)', 0
controls_msg: db 'Arrow Keys: Move | ESC: Quit', 0

; title screen text
letter_S_1: db '  SSSSS', 0
letter_S_2: db ' S     ', 0
letter_S_3: db '  SSSS ', 0
letter_S_4: db '      S', 0
letter_S_5: db ' SSSSS ', 0

letter_N_1: db '  N   N', 0
letter_N_2: db '  NN  N', 0
letter_N_3: db '  N N N', 0
letter_N_4: db '  N  NN', 0
letter_N_5: db '  N   N', 0

letter_A1_1: db '   AAA ', 0
letter_A1_2: db '  A   A', 0
letter_A1_3: db '  AAAAA', 0
letter_A1_4: db '  A   A', 0
letter_A1_5: db '  A   A', 0

letter_K_1: db '  K   K', 0
letter_K_2: db '  K  K ', 0
letter_K_3: db '  KKK  ', 0
letter_K_4: db '  K  K ', 0
letter_K_5: db '  K   K', 0

letter_E1_1: db '  EEEEE', 0
letter_E1_2: db '  E    ', 0
letter_E1_3: db '  EEEE ', 0
letter_E1_4: db '  E    ', 0
letter_E1_5: db '  EEEEE', 0

; game letters
letter_G_1: db '  GGGG ', 0
letter_G_2: db ' G     ', 0
letter_G_3: db ' G  GG ', 0
letter_G_4: db ' G   G ', 0
letter_G_5: db '  GGGG ', 0

letter_M_1: db '  M   M', 0
letter_M_2: db '  MM MM', 0
letter_M_3: db '  M M M', 0
letter_M_4: db '  M   M', 0
letter_M_5: db '  M   M', 0

press_key_msg: db 'Press any key to start...', 0
created_by_msg: db 'Created by: Hamza Sheikh  (24L-2500)', 0
created_by_msg1: db 'Sadeem Arshad (24L-2502)', 0
quit_confirm_msg: db 'Are you sure you want to quit?', 0
quit_choice_msg: db '(Y/N)', 0
thanks_line1: db '', 0
thanks_line2: db '     THANKS FOR PLAYING!          ', 0
thanks_line3: db '                                  ', 0
thanks_line4: db '     Created by:                  ', 0
thanks_line5: db '     Hamza & Sadeem               ', 0
thanks_line6: db '', 0
color_temp: db 0x0A           

; functions for printing stuff on screen

print_string:
    push ax
    push cx
    push dx
    push si
    
print_string_loop:
    mov al, [si]
    cmp al, 0
    je print_string_done
    
    call print_char
    inc dl              
    inc si
    jmp print_string_loop
    
print_string_done:
    pop si
    pop dx
    pop cx
    pop ax
    ret

long_delay:
    push cx
    push dx
    
    mov cx, 0x0003
    
long_outer:
    mov dx, 0xFFFF
    
long_inner:
    nop      
    nop
    nop
    dec dx
    jnz long_inner
    
    loop long_outer
    
    pop dx
    pop cx
    ret

char_delay:
    push cx
    push dx
    
    mov cx, 0x0001      
    
char_outer:
    mov dx, 0x1000            
    
char_inner:
    nop  
    nop
    dec dx
    jnz char_inner
    
    loop char_outer
    
    pop dx
    pop cx
    ret

; prints one letter character by character for a nice effect
; dh = row, bl = column, di = letter data, color in color_temp
print_letter:
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov cx, 5                 
    
print_letter_line:
    push cx
    mov dl, bl                
    mov si, di                
    
    ; print each character in the line
print_line_chars:
    mov al, [si]
    cmp al, 0                 
    je next_letter_line
    
    push si
    mov ah, [color_temp]      
    push bx
    mov bl, ah                
    call print_char           
    call char_delay           
    pop bx
    pop si
    
    inc dl                    
    inc si                    
    jmp print_line_chars
    
next_letter_line:
    inc si
    mov di, si                
    
    inc dh                    
    pop cx
    loop print_letter_line
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

show_title_screen:
    call clear_screen
    
    ; draw snake word letter by letter
    ; print S
    mov byte [color_temp], 0Dh   
    mov dh, 5                      
    mov bl, 22                     
    mov di, letter_S_1
    call print_letter
    
    ; print N
    mov byte [color_temp], 0Dh
    mov dh, 5
    mov bl, 30
    mov di, letter_N_1
    call print_letter
    
    ; print A
    mov byte [color_temp], 0Dh    
    mov dh, 5
    mov bl, 38
    mov di, letter_A1_1
    call print_letter
    
    ; print K
    mov byte [color_temp], 0Dh    
    mov dh, 5
    mov bl, 46
    mov di, letter_K_1
    call print_letter
    
    ; print E
    mov byte [color_temp], 0Dh
    mov dh, 5
    mov bl, 54
    mov di, letter_E1_1
    call print_letter
    call long_delay
    
    ; now draw game word below snake
    ; print G
    mov byte [color_temp], 0x03    
    mov dh, 12                     
    mov bl, 22
    mov di, letter_G_1
    call print_letter
    
    ; print A
    mov byte [color_temp], 0x03
    mov dh, 12
    mov bl, 30
    mov di, letter_A1_1
    call print_letter
    
    ; print M
    mov byte [color_temp], 0x03    
    mov dh, 12
    mov bl, 38
    mov di, letter_M_1
    call print_letter
    
    ; print E
    mov byte [color_temp], 0x03    
    mov dh, 12
    mov bl, 46
    mov di, letter_E1_1
    call print_letter
    
    call long_delay
    call long_delay
    call long_delay
    
    ; show who made this
    mov dh, 18
    mov dl, 22
    mov si, created_by_msg
    mov bl, 0x07              
    call print_string
    call long_delay
    
    ; second creator name
    mov dh, 19
    mov dl, 34
    mov si, created_by_msg1
    mov bl, 0x07              
    call print_string
    call long_delay
    
    ; flash the press key message a few times
    mov cx, 3
    
flash_loop:
    push cx
    
    mov dh, 21
    mov dl, 27
    mov si, press_key_msg
    mov bl, 0x0F
    call print_string
    call long_delay
    call long_delay
    
    mov dh, 21
    mov dl, 27
    mov al, ' '
    mov bl, 0x00
    mov cx, 25
    
clear_msg_loop:
    call print_char
    inc dl
    loop clear_msg_loop
    
    call long_delay
    
    pop cx
    loop flash_loop
    
    mov dh, 21
    mov dl, 27
    mov si, press_key_msg
    mov bl, 0x0F
    call print_string
    
    mov ah, 0x00
    int 0x16
    
    ret

; game functions start here

; clears the screen
clear_screen:
    mov ah, 0x00
    mov al, 0x03        
    int 0x10
    ret

; makes cursor invisible
hide_cursor:
    mov ah, 0x01
    mov ch, 0x20
    mov cl, 0x00
    int 0x10
    ret

; prints a character at a specific spot
; dh = row, dl = column, al = character, bl = color
print_char:
    push ax
    push bx
    push cx
    push si
    
    mov ah, 0x02     
    mov bh, 0x00     
    int 0x10         
    
    mov ah, 0x09     
    mov bh, 0x00     
    mov cx, 0x01     
    int 0x10         
    
    pop si
    pop cx
    pop bx
    pop ax
    ret

; draws the game border with fancy box characters
draw_border:
    ; top border
    mov dh, [min_y]
    mov dl, [min_x]
    mov al, 201               
    mov bl, 0x0B              
    call print_char
    
    inc dl
top_border_loop:
    mov al, 205               
    mov bl, 0x0B
    call print_char
    inc dl
    cmp dl, [max_x]
    jl top_border_loop
    
    mov al, 187               
    mov bl, 0x0B
    call print_char
    
    ; bottom border
    mov dh, [max_y]
    mov dl, [min_x]
    mov al, 200               
    mov bl, 0x0B
    call print_char
    
    inc dl
bottom_border_loop:
    mov al, 205               
    mov bl, 0x0B
    call print_char
    inc dl
    cmp dl, [max_x]
    jl bottom_border_loop
    
    mov al, 188               
    mov bl, 0x0B
    call print_char
    
    ; left border
    mov dh, [min_y]
    inc dh
    mov dl, [min_x]
    
left_border_loop:
    mov al, 186               
    mov bl, 0x0B
    call print_char
    inc dh
    cmp dh, [max_y]
    jl left_border_loop
    
    ; right border
    mov dh, [min_y]
    inc dh
    mov dl, [max_x]
    
right_border_loop:
    mov al, 186               
    mov bl, 0x0B
    call print_char
    inc dh
    cmp dh, [max_y]
    jl right_border_loop
    
    ret

; sets up snake at starting position
init_snake:
    mov byte [snake_x + 0], 40
    mov byte [snake_y + 0], 12
    
    mov byte [snake_x + 1], 39
    mov byte [snake_y + 1], 12
    
    mov byte [snake_x + 2], 38
    mov byte [snake_y + 2], 12
    
    mov word [snake_len], 3
    mov byte [direction], 1
    mov word [score], 0       
    ret

; draws the whole snake on screen
draw_snake:
    mov cx, [snake_len]
    mov si, 0
    
draw_snake_loop:
    mov dl, [snake_x + si]
    mov dh, [snake_y + si]
    
    cmp si, 0
    je draw_head
    
    mov al, 254             
    mov bl, 0x03              
    jmp draw_segment
    
draw_head:
    mov al, 2              
    mov bl, 0x05              
    
draw_segment:
    call print_char
    
    inc si
    loop draw_snake_loop
    
    ret

; checks if player pressed any keys
check_input:
    mov ah, 0x01              
    int 0x16
    jz no_key_pressed         
    
    mov ah, 0x00              
    int 0x16
    
    ; check if escape was pressed
    cmp al, 27
    je exit_game
    
    ; check if its an arrow key
    cmp al, 0x00
    jne no_key_pressed
    
    ; which arrow key was it
    cmp ah, 0x48              
    je key_up
    cmp ah, 0x50              
    je key_down
    cmp ah, 0x4B              
    je key_left
    cmp ah, 0x4D              
    je key_right
    jmp no_key_pressed
    
key_up:
    mov al, [direction]
    cmp al, 2                 
    je no_key_pressed
    mov byte [direction], 0
    jmp no_key_pressed
    
key_down:
    mov al, [direction]
    cmp al, 0                 
    je no_key_pressed
    mov byte [direction], 2
    jmp no_key_pressed
    
key_left:
    mov al, [direction]
    cmp al, 1                 
    je no_key_pressed
    mov byte [direction], 3
    jmp no_key_pressed
    
key_right:
    mov al, [direction]
    cmp al, 3                 
    je no_key_pressed
    mov byte [direction], 1
    jmp no_key_pressed

exit_game:
    call confirm_quit         
    jmp game_loop             
    
no_key_pressed:
    ret

; erases a character from screen
erase_char:
    mov al, ' '
    mov bl, 0x00
    call print_char
    ret

; removes the snake from screen
erase_snake:
    mov cx, [snake_len]
    mov si, 0
    
erase_snake_loop:
    mov dl, [snake_x + si]
    mov dh, [snake_y + si]
    call erase_char
    
    inc si
    loop erase_snake_loop
    ret

; moves snake in whatever direction its going
move_snake:
    ; move all body parts forward
    mov cx, [snake_len]
    dec cx
    cmp cx, 0
    je move_head_only
    
    mov si, cx
    
shift_body_loop:
    mov al, [snake_x + si - 1]
    mov [snake_x + si], al
    
    mov al, [snake_y + si - 1]
    mov [snake_y + si], al
    
    dec si
    cmp si, 0
    jne shift_body_loop
    
move_head_only:
    ; move the head based on direction
    mov al, [direction]
    cmp al, 0
    je move_up
    cmp al, 1
    je move_right
    cmp al, 2
    je move_down
    cmp al, 3
    je move_left
    
move_up:
    mov al, [snake_y + 0]
    dec al
    mov [snake_y + 0], al
    jmp move_done
    
move_down:
    mov al, [snake_y + 0]
    inc al
    mov [snake_y + 0], al
    jmp move_done
    
move_left:
    mov al, [snake_x + 0]
    dec al
    mov [snake_x + 0], al
    jmp move_done
    
move_right:
    mov al, [snake_x + 0]
    inc al
    mov [snake_x + 0], al
    
move_done:
    ret

; slows down the game so its playable
delay:
    push cx
    push dx
    
    mov cx, 0x0001
    
outer_loop:
    mov dx, 0xFFFF
    
inner_loop:
    nop
    nop
    dec dx
    jnz inner_loop
    
    loop outer_loop
    
    pop dx
    pop cx
    ret

; checks if snake hit a wall
check_wall_collision:
    ; check left and right
    mov al, [snake_x + 0]     
    cmp al, [min_x]           
    jle game_over
    cmp al, [max_x]           
    jge game_over
    
    ; check top and bottom
    mov al, [snake_y + 0]     
    cmp al, [min_y]           
    jle game_over
    cmp al, [max_y]           
    jge game_over
    
    ret                       

; checks if snake ran into itself
check_self_collision:
    mov cx, [snake_len]       
    cmp cx, 4                 
    jl no_self_collision      
    
    ; get head position
    mov al, [snake_x + 0]     
    mov ah, [snake_y + 0]     
    
    mov si, 1                 
    
check_body_loop:
    ; see if head is on any body segment
    cmp al, [snake_x + si]    
    jne next_segment          
    cmp ah, [snake_y + si]    
    je game_over              
    
next_segment:
    inc si                    
    cmp si, cx                
    jl check_body_loop        
    
no_self_collision:
    ret                       
; Print number in AX at position DH, DL
; Input: AX = number to print, DH = row, DL = column
print_score_number:
    push ax
    push bx
    push cx
    push dx
    
    ; Handle zero case
    cmp ax, 0
    jne convert_digits
    mov al, '0'
    mov bl, 0x0E
    call print_char
    jmp done_print_score
    
convert_digits:
    mov cx, 0                 
    
divide_loop:
    mov bx, 10
    mov dx, 0                 ; clear dx before division
    div bx                    
    add dl, '0'              
    push dx                   ; push digit onto stack
    inc cx                    
    cmp ax, 0                 
    jne divide_loop           
    
   
    pop dx                    ; restore original dh, dl
    push dx                   ; save it again
    
print_digits_loop:
    pop ax                    ; get digit from stack
    mov bl, 0x0E              ; yellow color
    call print_char
    inc dl                    
    loop print_digits_loop    
    
done_print_score:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

game_over:
    ; update high score if needed
    mov ax, [score]
    cmp ax, [high_score]
    jle skip_high_score_update
    mov [high_score], ax
    
skip_high_score_update:
    call long_delay
    
    ; flash game over message
    mov cx, 3
    
flash_game_over:
    push cx
    
    mov dh, 10
    mov dl, 35
    mov si, game_over_msg
    mov bl, 0x0C
    call print_string
    
    call long_delay
    
    ; clear it
    mov dh, 10
    mov dl, 35
    mov cx, 10
    mov al, ' '
    mov bl, 0x00
    
clear_go_loop:
    call print_char
    inc dl
    loop clear_go_loop
    
    call long_delay
    
    pop cx
    loop flash_game_over
    
    ; show it one last time
    mov dh, 10
    mov dl, 35
    mov si, game_over_msg
    mov bl, 0x0C
    call print_string
    
    ; show final score
    mov dh, 13
    mov dl, 32
    mov si, final_score_label
    mov bl, 0x0D
    call print_string
    
; Print the score number
    mov dh, 13
    mov dl, 45
    mov ax, [score]
    call print_number
    
    ; ask if they want to play again
    mov dh, 16
    mov dl, 31
    mov si, play_again_msg
    mov bl, 0x0F
    call print_string
    
wait_choice:
    mov ah, 0x00
    int 0x16
    
    ; check for yes
    cmp al, 'Y'
    je restart_game
    cmp al, 'y'
    je restart_game
    
    ; check for no or escape
    cmp al, 'N'
    je quit_to_thanks
    cmp al, 'n'
    je quit_to_thanks
    cmp al, 27
    je quit_to_thanks
    
    jmp wait_choice

restart_game:
    jmp game_start            

quit_to_thanks:
    call show_thanks_screen   

; makes food appear at random spot
generate_food:
    push ax
    push bx
    push cx
    push dx
    
get_random_position:
    ; use system timer for randomness
    mov ah, 0x00              
    int 0x1A                  
    
    ; use only low byte to avoid problems
    mov al, dl                
    mov ah, 0                 
    
    mov bl, [max_x]
    sub bl, [min_x]
    dec bl                    
    
    cmp bl, 0                 
    je default_food_x
    
    div bl                    
    mov al, ah                
    
default_food_x:
    add al, [min_x]
    inc al                    
    mov [food_x], al          
    
    ; wait a bit for different random number
    mov cx, 0x0100
delay_random:
    nop
    loop delay_random
    
    ; now get y coordinate
    mov ah, 0x00
    int 0x1A
    
    mov al, dl                
    mov ah, 0
    
    mov bl, [max_y]
    sub bl, [min_y]
    dec bl
    
    cmp bl, 0
    je default_food_y
    
    div bl
    mov al, ah
    
default_food_y:
    add al, [min_y]
    inc al
    mov [food_y], al          
    
    ; make sure food didnt spawn on snake
    call check_food_on_snake
    cmp al, 1                 
    je get_random_position    
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; checks if food spawned on snake body
check_food_on_snake:
    push si
    push cx
    
    mov cx, [snake_len]
    mov si, 0
    
check_food_loop:
    mov al, [food_x]
    cmp al, [snake_x + si]
    jne next_food_check
    
    mov al, [food_y]
    cmp al, [snake_y + si]
    je food_on_snake          
    
next_food_check:
    inc si
    loop check_food_loop
    
    ; food is clear
    mov al, 0
    pop cx
    pop si
    ret
    
food_on_snake:
    mov al, 1                 
    pop cx
    pop si
    ret

; draws the food on screen
draw_food:
    mov dl, [food_x]
    mov dh, [food_y]
    mov al, 15                
    mov bl, 0x0C              
    call print_char
    ret

; checks if snake ate the food
check_food_collision:
    mov al, [snake_x + 0]     
    cmp al, [food_x]
    jne no_food_collision
    
    mov al, [snake_y + 0]     
    cmp al, [food_y]
    jne no_food_collision
    
    ; snake ate it
    call grow_snake
    call generate_food        
    
no_food_collision:
    ret

; makes snake longer
grow_snake:
    push ax
    push si
    
    ; increase length
    mov ax, [snake_len]
    inc ax
    mov [snake_len], ax
    
    ; add new segment at end
    mov si, ax
    dec si                    
    
    mov al, [snake_x + si - 1]
    mov [snake_x + si], al
    
    mov al, [snake_y + si - 1]
    mov [snake_y + si], al
    
    ; increase score
    mov ax, [score]
    inc ax
    mov [score], ax
    
    pop si
    pop ax
    ret

; shows score at top of screen
display_score:
    push ax
    push bx
    push dx
    push si
    
    ; show current score
    mov dh, 1
    mov dl, 2
    mov si, score_label
    mov bl, 0x0F
    call print_string
    
    mov dl, 9
    mov ax, [score]
    call print_number
    
    ; show high score
    mov dh, 1
    mov dl, 50
    mov si, high_score_label
    mov bl, 0x0D
    call print_string
    
    mov dl, 63
    mov ax, [high_score]
    call print_number
    
    ; show controls at bottom
    mov dh, 24
    mov dl, 20
    mov si, controls_msg
    mov bl, 0x07
    call print_string
    
    pop si
    pop dx
    pop bx
    pop ax
    ret

; prints a number on screen
; dh = row, dl = column, ax = number
print_number:
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov si, dx                ; si = save position 
    
    ; Handle zero case
    cmp ax, 0
    jne pn_convert_digits
    mov al, '0'
    mov bl, 0x0E
    mov dx, si                ; restore position
    call print_char
    jmp pn_done
    
pn_convert_digits:
    mov cx, 0                 ; digit counter
    
pn_divide_loop:
    mov bx, 10
    mov dx, 0                 ; clear DX 
    div bx                    
    add dl, '0'               
    push dx                   ; push digit
    inc cx                    ; count digit
    cmp ax, 0
    jne pn_divide_loop
    
    mov dx, si                ; restore position
    
pn_print_loop:
    pop ax                    ; get digit
    mov bl, 0x0E              ; yellow
    call print_char
    inc dl                    ; next column
    loop pn_print_loop
    
pn_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; asks if player really wants to quit
confirm_quit:
    push ax
    push bx
    push dx
    push si
    
    ; show confirmation message
    mov dh, 10
    mov dl, 24
    mov si, quit_confirm_msg
    mov bl, 0x0E              
    call print_string
    
    mov dh, 12
    mov dl, 36
    mov si, quit_choice_msg
    mov bl, 0x0F              
    call print_string
    
wait_quit_choice:
    mov ah, 0x00
    int 0x16
    
    ; check if they really want to quit
    cmp al, 'Y'
    je do_quit
    cmp al, 'y'
    je do_quit
    
    ; check if they want to keep playing
    cmp al, 'N'
    je resume_game
    cmp al, 'n'
    je resume_game
    
    jmp wait_quit_choice
    
do_quit:
    pop si
    pop dx
    pop bx
    pop ax
    call show_thanks_screen
    
resume_game:
    ; clear the confirmation text
    mov dh, 10
    mov dl, 24
    mov cx, 31
    mov al, ' '
    mov bl, 0x00
    
clear_quit_msg1:
    call print_char
    inc dl
    loop clear_quit_msg1
    
    mov dh, 12
    mov dl, 36
    mov cx, 5
    mov al, ' '
    
clear_quit_msg2:
    call print_char
    inc dl
    loop clear_quit_msg2
    
    ; show countdown before starting again
    call show_countdown
    
    pop si
    pop dx
    pop bx
    pop ax
    ret                       

; shows thanks for playing screen
show_thanks_screen:
    call clear_screen
    
    ; show thanks message
    mov dh, 8
    mov dl, 23
    mov si, thanks_line1
    mov bl, 0x0F             
    call print_string
    call long_delay
    
    mov dh, 10
    mov dl, 23
    mov si, thanks_line2
    mov bl, 0x06
    call print_string
    
    mov dh, 11
    mov dl, 23
    mov si, thanks_line3
    mov bl, 0x01
    call print_string
    
    mov dh, 12
    mov dl, 23
    mov si, thanks_line4
    mov bl, 0x07              
    call print_string
    
    mov dh, 13
    mov dl, 23
    mov si, thanks_line5
    mov bl, 0x07
    call print_string
    call long_delay
    
    mov dh, 15
    mov dl, 23
    mov si, thanks_line6
    mov bl, 0x0F
    call print_string
    
    ; wait 3 seconds then exit
    call long_delay
    call long_delay
    call long_delay
    
    mov ax, 0x4c00
    int 0x21

; shows countdown before game starts
show_countdown:
    push ax
    push bx
    push dx
    push si
    
    ; print starting in message
    mov dh, 10
    mov dl, 32
    mov al, 'S'
    mov bl, 0x0F
    call print_char
    inc dl
    mov al, 't'
    call print_char
    inc dl
    mov al, 'a'
    call print_char
    inc dl
    mov al, 'r'
    call print_char
    inc dl
    mov al, 't'
    call print_char
    inc dl
    mov al, 'i'
    call print_char
    inc dl
    mov al, 'n'
    call print_char
    inc dl
    mov al, 'g'
    call print_char
    inc dl
    mov al, ' '
    call print_char
    inc dl
    mov al, 'i'
    call print_char
    inc dl
    mov al, 'n'
    call print_char
    inc dl
    mov al, ':'
    call print_char
    inc dl
    mov al, ' '
    call print_char
    inc dl
    
    ; show 3
    mov al, '3'
    mov bl, 0x03              
    call print_char
    call long_delay
    call long_delay
    call long_delay
    
    ; show 2
    mov al, '2'
    mov bl, 0x05              
    call print_char
    call long_delay
    call long_delay
    call long_delay
    
    ; show 1
    mov al, '1'
    mov bl, 0x01              
    call print_char
    call long_delay
    call long_delay
    call long_delay
    
    ; clear countdown message
    mov dh, 10
    mov dl, 32
    mov cx, 15
    mov al, ' '
    mov bl, 0x00
    
clear_countdown_loop:
    call print_char
    inc dl
    loop clear_countdown_loop
    
    pop si
    pop dx
    pop bx
    pop ax
    ret

start:
    call show_title_screen
    
game_start:                   
    call clear_screen
    call hide_cursor
    call draw_border
    call init_snake
    call generate_food
    call draw_food
    call draw_snake
    call display_score
    
    call show_countdown
    
game_loop:
    call check_input
    call delay
    call erase_snake
    call move_snake
    call check_wall_collision
    call check_self_collision
    call check_food_collision
    call draw_food
    call draw_snake
    call display_score
    jmp game_loop