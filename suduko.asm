[org 0x0100]

JMP START

filename db 'image.raw', 0
filename2 db 'image1.raw', 0
buffer_size equ 64000
digit1: db 0
digit2: db 0
rectX   dw 144   ; X position of the rectangle
rectY   dw 74   ; Y position of the rectangle
width   dw 33   ; Width of the rectangle
height  dw 33   ; Height of the rectangle
curr_row_select dw 0
curr_col_select dw 0
Game_win db 0
Score_req db 0

calc_rectX   dw 0   ; X position of the rectangle
calc_rectY   dw 0   ; Y position of the rectangle
mini_rectX   dw 0   ; X position of the rectangle
mini_rectY   dw 0   ; Y position of the rectangle
mini_width   dw 9   ; Width of the rectangle
mini_height  dw 9   ; Height of the rectangle
mini_curr_row_select dw 0
mini_curr_col_select dw 0

ms_counter dw 0   ; Milliseconds counter
sec_counter dw 0  ; Seconds counter
min_counter dw 0  ; Minutes counter
input_data db 0
data_seg dw 0
mini_grid_row dw 0
mini_grid_col dw 0
seed dw 4234
removed_count db 0
stack_val  db 100 dup(0) ; Stores pushed values
stack_col  db 100 dup(0) ; Stores column indices
stack_row  db 100 dup(0) ; Stores row indices
stack_top db 0
curr_val_select db 0
corrects dw 0
diff_mode db 0
mistakes_done dw 0
allowed_mistakes dw 0
sub_val db 0
Loadinga db 'Loading', 0
Loadingb db 'Loading..', 0
Loadingc db 'Loading...', 0
Loadingd db 'Loading....', 0

    char_width db 8
    char_height db 8
	
music_length: dw 15644
music_data: incbin "getthem.imf"

easy_msg db "1. Two", 0
medium_msg db "2. Fifty", 0
hard_msg db "3. Infinity", 0
Welcome_message db "Choose The Number of Brain Cells U have:", 0
Discourage db "MAYBE TAKE A NAP AND DON'T TRY AGAIN!", 0
Encourage db "BRO YOU GOT BIG BIG BRAIN", 0
keyboardISR_Original dw 0        ; Offset of the original keyboard ISR
keyboardISR_Original_cs dw 0     ; Segment of the original keyboard ISR
timerISR_Original dw 0           ; Offset of the original timer ISR
timerISR_Original_cs dw 0        ; Segment of the original timer ISR



big0:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big1:
	db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 11111111b,11111111b, 00000000b
    db 00000000b, 11111111b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 00000000b,11111111b, 00000000b
    db 00000000b, 11111111b,11111111b, 11111111b
    db 00000000b, 11111111b,11111111b, 11111111b
big2: 
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big3:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big4:
	db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b

big5:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big6:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 00000000b,00000000b, 00000000b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big7:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b

big8:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b

big9:
	db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 00000000b,00000000b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 11111111b, 11111111b,11111111b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
    db 00000000b, 00000000b,00000000b, 11111111b
	
	
	square_outline:
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Top border (solid row)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (1st row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (2nd row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (3rd row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (4th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (5th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (6th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (7th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (8th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (9th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (10th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (11th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (12th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (13th row inside)
    db 10000000b, 00000000b, 00000000b, 00000001b  ; Left and right outline (14th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Bottom border (solid row)
	
	black_filled_square:
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Top border (solid row)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (1st row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (2nd row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (3rd row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (4th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (5th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (6th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (7th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (8th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (9th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (11th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (11th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (12th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (13th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Left and right outline (14th row inside)
    db 11111111b, 11111111b, 11111111b, 11111111b  ; Bottom border (solid row)
	
	Smiley:
db 00000000b, 00000000b, 00000000b, 00000000b
db 00000011b, 11111111b, 11111111b, 11110000b
db 00001100b, 00000000b, 00000000b, 00001100b
db 00011000b, 00000000b, 00000000b, 00000110b 
db 00110000b, 01111000b, 00001111b, 00000011b 
db 01100000b, 01111000b, 00001111b, 00000011b 
db 01100000b, 01111000b, 00001111b, 00000011b 
db 11000000b, 00000000b, 00000000b, 00000011b 
db 11000000b, 00000000b, 00000000b, 00000011b 
db 11000000b, 00000000b, 00000000b, 00000011b 
db 01100000b, 01100000b, 00000011b, 00000011b 
db 01100000b, 00011000b, 00001100b, 00000110b 
db 00110000b, 00000111b, 11110000b, 00001100b 
db 00011000b, 00000000b, 00000000b, 00011000b 
db 00001111b, 11111111b, 11111111b, 11110000b 
db 00000000b, 00000000b, 00000000b, 00000000b


G db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 11111111b, 11111111b
db 11111111b, 00000000b, 11111110b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 11111111b, 11111110b, 11111111b
db 11111111b, 11111111b, 11111110b, 11111111b

A db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b

M db 11111111b, 00000000b, 00000000b, 11111111b
db 11111001b, 11000000b, 00000011b, 10011111b
db 11111000b, 11100000b, 00000111b, 00011111b
db 11111000b, 01110000b, 00001110b, 00011111b
db 11111000b, 00111000b, 00011100b, 00011111b
db 11111000b, 00011100b, 00111000b, 00011111b
db 11111000b, 00001110b, 01110000b, 00011111b
db 11111000b, 00000111b, 11100000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b
db 11111000b, 00000000b, 00000000b, 00011111b

E db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 00000000b, 00000000b, 00000000b
db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b


N db 11111111b, 10000000b, 00000000b, 11111111b
db 11111111b, 11000000b, 00000000b, 11111111b
db 11111111b, 11000000b, 00000000b, 11111111b
db 11111111b, 11100000b, 00000000b, 11111111b
db 11111111b, 00110000b, 00000000b, 11111111b
db 11111111b, 00111000b, 00000000b, 11111111b
db 11111111b, 00011100b, 00000000b, 11111111b
db 11111111b, 00001111b, 00000000b, 11111111b
db 11111111b, 00000111b, 10000000b, 11111111b
db 11111111b, 00000000b, 11000000b, 11111111b
db 11111111b, 00000000b, 01100000b, 11111111b
db 11111111b, 00000000b, 00111000b, 11111111b
db 11111111b, 00000000b, 00011110b, 11111111b
db 11111111b, 00000000b, 00001111b, 11111111b
db 11111111b, 00000000b, 00000111b, 11111111b
db 11111111b, 00000000b, 00000011b, 11111111b

D db 11111111b, 11111111b, 11111111b, 00000000b
db 11111111b, 11111111b, 11111111b, 10000000b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 11111111b, 11111111b, 10000000b
db 11111111b, 11111111b, 11111111b, 00000000b

W db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00000000b, 00000000b, 11111111b
db 11111111b, 00001111b, 11110000b, 11111111b
db 11111111b, 00011111b, 11111100b, 11111111b
db 11111111b, 00111111b, 11111100b, 11111111b
db 11111111b, 11111000b, 01111110b, 11111111b
db 11111111b, 11111000b, 00111000b, 11111111b
db 11111111b, 11110000b, 00011110b, 11111111b
db 11111111b, 11100000b, 00001111b, 11111111b
db 11111111b, 11000000b, 00000111b, 11111111b
db 11111111b, 10000000b, 00000001b, 11111111b

I db 11111111b, 11111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 00000000b, 00111111b, 11100000b, 00000000b
db 11111111b, 00111111b, 11111111b, 11111111b
db 11111111b, 11111111b, 11111111b, 11111111b




;arrays to store the bitmapping of the caracters of notes
num0: db 00000000b , 00000000b , 00000000b , 00000000b , 00000000b , 00000000b , 00000000b , 00000000b
num1: db 00001000b , 00011000b , 00101000b , 00001000b , 00001000b , 00001000b , 00001000b , 00111110b
num2: db 00111100b , 01000100b , 10000100b , 00001000b , 00010000b , 00100000b , 01000000b , 11111110b
num3: db 00111100b , 01000010b , 01000010b , 00001110b , 00001110b , 01000010b , 01000010b , 00111100b
num4: db 00001000b , 00011000b , 00101000b , 01001000b , 01111110b , 00001000b , 00001000b , 00001000b
num5: db 01111100b , 01000000b , 01000000b , 01111000b , 00000100b , 00000100b , 01000100b , 00111000b 
num6: db 01111110b , 01000000b , 01000000b , 01000000b , 01111110b , 01000010b , 01000010b , 01111110b
num7: db 01111100b , 00000100b , 00000100b , 00011110b , 00000100b , 00000100b , 00000100b , 00000100b
num8: db 01111110b , 01000010b , 01000010b , 01111110b , 01111110b , 01000010b , 01000010b , 01111110b
num9: db 01111100b , 01000100b , 01000100b , 01111100b , 00000100b , 00000100b , 00000100b , 00000100b 

table1 db 5, 3, 4, 6, 7, 8, 9, 1, 2, \
          6, 7, 2, 1, 9, 5, 3, 4, 8, \
          1, 9, 8, 3, 4, 2, 5, 6, 7, \
          8, 5, 9, 7, 6, 1, 4, 2, 3, \
          4, 2, 6, 8, 5, 3, 7, 9, 1, \
          7, 1, 3, 9, 2, 4, 8, 5, 6, \
          9, 6, 1, 5, 3, 7, 2, 8, 4, \
          2, 8, 7, 4, 1, 9, 6, 3, 5, \
          3, 4, 5, 2, 8, 6, 1, 7, 9

; Sudoku Table 2
table2 db 1, 4, 5, 8, 6, 2, 3, 9, 7, \
          6, 2, 9, 5, 7, 3, 8, 1, 4, \
          8, 7, 3, 9, 4, 1, 6, 5, 2, \
          4, 5, 6, 3, 2, 9, 7, 8, 1, \
          9, 3, 8, 1, 5, 7, 4, 2, 6, \
          7, 1, 2, 6, 8, 4, 9, 3, 5, \
          5, 9, 1, 7, 3, 8, 2, 4, 6, \
          3, 6, 7, 4, 9, 5, 1, 8, 2, \
          2, 8, 4, 6, 1, 3, 5, 7, 9

; Sudoku Table 3
table3 db 8, 2, 7, 1, 5, 4, 3, 9, 6, \
          1, 5, 9, 3, 2, 6, 8, 4, 7, \
          4, 3, 6, 8, 7, 9, 5, 2, 1, \
          3, 7, 2, 5, 1, 8, 6, 4, 9, \
          9, 8, 5, 7, 4, 6, 2, 1, 3, \
          6, 1, 4, 9, 3, 2, 7, 5, 8, \
          5, 9, 3, 6, 8, 1, 4, 7, 2, \
          2, 4, 8, 7, 6, 5, 1, 3, 9, \
          7, 6, 1, 4, 9, 3, 2, 8, 5

; Sudoku Table 4
table4 db 9, 8, 1, 3, 6, 7, 5, 4, 2, \
          2, 6, 7, 9, 4, 5, 8, 1, 3, \
          5, 4, 3, 8, 2, 1, 7, 9, 6, \
          6, 9, 5, 7, 1, 3, 4, 2, 8, \
          3, 1, 2, 6, 8, 4, 9, 7, 5, \
          8, 7, 4, 2, 5, 9, 1, 3, 6, \
          7, 5, 9, 1, 3, 6, 2, 8, 4, \
          1, 3, 8, 4, 9, 2, 6, 5, 7, \
          4, 2, 6, 5, 7, 8, 3, 1, 9



userArr: db 0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0, \
               0,0,0,0,0,0,0,0,0,
		
		user:  db   5,3,4,6,7,8,9,1,2
user2:  db   6,7,2,1,9,5,3,4,8
user3:  db   1,9,8,3,4,2,5,6,7
user4:  db   8,5,9,7,6,1,4,2,3
user5:  db   4,2,6,8,5,3,7,9,1
user6:  db   7,1,3,9,2,4,8,5,6
user7:  db   9,6,1,5,3,7,2,8,4
user8:  db   2,8,7,4,1,9,6,3,5
user9:  db   3,4,5,2,8,6,1,7,9

		
userArrTable: dw user, user2, user3, user4, user5, user6, user7, user8, user9
dataSeg: dw 0


;Arrays to check if to print Notes
bool1: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool2: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool3: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool4: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool5: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool6: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool7: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool8: db 1, 1, 1, 1, 1, 1, 1, 1, 1
bool9: db 1, 1, 1, 1, 1, 1, 1, 1, 1

input1: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input2: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input3: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input4: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input5: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input6: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input7: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input8: db 1, 1, 1, 1, 1, 1, 1, 1, 1
input9: db 1, 1, 1, 1, 1, 1, 1, 1, 1



;arrays for the notes

arr1: db 1,2,3,0,0,0,0,0,0
arr2: db 1,2,3,0,0,0,0,0,0
arr3: db 1,0,0,4,0,6,0,0,0
arr4: db 0,0,0,0,0,0,0,0,0
arr5: db 0,2,0,0,0,0,0,0,0
arr6: db 0,0,0,0,0,0,0,0,9
arr7: db 0,0,0,0,0,0,0,0,0
arr8: db 0,0,0,0,0,0,0,0,0
arr9: db 1,2,3,0,0,0,0,0,0
arr10: db 1,0,0,0,0,0,0,0,0
arr11: db 1,0,0,0,0,0,0,0,0
arr12: db 1,0,0,0,0,0,0,0,0
arr13: db 1,0,0,0,0,0,0,0,0
arr14: db 1,0,0,0,0,0,0,0,0
arr15: db 1,0,0,0,0,0,0,0,0
arr16: db 1,0,0,0,0,0,0,0,0
arr17: db 0,2,0,0,0,0,0,0,0
arr18: db 0,2,0,0,0,0,0,0,0
arr19: db 0,2,0,0,0,0,0,0,0
arr20: db 0,2,0,0,0,0,0,0,0
arr21: db 0,2,0,0,0,0,0,0,0
arr22: db 0,2,0,0,0,0,0,0,0
arr23: db 0,2,0,0,0,0,4,3,0
arr24: db 0,2,0,0,0,0,0,0,0
arr25: db 0,0,0,0,0,0,0,0,0
arr26: db 0,0,0,0,0,0,0,0,0
arr27: db 0,0,0,0,0,0,0,0,0
arr28: db 0,0,0,0,0,0,0,0,0
arr29: db 0,0,0,0,0,0,0,0,0
arr30: db 0,0,0,0,0,0,0,0,0
arr31: db 0,0,0,0,0,0,0,0,0
arr32: db 0,0,0,0,0,0,0,0,0
arr33: db 0,0,0,0,0,0,0,0,0
arr34: db 0,0,0,0,0,0,0,0,0
arr35: db 0,0,0,0,0,0,0,0,0
arr36: db 0,0,0,0,0,0,0,0,0
arr37: db 0,0,0,0,0,0,0,0,0
arr38: db 0,0,0,0,0,0,0,0,0
arr39: db 0,0,0,0,0,0,0,0,0
arr40: db 0,0,0,4,0,0,0,0,0
arr41: db 0,0,0,0,5,0,0,0,0
arr42: db 0,0,0,0,5,0,0,0,0
arr43: db 0,0,0,0,5,0,0,0,0
arr44: db 0,0,0,0,5,0,0,0,0
arr45: db 0,0,0,0,5,0,0,0,0
arr46: db 0,0,0,0,5,0,0,0,0
arr47: db 0,0,0,0,5,0,0,0,0
arr48: db 0,0,0,0,5,0,0,0,0
arr49: db 0,0,0,0,0,0,0,0,0
arr50: db 0,0,0,0,0,0,0,0,0
arr51: db 0,0,0,0,0,0,0,0,0
arr52: db 0,0,0,0,0,0,0,0,0
arr53: db 1,2,3,4,5,6,7,8,9
arr54: db 1,2,3,4,5,6,7,8,9
arr55: db 0,0,0,0,0,0,0,0,0
arr56: db 0,0,0,0,0,0,0,0,0
arr57: db 0,0,0,0,0,0,0,0,0
arr58: db 0,0,0,0,0,0,0,0,0
arr59: db 0,0,0,0,0,0,0,0,0
arr60: db 0,0,0,0,0,0,0,0,0
arr61: db 0,0,0,0,5,0,0,0,0
arr62: db 0,0,0,0,0,0,0,0,0
arr63: db 0,0,0,0,0,0,0,0,0
arr64: db 0,0,0,0,0,0,0,0,0
arr65: db 0,0,0,0,0,0,0,0,0
arr66: db 0,0,0,0,0,0,0,0,0
arr67: db 0,0,0,0,0,0,0,0,9
arr68: db 0,0,0,0,0,0,0,0,0
arr69: db 0,0,0,0,0,0,0,0,0
arr70: db 0,0,0,0,0,0,0,0,0
arr71: db 0,0,0,0,0,0,0,0,0
arr72: db 0,0,0,0,0,0,0,0,0
arr73: db 0,0,0,0,0,0,0,0,0
arr74: db 1,2,3,4,5,0,7,8,9
arr75: db 0,0,0,0,0,0,0,0,0
arr76: db 0,0,0,0,0,0,0,0,0
arr77: db 0,0,0,0,0,0,0,0,0
arr78: db 0,0,0,0,0,0,0,0,0
arr79: db 0,0,0,0,0,0,0,0,0
arr80: db 1,0,0,0,5,6,7,8,9
arr81: db 1,0,3,4,5,6,7,8,9


ArrayTable:
    dw arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8, arr9
    dw arr10, arr11, arr12, arr13, arr14, arr15, arr16, arr17, arr18
    dw arr19, arr20, arr21, arr22, arr23, arr24, arr25, arr26, arr27
    dw arr28, arr29, arr30, arr31, arr32, arr33, arr34, arr35, arr36
    dw arr37, arr38, arr39, arr40, arr41, arr42, arr43, arr44, arr45
    dw arr46, arr47, arr48, arr49, arr50, arr51, arr52, arr53, arr54
    dw arr55, arr56, arr57, arr58, arr59, arr60, arr61, arr62, arr63
    dw arr64, arr65, arr66, arr67, arr68, arr69, arr70, arr71, arr72
    dw arr73, arr74, arr75, arr76, arr77, arr78, arr79, arr80, arr81



AvailableNumbers: db 1,0,3,4,5,6,7,8,9
Avail_Num_Freq: db 1,2,3,7,7,7,9,7,3


Undo: db 'UNDO'
LengthOfUndo: dw LengthOfUndo - Undo

Hint: db 'HINT'
LengthOfHint: dw LengthOfHint - Hint

Pencil: db 'PENCIL'
LengthOfPencil: dw LengthOfPencil - Pencil

Erase: db 'ERASE'
LengthOfErase: dw LengthOfErase - Erase


mistakes: db 'Mistakes:  \ '
lengthOfMistakes: dw lengthOfMistakes-mistakes

Score: db 'Score:  '
LengthOfScore: dw LengthOfScore - Score

Time: db 'Time:   :'
lengthOfTime: dw lengthOfTime-Time

set_video_mode:
    mov ax, 0xa000   ; 640x480, 16-color mode
    mov es, ax
    int 0x10          ; Call BIOS interrupt to set video mode
    ret


PUSH_STACK:
    pusha                     ; Save registers
    xor bx, bx
    mov bx, [stack_top]       ; Load the current stack top index

    ; Check for stack overflow (assuming max stack size is 256 entries)
    cmp bx, 100        ; STACK_SIZE should be defined (e.g., 256)
    jae skip_push             ; Skip the push operation if overflow

    ; Push the current value to the stack
    mov al, [curr_val_select] ; Assuming a current value is selected
    mov [stack_val + bx], al  ; Store value in the stack

    mov al, [curr_col_select] ; Get the current column
    mov [stack_col + bx], al  ; Store column in the stack

    mov al, [curr_row_select] ; Get the current row
    mov [stack_row + bx], al  ; Store row in the stack

    ; Increment stack top
    add byte [stack_top], 1      ; Move stack pointer to the next position

skip_push:

    popa                      ; Restore registers
    ret                       ; Return
POP_STACK:
    pusha
    xor bx, bx
    cmp byte [stack_top], 0       ; Check if stack is empty
    jbe end_POP                   ; Jump if empty (or stack top is 0)

    sub byte [stack_top], 1        ; Decrement stack top
    mov bx, [stack_top]

    ; Restore the column and row values from the stack
    ;mov al, [stack_col + bx]
    ;mov [curr_col_select], al     ; Restore column
    ;mov al, [stack_row + bx]
    ;mov [curr_row_select], al     ; Restore row

    xor ax, ax
    mov ax, 9
    mul byte [stack_row + bx]     ; Calculate index (row * 9 + col)
    add ax, [stack_col + bx]
    mov si, ax                    ; Store final position in si

    mov al, [stack_val + bx]      ; Get the value from the stack
    mov [userArr + si], al        ; Update the userArr at the calculated position

end_POP:
    call Print_full_board        ; Print updated board

    popa
    ret
;Write graphics pixel	AH=0Ch	AL = Color, BH = Page Number, CX = x, DX = y

; Timer Variables

; Timer Interrupt Service Routine
timer_isr:
    pusha                  ; Save all registers
    push ds                ; Save data segment
	


    ; Increment millisecond counter
    add word [ms_counter], 55
    cmp word [ms_counter], 1000
    jl skip_seconds        ; If less than 1000ms, no further updates

    ; Reset milliseconds and increment seconds
    sub word [ms_counter], 1000
    inc word [sec_counter]
    cmp word [sec_counter], 60
    jl skip_minutes        ; If less than 60 seconds, skip minutes update

    ; Reset seconds and increment minutes

    mov word [sec_counter], 0
    inc word [min_counter]

skip_minutes:
skip_seconds:
    ; Call timerFunction to handle display (assumed to print time at a fixed location)
    call timerFunction
	
	
    ; Send End of Interrupt (EOI) to the PIC
    mov al, 0x20
    out 0x20, al
	
	EO_timer_isr:
	

    pop ds                 ; Restore data segment
    popa                   ; Restore registers
    iret                   ; Return from interrupt

setPixel: 
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV AH, 0x0C
	MOV AL, 0x03	; ATTRIBUTE  OF THE pixel
	MOV BH, 0
	MOV CX, [BP+4] ; VALUE OF X
	MOV DX, [BP+6] ; VALUE OF Y
	INT 10H
	POPA
	POP BP
	RET	4
	
setPixelBlue: 
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV AH, 0x0C
	MOV AL, 0x0c	; ATTRIBUTE  OF THE pixel
	MOV BH, 0
	MOV CX, [BP+4] ; VALUE OF X
	MOV DX, [BP+6] ; VALUE OF Y
	INT 10H
	POPA
	POP BP
	RET	4
	
HIGHLIGHTBOX:
    PUSH BP
    MOV BP, SP
    PUSHA

    ; Get parameters for top-left corner
    MOV AX, [BP+4]    ; X-coordinate
    MOV BX, [BP+6]    ; Y-coordinate

    ; Loop variables
    MOV CX, 511       ; Total pixels (32x16 - 1)
    XOR DX, DX        ; DX used for row and column tracking
    XOR SI, SI        ; Reset SI for clarity

DrawLoop:
    ; Increment column (DL)
    INC DL
    CMP DL, 32        ; Check if at the end of the row
    JNZ Not_Inc_Row_box   ; If not, continue in the same row

    ; Increment row (BX) and reset column
    MOV DL, 0
    INC BX
    SUB AX, 32        ; Reset AX to the starting X for the next row

Not_Inc_Row_box:
    ; Determine if the pixel is part of the border
    ; (first/last row or first/last column)
    CMP BX, [BP+6]        ; Is it the first row?
    JE setPixelBlue
    CMP BX, [BP+6+15]     ; Is it the last row (Y + 15)?
    JE SetPixel
    CMP DL, 1             ; Is it the first column?
    JE SetPixel
    CMP DL, 32            ; Is it the last column?
    JE SetPixel

    ; If not a border pixel, skip to next
    JMP Not_SetPixel_box

SetPixel:
    PUSH BX              ; Save current row (Y)
    PUSH AX              ; Save current column (X)
    CALL setPixel        ; Call setPixel to draw the border pixel

Not_SetPixel_box:
    INC AX               ; Move to the next X position
    LOOP DrawLoop        ; Continue loop until CX reaches 0

    POPA
    POP BP
    RET 4                ; Return after cleaning up stack


;push length
;push x
;push y
drawHorizontal:
PUSH bp
MOV BP, SP
pusha
mov ah, 0X0C
mov al, 0x0f
mov bh, 0
MOV DI, 10

mov DX, [bp+4] ;Y
OUTERLOOP:
	mov CX, [bp+6] ;X
	MOV SI, [BP+8] ;length
	ADD SI, CX
LP:
int 10h
INC CX
CMP CX, SI
JNE LP

ADD DX, 40 ; INCREMENTING Y FOR ANOTHER LINE
DEC di
JNZ OUTERLOOP

popa
POP BP
ret 6

DRAWVERTICAL:

PUSH bp
MOV BP, SP
pusha
mov ah, 0X0C
mov al, 0x0f
mov bh, 0
mov CX, [bp+6] ;X
MOV DI, 10

OUTERLOOP2:

mov DX, [bp+4] ;Y
MOV SI, [BP+8] ;length
ADD SI, DX

LPE:
int 10h
INC DX
CMP DX, SI
JNE LPE

ADD CX, 40
DEC di
JNZ OUTERLOOP2

popa
POP BP
RET 6



;[BP+4] WILL HAVE THE number to be printed
; [BP+6] WILL HAVE THE STARTTING VAL OF X
; [BP+8] WILL HAVE THE STARTTING VAL OF Y
PRINT32X16:
	PUSH BP
	MOV BP, SP
	PUSHA
	
	;calculating the address of the bitmap of the number to be printed
	mov ax, [bp+4]
	dec ax
	mov dx, 64
	mul DX
	mov di, ax
	ADD DI, big1
	
	
	
	MOV CX,511 ;OUTER COUNT FOR THE TRAVERSAL OF ARRAY
	MOV DX, 0 ;DL IS USED TO INCREMENT THE VALYE OF Y AND DH IS USED TO FETCH THE NEXT BYTE FOR PRINTINTG
	mov ax, [bp+6] ;value of pixel x of printitng
	mov bx, [bp+8] ; value of the pixel y
	add bx, 8;for the adjustment of printing in the centre of the box
	MOV SI, [DI]
	shl si, 8 ;WTF IS THIS FOR
prntLP:

	INC DL
	CMP DL, 32; 
JNZ Not_Inc_Row ;INCREMENTING THE VALUE OF Y HERE AND PLACE THE X BACK TO ZERO AND ADDING DI SO THAT IT  POINTS TO THE NEXT ROW
	MOV DL, 0
	INC BX
	SUB AX, 32
	; ADD DI, 1
	; Mov si, [di]
	; shl si, 8
Not_Inc_Row:
	INC DH
	CMP DH, 8
	jne NOT_RESET
	xor dh, DH
	inc DI
	mov si, [di]
	shl si, 8

NOT_RESET:
	

	INC ax
	shl si, 1
	jnc Not_SetPixel
	;BEOFRE THE NEXT 3 LINES, WE WILL CHECK WHETHER THE VALUE OF THE ARRAY IS 1
	cmp byte [bp+10], 1
	jne set_PIXEL_NOTDONE
	PUSH bx ;X
	PUSH ax ;Y
	call setPixel_Green
	jmp Not_SetPixel
	set_PIXEL_NOTDONE:
	PUSH bx ;X
	PUSH ax ;Y
	CALL setPixel
	

Not_SetPixel:
	
	loop prntLP

POPA
POP BP
RET 8





;[BP+4] WILL HAVE THE STARTING INDEX OF THE ARRAY OF THE BITMAP OF THE NUMBER
; [BP+6] WILL HAVE THE STARTTING VAL OF X
; [BP+8] WILL HAVE THE STARTTING VAL OF Y
PRINT8X8:
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV DI, [BP+4]
	MOV CX, 63 ;OUTER COUNT FOR THE TRAVERSAL OF ARRAY
	MOV DX, 0 ;
	mov ax, [bp+6] ;value of pixel x of printitng
	mov bx, [bp+8] ; value of the pixel y
	MOV SI, [DI]
	shl si, 9
printLP:

	INC DX
	CMP DX, 8 ; 
JNZ NOTRESET ;INCREMENTING THE VALUE OF Y HERE AND PLACE THE X BACK TO ZERO AND ADDING DI SO THAT IT  POINTS TO THE NEXT ROW
	MOV DX, 0
	INC BX
	SUB AX, 8
	ADD DI, 1
	Mov si, [di]
	shl si, 8


NOTRESET:

	INC ax
	shl si, 1
	jnc NotSetPixel
	;BEOFRE THE NEXT 3 LINES, WE WILL CHECK WHETHER THE VALUE OF THE ARRAY IS 1
	PUSH bx
	PUSH ax
	CALL setPixelBlue

NotSetPixel:
	
	loop printLP

POPA
POP BP
RET 6

;we have the array number parameter
; x of the printing [bp+6]
;Y of the pixel from where we need to start printing [BP+4]
;THE NUMBER OF THE ARRAY TO ACCESS: [BP+8]
PrintNotes:
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV BX, [BP+8] ;USED TO CALCUALTE THE OFFSET FROM THE ARR1 INDEX
	SHL BX, 3
	add bx, [bp+8]
	ADD BX, arr1 ; now bx has the address of the notes we have to print
	mov cx, 9
	MOV SI, [BP+4] ;Y
	MOV DI, [BP+6] ; X
	xor dx, dx
	xor ax, ax
mylp:
xor ax, ax
	MOV Al, [BX]
	DEC ax
	SHL AX, 3
	ADD AX, num1 ;WE SHOULD HAVE THE STARTING INDEX OF THE BITMAP ARRAY OF NUMBER TO BE PRINTED

	push SI
	push di
	push ax
	CALL PRINT8X8
	
	INC DX
	
	CMP Dx, 3
	jne NotIncNoteRow
		xor dx, dx
		ADD SI, 10
		mov di, [bp+6]	
		sub di, 10 ;because the next line adds a 10, this line is to ensure erfect printing

		
	
NotIncNoteRow:
	ADD DI, 10
	INC BX


loop mylp


	popa
	POP BP
	RET 6
;takes the char as parameters	
printchar:
push BP
		MOV BP, SP
		PUSHA
MOV Ah, 09H
MOV AL,[bp+4]
MOV BL, 0X12
MOV CX, 1
INT 10H
POPA
	POP BP
RET

;This function wil print the values if the value is not ZERO
;In case the value is zero, the notes array of the corresponding cell will be printed
;PARAMETERS:
; x of the printing [bp+6]
;Y of the pixel from where we need to start printing [BP+4]

PrintValues:
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV BX, 0 ; WILL ITERATE TILL BX= 81 BECAUSE WE HAVE 9*9 VALUES
	mov si, [BP+6] ;VALUE OF PIXEL X
	MOV DI, [BP+4] ; VALUE OF PIXEL Y
	ADD SI, 5
	ADD DI, 5
	MOV DX, 0 ;THIS REGISTER WILL BE USED TO KEEP A TRACK OF THE POINT AT WHICH WE WILL HAVE TO INCREMENT THE Y VALUE OF THE PIXEL PRINTING
	

OutLP:
	MOV Ax, [userArr+BX]
	xor ah, ah
	CMP byte [bool1+BX], 0
	Jne ValIsSet
	;CMP byte [userArr+BX], 0
	;jne ValIsSet
	
	PUSH BX
	PUSH SI
	PUSH DI
	call PrintNotes
	JMP HERE

ValIsSet:
	
	
	cmp byte [input1+bx], 0
	je make_number_green
	jmp make_number_red
	make_number_green:
	push 1
	jmp after_number_colour
	make_number_red:
	push 0
	after_number_colour:
	PUSH DI ;Y
	PUSH SI ;X
	PUSH AX ;VALUE OF THE CELL
	CALL PRINT32X16
	; ADD AX, 0X30
	; PUSH ax
	; CALL printchar
;this means that the cell has a value and we do not have to print the notes of the cell
;IT IS MISSING FOR NOW
HERE:
INC DX
CMP DX, 9
JNE NotIncRow
	MOV SI, [BP+6]
	ADD SI, 5
	ADD DI, 40
	MOV DX, 0 ;RESETTING THE COUNTER
	sub si, 40;to make sure the following line doesnt mess up the code
	

NotIncRow:
	ADD SI, 40

INC BX
CMP BX, 81
JNE OutLP
	
	
	POPA
	POP BP
	RET 4
	
	
printTime:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 18
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintTimeLoop:
		mov al, [Time + si]
		int 10h
		inc si
		cmp si, [lengthOfTime]
		jne PrintTimeLoop
	
	popa
	pop bp
	ret
	
PrintScore:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 36
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintScoreLoop:
		mov al, [Score + si]
		int 10h
		inc si
		cmp si, [LengthOfScore]
		jne PrintScoreLoop
	
	popa
	pop bp
	ret
	
printMistakes:
	push bp
	mov bp, sp
	push si
	push bx
	push ax
	push dx

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 50
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	loopStartsHere:
		mov al, [mistakes + si]
		int 10h
		inc si
		cmp si, [lengthOfMistakes]
		jne loopStartsHere
		
	call SetCursorAndPrintMistakes
	call SetCursorAndPrintMistakesAllowed
	
	pop dx
	pop ax
	pop bx
	pop si
	pop bp
	ret

timerFunction:
	push ax
	push cX
	xor cx, cX
	xor si, si
	mov cx, [min_counter]
	mov si, [sec_counter]
	mov cx, si

	;timerLoop:
		;call default_cursor_position
		;call display_minute
		;come:          ;come here after iteration of each minute till si= 60
		
		
		mov cx, [sec_counter]
	mov si, [min_counter]
		call minute_cursor_position
		;call clear_previous

		call display_number

		;call delay

		;inc cx
		;cmp cx, 60
		;jle come

		;inc si
		call default_cursor_position
		call display_minute
		;cmp si, 60
		;jle come

	pop cx
	pop ax
	ret
clear_previous:
	push ax
	push bx
	push cx

	mov ah, 0x0e
	mov al, 20
	mov bh, 0
	mov bl, 12

	int 10h
	mov al, 20
	int 10h
	mov al, 20
	int 10h

	pop cx
	pop bx
	pop ax

	ret

display_number:
	push ax
	push bx
	push cx

	mov ax, cx
	call convert_to_ascii

	mov ah, 0x0e
	mov al, [digit1]
	mov bh, 0
	mov bl, 0x0f
	int 10h


	mov al, [digit2]
	int 10h

	pop cx
	pop bx
	pop ax

	ret

display_minute:
	push ax
	push bx
	push si
	
	mov ax, si
	call convert_to_ascii

	mov ah, 0x0e
	mov al, [digit1]
	mov bh, 0
	mov bl, 0x0f
	int 10h


	mov al, [digit2]
	int 10h

	pop cx
	pop bx
	pop ax

	ret


delay:
	push ax
	push cx
	push dx

	mov cx, 0fh
	mov ah, 86h
	mov dx, 4240h
	int 15h

	pop dx
	pop cx
	pop ax
	ret

convert_to_ascii:
	push ax
	push dx
	push bx

	mov bx, 10
	xor dx, dx

	div bx
	add dl, 0x30
	mov [digit2], dl

	add al, 0x30
	mov [digit1], al

	pop bx
	pop dx
	pop ax
	ret

default_cursor_position:
	push ax
	push bx
	push dx

	mov ah, 02h
	mov bh, 0
	mov dl, 24
	mov dh, 3
	int 10h

	pop dx
	pop bx
	pop ax
	ret

minute_cursor_position:
	push ax
	push bx
	push dx

	mov ah, 02h
	mov bh, 0
	mov dl, 27
	mov dh, 3
	int 10h

	pop dx
	pop bx
	pop ax
	ret
	
;ptints all of the available numbers, takes x and y coordiantes as parameters	
PrintAvailableNumbers:

	push BP
	mov bp, SP
	pusha
	
	mov si, [bp+6]; x
	mov di, [bp+4] ;y
	add di, 5
	
	mov cx, 9
	mov bx, AvailableNumbers
	
	PrintAvailableNumbersLoop:
	
		mov ax, [bx]
		xor ah, ah
		cmp ax, 0
		je NotPrintNum
		
		push 0
		push DI
		push SI
		push ax
		call PRINT32X16
		
		add di, 30 ;adjusting the location
		add si, 16

		mov ax,[bx+ 9]; ax has the val now
		xor ah, ah
		dec ax
		shl ax, 3
		add ax, num1
		
		
		
		push DI
		push SI
		push ax
		call PRINT8X8
		sub di, 30
		sub si, 16
		;sub ax, 9
		
	
		
	NotPrintNum:
	add si, 40
	inc bx
	
	loop PrintAvailableNumbersLoop
	
	popa
	pop bp
	ret 4

;Write graphics pixel	AH=0Ch	AL = Color, BH = Page Number, CX = x, DX = y
setPixelGrey: 
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV AH, 0x0C
	MOV AL, 0X09 ; ATTRIBUTE  OF THE pixel
	MOV BH, 0
	MOV CX, [BP+4] ; VALUE OF X
	MOV DX, [BP+6] ; VALUE OF Y
	INT 10H
	POPA
	POP BP
	RET	4
	
setPixel_Green: 
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV AH, 0x0C
	MOV AL, 0X04 ; ATTRIBUTE  OF THE pixel
	MOV BH, 0
	MOV CX, [BP+4] ; VALUE OF X
	MOV DX, [BP+6] ; VALUE OF Y
	INT 10H
	POPA
	POP BP
	RET	4
	
setPixelOrg: 
	PUSH BP
	MOV BP, SP
	PUSHA
	MOV AH, 0x0C
	MOV AL, 0X00 ; ATTRIBUTE  OF THE pixel
	MOV BH, 0
	MOV CX, [BP+4] ; VALUE OF X
	MOV DX, [BP+6] ; VALUE OF Y
	INT 10H
	POPA
	POP BP
	RET	4
	


RectangleBorder:
push BP
mov bp, SP
pusha
	mov si, [bp+4] ;y
	mov di, [bp+6] ;x
	mov dx, [bp+8] ; height
	mov ax, [bp+10] ;width
	
	mov cx, dx ;drawing vertical lines
	
	BorderLoopVertical:
	push si
	push di
	call setPixelGrey
	
	add di, aX
	push si
	push di
	call setPixelGrey
	
	sub di, ax
	inc si
	
	loop BorderLoopVertical
	
	mov cx, ax
	mov si, [bp+4]
	mov di, [bp+6]
	BorderLoopHorizontal:
	push si
	push di
	call setPixelGrey
	
	add si, DX
	
	push si
	push di
	call setPixelGrey
	
	sub si, dx
	
	inc di
	
	loop BorderLoopHorizontal
	
	

popa
pop bp
ret 8




RectangleBorder_rem:
push BP
mov bp, SP
pusha
	mov si, [bp+4] ;y
	mov di, [bp+6] ;x
	mov dx, [bp+8] ; height
	mov ax, [bp+10] ;width
	
	mov cx, dx ;drawing vertical lines
	
	BorderLoopVertical_rem:
	push si
	push di
	call setPixelOrg
	
	add di, aX
	push si
	push di
	call setPixelOrg
	
	sub di, ax
	inc si
	
	loop BorderLoopVertical_rem
	
	mov cx, ax
	mov si, [bp+4]
	mov di, [bp+6]
	BorderLoopHorizontal_rem:
	push si
	push di
	call setPixelOrg
	
	add si, DX
	
	push si
	push di
	call setPixelOrg
	
	sub si, dx
	
	inc di
	
	loop BorderLoopHorizontal_rem
	
	

popa
pop bp
ret 8

PrintUndo:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 67
	mov dh, 9
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintUndoLoop:
		mov al, [Undo + si]
		int 10h
		inc si
		cmp si, [LengthOfUndo]
		jne PrintUndoLoop
	
	popa
	pop bp
	ret
	
PrintHint:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 67
	mov dh, 13
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintHintLoop:
		mov al, [Hint + si]
		int 10h
		inc si
		cmp si, [LengthOfHint]
		jne PrintHintLoop
	
	popa
	pop bp
	ret

PrintPencil:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 66
	mov dh, 17
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintPencilLoop:
		mov al, [Pencil + si]
		int 10h
		inc si
		cmp si, [LengthOfPencil]
		jne PrintPencilLoop
	
	popa
	pop bp
	ret
	
PrintErase:
	push bp
	mov bp, sp
	pusha

	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 66
	mov dh, 21
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	PrintEraseLoop:
		mov al, [Erase + si]
		int 10h
		inc si
		cmp si, [LengthOfErase]
		jne PrintEraseLoop
	
	popa
	pop bp
	ret

renderImage:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es

	

    mov ah, 0x3D
    mov al, 0
    mov dx, [bp + 4]
    int 0x21
    jc error2

    mov bx, ax

	push ds
    push word 0xA000
	pop ds

    mov ah, 0x3F
    mov cx, buffer_size
    mov dx, 0
    int 0x21
    jc error2

    mov ah, 0x3E
    int 0x21

	pop ds
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2
    error2:
            mov ah, 0x4C
            mov al, 1
       		int 0x21

playSound:
    push ax
    push bx
    push cx


    mov al, 10110110b           ;programable interval timer using channel 2 and mode 3
    out 0x43, al               ;sent output command to port 0x43   
    
    mov bx, 1193180 / 440   ; A4 (440 Hz)
    call beep

    mov bx, 1193180 / 523   ; C5 (523 Hz)
    call beep

    mov bx, 1193180 / 349   ; F4 (349 Hz)
    call beep

    mov bx, 1193180 / 659   ; E5 (659 Hz)
    call beep

    mov bx, 1193180 / 392   ; G4 (392 Hz)
    call beep

    mov bx, 1193180 / 784   ; G5 (784 Hz)
    call beep

    mov bx, 1193180 / 261   ; C4 (261 Hz)
    call beep

    mov bx, 1193180 / 330   ; E4 (330 Hz)
    call beep

    mov bx, 1193180 / 988   ; B5 (988 Hz)
    call beep

    mov bx, 1193180 / 220   ; A3 (220 Hz)
    call beep


    pop cx
    pop bx
    pop ax
    ret 

beep:
    push ax
    push bx

    mov al, bl
    out 0x42, al
    mov al, bh
    out 0x42, al

    in al, 0x61
    or al, 00000011b            ;turn on speaker by sending signal to port 0x61
    out 0x61, al                ;last 2 bits of keyboard controller port control speaker, so we make them 1

    mov cx, 65535               ;delay to make sound audible
    delayLoop:
        loop delayLoop
    
    in al, 0x61
    and al, 11111100b          ;turn off the speaker by turning bits of port 0x61 0
    out 0x61, al

    pop bx
    pop ax
    ret
    

playBeep:
    push ax
    push bx
    push cx


    mov al, 10110110b           ;programable interval timer using channel 2 and mode 3
    out 0x43, al               ;sent output command to port 0x43

    mov bx, 1193180 / 440 ;A            ;1193180 is base frequency, 440 is the frequency of note A, the result tells pit how fast to toggle to crerate tone
    call beep

    mov bx, 1193180 / 660 ;e5
    call beep             

    mov bx, 1193180 / 550 ;c5
    call beep    

    mov bx, 1193180 / 1175 ;d6
    call beep  

    mov bx, 1193180 / 2794 ;f7
    call beep  

    mov bx, 1193180 / 31 ;b0
    call beep 

    pop cx
    pop bx
    pop ax
    ret 

; checkKeyPressed:
;                             ; zf = 1 means no key pressed
;     mov ah, 0x00
;     int 0x16
;     cmp al, 27                      ;ascii of esc key is 27
;     je transition

;     ;otherwise jump to statr of game

;     ret

playBGMusic:
    push cx
    mov cx, 20
    play:
        call playSound
    loop play

    pop cx
    ret

START:
	

	
	
	mov ax, 0x13
	int 10h
mov ax, filename
push ax
call renderImage
;call playBGMusic
;call music
mov ax, 0x00 
int 16h
;;;;;; call difficulty selection HERE
;call clrsc
call Loading_message
call display_difficulty_screen
call difficulty_selection
pusha
call Loading_message
popa
call get_system_clock_seed
	call select_table_and_transfer
	call get_system_clock_seed
	call generate_random_board
	call get_system_clock_seed     
	call generate_random_board
	call save_to_userArr
	call save_to_user
	call set_difficulty_mode

    
	
	call Print_full_board



;call timerFunction

;mov ax, filename2
;push ax
;call renderImage
xor ax, ax
    mov es, ax

    ; Save original keyboard ISR (interrupt 09h)
    mov di, 9*4                  ; Offset for interrupt 09h
    mov ax, [es:di]              ; Save offset of original ISR
    mov [keyboardISR_Original], ax
    mov ax, [es:di+2]            ; Save segment of original ISR
    mov [keyboardISR_Original_cs], ax

    ; Save original timer ISR (interrupt 08h)
    mov di, 8*4                  ; Offset for interrupt 08h
    mov ax, [es:di]              ; Save offset of original ISR
    mov [timerISR_Original], ax
    mov ax, [es:di+2]            ; Save segment of original ISR
    mov [timerISR_Original_cs], ax
mov ax, 0
       mov es, ax
       cli
       mov word [es:9*4], keyboardISR
       mov [es:9*4+2], cs
	   mov word [es:8*4], timer_isr
			 mov [es:8*4+2], cs

       sti
	   call music
	   loopHere: 
	   cmp byte [Game_win], 0
	   jne WIN_GAME_LOOP
	   
	   jmp loopHere
	   
    jmp loopHere
	WIN_GAME_LOOP:
	xor ax, ax
    mov es, ax

    ; Restore original keyboard ISR (interrupt 09h)
    mov di, 9*4
    mov ax, [keyboardISR_Original] ; Restore original offset
    mov [es:di], ax
    mov ax, [keyboardISR_Original_cs]; Restore original segment
    mov [es:di+2], ax

    ; Restore original timer ISR (interrupt 08h)
    mov di, 8*4
    mov ax, [timerISR_Original]  ; Restore original offset
    mov [es:di], ax
    mov ax, [timerISR_Original_cs] ; Restore original segment
    mov [es:di+2], ax
	call END_GAME_ANIMATION_WON
		

;mov ax, 0x00 
;int 16h



MOV AX, 0X4C00
INT 21H

keyboardISR:
    pusha                           ; Save all registers
	
    in al, 0x60                     ; Read keyboard input from port 0x60 (keyboard data)
	CMP AL, 1H
	JNE SKIP_GAME_KA_END
	
	MOV byte [Game_win], 2
	JMP sendEOI
	
	SKIP_GAME_KA_END:
	call get_input_keyboard
    cmp al, 0x4B                     ; Left arrow key
    je moveLeft
    cmp al, 0x4D                     ; Right arrow key
    je moveRight
    cmp al, 0x48                     ; Up arrow key
    je moveUp
    cmp al, 0x50                     ; Down arrow key
    je moveDown
	
	;in al, 0x60                     ; Read keyboard input from port 0x60 (keyboard data)
    cmp al, 0x1E                     ; Left arrow key
    je mini_moveLeft
    cmp al, 0x20                     ; Right arrow key
    je mini_moveRight
    cmp al, 0x11                     ; Up arrow key
    je mini_moveUp
    cmp al, 0x1F                     ; Down arrow key
    je mini_moveDown
	cmp al, 0x39
	je flip_box_data
	cmp al, 0x2c
	jne sendEOI
	call POP_STACK


    ; If no valid key press, just return
    jmp sendEOI
flip_box_data:
push bx
push ax
	xor ax, ax
	xor bx, bx
	mov ax, 9
	mul byte [curr_row_select]
	add al, [curr_col_select]
	mov bx, ax
	cmp byte [input1+bx], 1
	je flip_box_data_end
	mov al, [bool1+bx]
	cmp al, 0
	je flip_box_data_one
	mov al, 0
	jmp flip_box_data_end
	flip_box_data_one:
	mov al, 1
	flip_box_data_end:
	mov [bool1+bx], al
	;not byte [bool1+bx]
	pop ax
	pop bx
	call Print_full_board
	jmp sendEOI
moveLeft:
	cmp word [curr_col_select], 0
	je sendEOI
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
    sub word [rectX], 40                 ; Move rectangle left (decrease X)
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
    call RectangleBorder             ; Redraw the rectangle
	dec word [curr_col_select]
    jmp sendEOI

moveRight:
	cmp word [curr_col_select], 8
	je sendEOI
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
    add word [rectX], 40   	; Move rectangle right (increase X)
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
    call RectangleBorder             ; Redraw the rectangle
	inc word [curr_col_select]
    jmp sendEOI

moveUp:
	cmp word [curr_row_select], 0
	je sendEOI
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
    sub word [rectY], 40                 ; Move rectangle up (decrease Y)
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
    call RectangleBorder             ; Redraw the rectangle
	dec word [curr_row_select]
    jmp sendEOI

moveDown:
	cmp word [curr_row_select], 8
	je sendEOI
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
    add word [rectY], 40                 ; Move rectangle down (increase Y)
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
    call RectangleBorder             ; Redraw the rectangle
	inc word [curr_row_select]
    jmp sendEOI
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mini_moveLeft:
	
	call check_if_notes_while_moving_square
	cmp ax, 1
	je sendEOI
	
	cmp word [mini_curr_col_select], 0
	je sendEOI
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	
    sub word [calc_rectX], 10                 ; Move rectangle left (decrease X)
	mov ax, [rectX]
	add ax, [calc_rectX]
	mov [mini_rectX], ax
	mov ax, [rectY]
	add ax, [calc_rectY]
	mov [mini_rectY], ax
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
    call RectangleBorder             ; Redraw the rectangle
	dec word [mini_curr_col_select]
    jmp sendEOI

mini_moveRight:
	
	call check_if_notes_while_moving_square
	cmp ax, 1
	je sendEOI
	
	cmp word [mini_curr_col_select], 2
	je sendEOI
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	
    add word [calc_rectX], 10   	; Move rectangle right (increase X)
	mov ax, [rectX]
	add ax, [calc_rectX]
	mov [mini_rectX], ax
	mov ax, [rectY]
	add ax, [calc_rectY]
	mov [mini_rectY], ax
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
    call RectangleBorder             ; Redraw the rectangle
	inc word [mini_curr_col_select]
    jmp sendEOI

mini_moveUp:

	call check_if_notes_while_moving_square
	cmp ax, 1
	je sendEOI
	
	cmp word [mini_curr_row_select], 0
	je sendEOI
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	
	
    sub word [calc_rectY], 10                 ; Move rectangle up (decrease Y)
	mov ax, [rectX]
	add ax, [calc_rectX]
	mov [mini_rectX], ax
	mov ax, [rectY]
	add ax, [calc_rectY]
	mov [mini_rectY], ax
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
    call RectangleBorder             ; Redraw the rectangle
	dec word [mini_curr_row_select]
    jmp sendEOI

mini_moveDown:

	call check_if_notes_while_moving_square
	cmp ax, 1
	je sendEOI
	
	cmp word [mini_curr_row_select], 2
	je sendEOI
	push word [width]
	push word [height]
	push word [rectX]
	push word [rectY]
	call RectangleBorder_rem
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
	call RectangleBorder_rem
	
    add word [calc_rectY], 10              ; Move rectangle down (increase Y)
	mov ax, [rectX]
	add ax, [calc_rectX]
	mov [mini_rectX], ax
	mov ax, [rectY]
	add ax, [calc_rectY]
	mov [mini_rectY], ax
	push word [mini_width]
	push word [mini_height]
	push word [mini_rectX]
	push word [mini_rectY]
    call RectangleBorder             ; Redraw the rectangle
	inc word [mini_curr_row_select]
    jmp sendEOI


sendEOI:
    ; Send EOI to PIC to acknowledge the interrupt
    mov al, 0x20
    out 0x20, al

    popa                            ; Restore registers
    iret                            ; Return from interrupt
	
check_if_notes_while_moving_square:
	push BP
	mov bp, sp
	PUSH bx
	
	mov ax, 9
	mul byte [curr_row_select]
	add ax, [curr_col_select]
	xor bx, bx
	
	mov bx, ax
	xor ax, ax
	mov ax, 0
	
	cmp byte [bool1+bx], 0
	je skip_mini_square_for_notes
	mov ax, 1
	
	skip_mini_square_for_notes:
	
	POP bx
	pop BP
	ret
	
Print_full_board:
pusha
	call Show_Correct_numbers
	mov ax, 0x12
    int 0x10
	call set_video_mode

PUSH 360
PUSH 140 ; x
PUSH 70 ; y
CALL drawHorizontal

PUSH 360
PUSH 140
PUSH 70
CALL DRAWVERTICAL

push 140
push 70
call PrintValues


call printMistakes

;call printTime

call PrintScore
call SetCursorAndPrintcorrects

;push 140
;push 435
;call PrintAvailableNumbers


push 60 ;width
push 20 ;height
push 520; x
push 140 ;y
call RectangleBorder

call PrintUndo


push 60 ;width
push 20 ;height
push 520; x
push 204 ;y
call RectangleBorder

call PrintHint

push 60 ;width
push 20 ;height
push 520; x
push 268 ;y
call RectangleBorder

call PrintPencil
call printTime

push 60 ;width
push 20 ;height
push 520; x
push 332 ;y
call RectangleBorder


;push 10 ;width
;push 10 ;height
;push 145+80-1; x
;push 75-1 ;y
;call RectangleBorder

call PrintErase
mov cl, [mistakes_done]
cmp cl, [allowed_mistakes]
jnae STOP_GAME_OVER
mov byte [Game_win], 2
mov byte [music_length], 1


STOP_GAME_OVER:

POPA
ret

get_input_keyboard:
pusha
cmp al, 0x02
jl EO_get_input_from_keyboard
cmp al, 0x0A
jg EO_get_input_from_keyboard

sub al, 1
mov [input_data], al
xor ax,ax
mov ax, 9
mul byte [curr_row_select]
add ax, [curr_col_select]
mov bx, Ax
cmp byte [input1+bx], 1
je EO_get_input_from_keyboard
call check_if_notes_while_moving_square
cmp ax, 0
jne skip_notes_input
call inputDataToNotes
call Print_full_board
jmp EO_get_input_from_keyboard
skip_notes_input:
mov al, [userArr+bx]

mov [curr_val_select], al
call PUSH_STACK


mov al, [input_data]
cmp al, [user+bx]
jne add_mistakes
mov byte [input1+bx], 1


jmp skip_add_mistakes
add_mistakes:
add byte [mistakes_done], 1
skip_add_mistakes:
;mov al, 1
mov [userArr+bx], al




;; code for my task
call Print_full_board
EO_get_input_from_keyboard:

popa
ret

inputDataToNotes:
pusha
mov ax, 9
mul byte [curr_row_select]
add ax, [curr_col_select]
shl ax, 1 
mov bx, ax
mov si, [ArrayTable+bx]
mov bx, SI
mov ax, 3
mul byte [mini_curr_row_select]
add ax, [mini_curr_col_select]
mov si, ax
mov al, [input_data]
mov [bx+si], al


popa
ret

get_system_clock_seed:
    push ax            ; Save registers
    push dx
    push es
	push bx
	

    mov ax, 0x0040     ; Load BIOS Data Area segment
    mov es, ax         ; Set ES to point to the BDA
    mov bx, 0x006C     ; Offset of clock ticks
    mov ax, word [es:bx] ; Get the lower 16 bits of clock ticks
	
	mov [seed], ax
	call random_delay
	pop bx
    pop es             ; Restore registers
    pop dx
    pop ax

    ret                ; Return with AX containing the seed
	
generate_random_pos:
    ; Generate a random number between 1 and 81
	push cx
    ;call get_system_clock_seed     ; Update seed
    mov ax, [seed]                 ; Load current seed
    mov cx, 3                     ; Set modulus (number of cells)
    xor dx, dx                     ; Clear DX
    div cx                         ; DX:AX / CX, remainder in DX
    mov ax, dx                     ; Move remainder to AX
	pop cx
    ret                            ; Return random position in AX
	
	
generate_random_rem_pos:
    ; Generate a random number between 1 and 81
	push cx
    call get_system_clock_seed     ; Update seed
    mov ax, [seed]                 ; Load current seed
    mov cx, 81                     ; Set modulus (number of cells)
    xor dx, dx                     ; Clear DX
    div cx                         ; DX:AX / CX, remainder in DX
	
    mov ax, dx                     ; Move remainder to AX
	
	pop cx
    ret 
	
generate_random_board:
	pusha 
	mov cx, 2
	generate_random_board_loop1:

	call generate_random_pos
	;cmp cx, AX
	;je generate_random_board_loop1
	mov bx, AX
	shl bx, 1
	mov si, [userArrTable+bx]
	mov bx, cx
	shl bx, 1
	mov di, [userArrTable+bx]
	mov [userArrTable+bx], SI
	mov bx, AX
	shl bx, 1
	mov [userArrTable+bx], di
	dec cx
	cmp cx, 0
	jne generate_random_board_loop1
	
	
	mov cx, 2
	generate_random_board_loop2:

	call generate_random_pos
	;cmp cx, AX
	;je generate_random_board_loop2
	mov bx, AX
	shl bx, 1
	mov si, [userArrTable+bx+6]
	mov bx, cx
	shl bx, 1
	mov di, [userArrTable+bx+6]
	mov [userArrTable+bx+6], SI
	mov bx, AX
	shl bx, 1
	mov [userArrTable+bx+6], di
	dec cx
	cmp cx, 0
	jne generate_random_board_loop2
	
	mov cx, 2
	generate_random_board_loop3:
	
	call generate_random_pos
	;cmp cx, AX
	;je generate_random_board_loop3
	mov bx, AX
	shl bx, 1
	mov si, [userArrTable+bx+12]
	mov bx, cx
	shl bx, 1
	mov di, [userArrTable+bx+12]
	mov [userArrTable+bx+12], SI
	mov bx, AX
	shl bx, 1
	mov [userArrTable+bx+12], di
	dec cx
	cmp cx, 0
	jne generate_random_board_loop3
	
	popa
	ret
	
save_to_userArr:
PUSHA
mov cx, 0
mov bx, 0
mov si, 0
save_to_userArr_loop_o:
mov cx, 0
mov di, 0
save_to_userArr_loop_i:
mov di, [userArrTable+bx]
add di, cX
mov al, [di]
mov [userArr+si], al
inc cx
inc si
cmp cx, 9
jne save_to_userArr_loop_i
add bx, 2
cmp bx, 18
jne save_to_userArr_loop_o
popa
ret



save_to_user:
pusha
mov cx, 81
mov si, 0
xor ax,ax
save_to_user_loop:
mov al, [userArr+si]
mov [user+si], AL
inc si
dec cx
jnz save_to_user_loop
popa
ret




random_box_remover:
    pusha

    mov byte [removed_count], 0   ; Initialize removal counter
    mov cx, 0                    ; Max cells to remove (target)

    mov bx, 40                   ; Set target for removed cells
    mov cx, bx

remove_loop:
    call generate_random_rem_pos      ; Generate a random position (1-81)
    mov si, ax                    ; Store the random position in SI

    ; Check if the cell is already removed
    mov al, [userArr + si]        ; Load value from the random cell
    cmp al, 0                     ; Is the cell already removed?
    je remove_loop                ; If yes, skip this iteration
	
	mov al, [userArr + si+1]        ; Load value from the random cell
    cmp al, 0                     ; Is the cell already removed?
    je remove_loop                ; If yes, skip this iteration
	
	mov al, [userArr + si-1]        ; Load value from the random cell
    cmp al, 0                     ; Is the cell already removed?
    je remove_loop                ; If yes, skip this iteration
	
    ; Remove the cell
    mov byte [userArr + si], 0    ; Set cell to 0
	mov byte [bool1+si], 0
	mov byte [input1+si], 0
    inc byte [removed_count]      ; Increment removed count

    ; Check if we've removed enough cells
    cmp byte [removed_count], 5
    je done_removal               ; Exit when target is reached

    jmp remove_loop               ; Continue removing cells

done_removal:

    popa
    ret
	
random_box_remover_r:
    pusha
    mov byte [removed_count], 0   ; Initialize removal counter
    mov cx, 0                    ; Max cells to remove (target)

    mov bx, 40                   ; Set target for removed cells
    mov cx, bx
remove_loop_r:
    call generate_random_rem_pos      ; Generate a random position (1-81)
    mov si, ax                    ; Store the random position in SI

    ; Check if the cell is already removed
    mov al, [userArr + si]        ; Load value from the random cell
    cmp al, 0                     ; Is the cell already removed?
    je remove_loop_r                ; If yes, skip this iteration
	
	;mov al, [userArr + si+1]        ; Load value from the random cell
    ;cmp al, 0                     ; Is the cell already removed?
    ;je remove_loop_r                ; If yes, skip this iteration
	
	;mov al, [userArr + si-1]        ; Load value from the random cell
    ;cmp al, 0                     ; Is the cell already removed?
    ;je remove_loop_r               ; If yes, skip this iteration
	
    ; Remove the cell
    mov byte [userArr + si], 0    ; Set cell to 0
	mov byte [bool1+si], 0
	mov byte [input1+si], 0
    inc byte [removed_count]      ; Increment removed count

    ; Check if we've removed enough cells
    cmp byte [removed_count], 5
    je done_removal_r               ; Exit when target is reached

    jmp remove_loop_r               ; Continue removing cells

done_removal_r:
    popa
    ret
random_delay:
    push ax
    mov cx, 0FFFFh        ; Arbitrary delay count
delay_loop:
    nop
    loop delay_loop
    pop ax
    ret
	
Show_Correct_numbers:
pusha
mov cx, 81
mov si, 0
xor bx, bx
Show_Correct_numbers_loop:
mov al, [userArr+si]
cmp al, [user+si]
jne Show_Correct_numbers_skip
;cmp byte [input1+si], 0
;jne Show_Correct_numbers_skip
inc bl
Show_Correct_numbers_skip:

add si, 1
dec CX
jnz Show_Correct_numbers_loop
;dec bl
sub bl, [sub_val]
mov [corrects], bl
cmp bl, [Score_req]
jne skip_win_game_set
mov byte [Game_win], 1
mov byte [music_length], 1
skip_win_game_set:

popa
ret




SetCursorAndPrintcorrects:
    pusha                       ; Save all register

	mov dx, 0
	mov ax, [corrects]
	mov bx,	10
	div bx
	add dl, '0'
	push dx
	mov dx, 0
	div bx
	add dx, '0'
	push dx
	
	
	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 42
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh

	;PrintScoreLoop:
	;	mov al, [Score + si]
	;	int 10h
	;	inc si
	;	cmp si, [LengthOfScore]
	;	jne PrintScoreLoop
	
	pop cx
	mov al, cl
	int 10h
	sub dl, 2
	pop cx
	mov al, cl
	int 10h
	popa
	ret

popa
ret

select_table_and_transfer:
pusha
call generate_random_select
mov bx, 0
mov cx, 81
mov si, 0
cmp al, 0
je select_table_and_transfer_loop
add bx, 81
cmp al, 1
je select_table_and_transfer_loop
add bx, 81
cmp al, 2
je select_table_and_transfer_loop
add bx, 81

select_table_and_transfer_loop:
mov al, [table1+bx]
mov [user+si], AL
inc si
inc bx
dec cx
jnz select_table_and_transfer_loop

popa
ret
generate_random_select:
    ; Generate a random number between 1 and 81
	push cx
    call get_system_clock_seed     ; Update seed
    mov ax, [seed]                 ; Load current seed
    mov cx, 4                     ; Set modulus (number of cells)
    xor dx, dx                     ; Clear DX
    div cx                         ; DX:AX / CX, remainder in DX
	
    mov ax, dx                     ; Move remainder to AX
	
	pop cx
    ret 
	
	
easy_removes:
pusha
call get_system_clock_seed
	call random_box_remover
	call random_box_remover
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover
	call random_box_remover
	call random_box_remover
	mov byte [Score_req], 40
	mov byte [allowed_mistakes], 9
	mov byte [mistakes_done], 0
	mov byte [sub_val], 41

popa
ret

medium_removes:
pusha
call get_system_clock_seed
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover
	mov byte [Score_req], 30
	mov byte [allowed_mistakes], 5
	mov byte [mistakes_done], 0
	mov byte [sub_val], 31


popa
ret

hard_removes:
pusha
call get_system_clock_seed
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover
	call random_box_remover_r
	call random_box_remover_r
	call random_box_remover_r
	mov byte [Score_req], 20
	mov byte [allowed_mistakes], 3
	mov byte [mistakes_done], 0
	mov byte [sub_val], 21

popa
ret
display_difficulty_screen:
    pusha
	
	mov ah, 0x02         ; Set cursor position
    mov bh, 0x00         ; Page number
    mov dh, 10         ; Row
    mov dl, 20           ; Column
    int 0x10
    mov ah, 0x0E
    mov si, Welcome_message
    call print_string
    ; Print "EASY"
	
    mov ah, 0x02         ; Set cursor position
    mov bh, 0x00         ; Page number
    mov dh, 12           ; Row
    mov dl, 36           ; Column
    int 0x10
    mov ah, 0x0E
    mov si, easy_msg
    call print_string
	
	

    ; Print "MEDIUM"
	mov ah, 0x02
    mov dh, 14           ; Row
    mov dl, 36           ; Column
    int 0x10
	mov ah, 0x0e
    mov si, medium_msg
    call print_string

    ; Print "HARD"
	mov ah, 0x02
    mov dh, 16           ; Row
    mov dl, 36           ; Column
    int 0x10
	mov ah, 0x0e
    mov si, hard_msg
    call print_string
    popa
    ret

; Handle difficulty selection
difficulty_selection:
    mov ah, 0x00         ; Wait for key press
    int 0x16
    cmp al, '1'          ; Check if '0' is pressed
    je set_easy_mode
    cmp al, '2'          ; Check if '1' is pressed
    je set_medium_mode
    cmp al, '3'          ; Check if '2' is pressed
    je set_hard_mode
    jmp difficulty_selection ; Repeat if invalid key

set_easy_mode:
    mov byte [diff_mode], 0
    ret

set_medium_mode:
    mov byte [diff_mode], 1
    ret

set_hard_mode:
    mov byte [diff_mode], 2
    ret

; Print a null-terminated string
print_string:
    pusha
.print_loop:
    lodsb                ; Load next character
    or al, al            ; Check for null terminator
    jz .done
    int 0x10             ; Print character
    jmp .print_loop
.done:
    popa
    ret
set_difficulty_mode:
pusha
cmp byte [diff_mode], 0
je set_difficulty_mode1
cmp byte [diff_mode], 1
je set_difficulty_mode2
cmp byte [diff_mode], 2
je set_difficulty_mode3
set_difficulty_mode1:
call easy_removes
jmp EO_set_difficulty_mode
set_difficulty_mode2:
call medium_removes
jmp EO_set_difficulty_mode
set_difficulty_mode3:
call hard_removes
jmp EO_set_difficulty_mode
EO_set_difficulty_mode:
popa
ret



SetCursorAndPrintMistakes:
    pusha                       ; Save all register
	xor ax, ax
	mov dx, 0
	mov ax, [mistakes_done]
	mov bx,	10
	div bx
	add dl, '0'
	push dx
	
	
	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 60
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh
	
	pop cx
	mov al, cl
	int 10h
	sub dl, 2
	popa
	ret

	
	
SetCursorAndPrintMistakesAllowed:
    pusha                       ; Save all register
	xor ax, ax
	mov dx, 0
	mov ax, [allowed_mistakes]
	mov bx,	10
	div bx
	add dl, '0'
	push dx
	
	
	mov ah, 02h   ;setting cursor position
	mov bh, 0
	mov dl, 62
	mov dh, 3
	int 10h

	mov si, 0
	mov bh, 0
	mov bl, 0x0f
	mov ah, 0eh
	
	pop cx
	mov al, cl
	int 10h
	sub dl, 2
	popa
	ret
	
	END_GAME_ANIMATION_WON:
	pusha
	mov si, 0  ;Y
	mov di, 0  ;X
	END_GAME_ANIMATION_WON_O:
	mov di, 0
	END_GAME_ANIMATION_WON_I:
	call print_SMILEYS
	add di, 32
	cmp di, 640
	jb END_GAME_ANIMATION_WON_I
	add si, 16
	cmp si, 480
	jb END_GAME_ANIMATION_WON_O
	mov di, 112
	mov si, 232
	mov cx, 14
	mov ax, 11
	END_GAME_ANIMATION_WON_A:
	push si
	push DI
	push aX
	call PRINT_black_sq
	add si, 16
	push si
	sub si, 32
	push DI
	push aX
	call PRINT_black_sq
	push si
	push DI
	push aX
	call PRINT_black_sq
	add si, 16
	
	call delay_animation
	add di, 32
	dec cX
	jnz END_GAME_ANIMATION_WON_A
	
	cmp byte [Game_win], 1
	je WIN_GAME_ANIMATION
	call LOSE_DISPLAY
	jmp EO_WIN_GAME_ANIMATION
	WIN_GAME_ANIMATION:
	call WIN_DISPLAY
	
	
	
	
	EO_WIN_GAME_ANIMATION:
	popa 
	ret
	
print_SMILEYS:
PUSHA
mov bx, 11
	push si
	push di
	push bx
	call PRINT_black_sq
	
	
	
	inc bx
	push 0
	push si
	push di
	push bx
	call PRINT32X16
popa
ret




PRINT_black_sq:
	PUSH BP
	MOV BP, SP
	PUSHA
	
	;calculating the address of the bitmap of the number to be printed
	mov ax, [bp+4]
	dec ax
	mov dx, 64
	mul DX
	mov di, ax
	ADD DI, big1
	
	
	
	MOV CX,511 ;OUTER COUNT FOR THE TRAVERSAL OF ARRAY
	MOV DX, 0 ;DL IS USED TO INCREMENT THE VALYE OF Y AND DH IS USED TO FETCH THE NEXT BYTE FOR PRINTINTG
	mov ax, [bp+6] ;value of pixel x of printitng
	mov bx, [bp+8] ; value of the pixel y
	add bx, 8;for the adjustment of printing in the centre of the box
	MOV SI, [DI]
	shl si, 8 ;WTF IS THIS FOR
prntLP_black_sq:

	INC DL
	CMP DL, 32; 
JNZ Not_Inc_Row_black_sq ;INCREMENTING THE VALUE OF Y HERE AND PLACE THE X BACK TO ZERO AND ADDING DI SO THAT IT  POINTS TO THE NEXT ROW
	MOV DL, 0
	INC BX
	SUB AX, 32
	; ADD DI, 1
	; Mov si, [di]
	; shl si, 8
Not_Inc_Row_black_sq:
	INC DH
	CMP DH, 8
	jne NOT_RESET_black_sq
	xor dh, DH
	inc DI
	mov si, [di]
	shl si, 8

NOT_RESET_black_sq:
	

	INC ax
	shl si, 1
	jnc Not_SetPixel_black_sq
	;BEOFRE THE NEXT 3 LINES, WE WILL CHECK WHETHER THE VALUE OF THE ARRAY IS 1
	PUSH bx ;X
	PUSH ax ;Y
	CALL setPixelOrg

Not_SetPixel_black_sq:
	
	loop prntLP_black_sq

POPA
POP BP
RET 6

delay_animation:
	push ax
	push cx
	push dx

	mov cx, 0h
	mov ah, 86h
	mov dx, 1h
	int 15h

	pop dx
	pop cx
	pop ax
	ret
	
	
Loading_message:
pusha
mov ah, 0x00
    mov al, 0x13
    int 0x10

    lea si, Loadinga
    mov cx, 300
    mov dx, 300
    call print_message_game
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep
	call sleep



    mov ah, 0x00
    mov al, 0x03
    int 0x10
	popa
	ret

print_message_game:
    pusha
.next_char_game:
    lodsb
    cmp al, 0
    je .done
    call print_char_game
    add cx, 10
    jmp .next_char_game
.done:
    popa
    ret

print_char_game:
    pusha
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x0F
    mov al, [si-1]
    int 0x10
    popa
    ret
	
	
	sleep:
    mov ah, 86h      ; BIOS wait function
    xor cx, cx       ; Set CX = 0 (high word of delay)
    mov dx, 0xffff   ; Set DX = 1000 (low word of delay) for 1 second (1000 ms)
    int 15h          ; Call BIOS interrupt
    ret
	
	
	WIN_DISPLAY:
	
	mov di, 150
	mov si, 232
	
	push 0
	push si
	push DI
	push 13
	call PRINT32X16
	add di, 45
	push 0
	push si
	push DI
	push 14
	call PRINT32X16
	add di, 45
	push 0
	push si
	push DI
	push 15
	call PRINT32X16
	add di, 45
	
	push 0
	push si
	push DI
	push 16
	call PRINT32X16
	add di, 45
	
	push si
	push DI
	push 12
	call PRINT_black_sq
	add di, 45
	
	push 0
	push si
	push DI
	push 19
	call PRINT32X16
	add di, 45
	
	push 0
	push si
	push DI
	push 20
	call PRINT32X16
	add di, 45
	
	push 0
	push si
	push DI
	push 17
	call PRINT32X16
	add di, 45
	ret
	
	
	
	LOSE_DISPLAY:
	mov di, 150
	mov si, 232
	
	push 1
	push si
	push DI
	push 13
	call PRINT32X16
	add di, 45
	push 1
	push si
	push DI
	push 14
	call PRINT32X16
	add di, 45
	push 1
	push si
	push DI
	push 15
	call PRINT32X16
	add di, 45
	
	push 1
	push si
	push DI
	push 16
	call PRINT32X16
	add di, 45
	
	push si
	push DI
	push 12
	call PRINT_black_sq
	add di, 45
	
	push 1
	push si
	push DI
	push 16
	call PRINT32X16
	add di, 45
	
	push 1
	push si
	push DI
	push 17
	call PRINT32X16
	add di, 45
	
	push 1
	push si
	push DI
	push 18
	call PRINT32X16
	add di, 45
	

	ret
	
	music:
		push si
		push dx
		push ax
		push bx
		push cx
		mov si, 200
	.next_note:
		cmp byte [Game_win], 0
		jne MUSIC_BAND
		mov dx, 388h
		mov al, [si + music_data + 0]
		out dx, al
		mov dx, 389h
		mov al, [si + music_data + 1]
		out dx, al
		mov bx, [si + music_data + 2]
		add si, 4
	.repeat_delay:
		mov cx, 610
	.delay:
		mov ah, 1
		int 16h
		jnz st
		loop .delay
		cmp byte [Game_win], 0
		jne MUSIC_BAND
		dec bx
		
		jg .repeat_delay
		cmp byte [Game_win], 0
		jne MUSIC_BAND
		cmp si, [music_length]
		jb .next_note
	st:
	MUSIC_BAND:
		mov dx, 388h
		mov al, 0xff
		out dx, al
		mov dx, 389h
		mov al, 0xff
		out dx, al
		mov bx, 0
		pop cx
		pop bx
		pop ax
		pop dx
		pop si
ret

clrsc:
pusha
xor di, di
xor si, si
mov al, 0

clrsc_loop_o:
mov di, 0

clrsc_loop_i:
push SI
push di
push 12
call PRINT_black_sq
add di, 32
cmp di, 640
jb clrsc_loop_i
add si, 16
cmp si, 480
jb clrsc_loop_o


popa
ret
	
	
	
	
	


	


	
	
	


	

