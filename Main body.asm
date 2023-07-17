#Main body of the project
row1 equ P3.0
row2 equ P3.1
row3 equ P3.2
row4 equ P3.3

col1 equ P3.4
col2 equ P3.5
col3 equ P3.6
col4 equ P3.7

RS equ P2.0 
E  equ P2.1

_32 equ 1
_16 equ 2
_8 equ 4
_4 equ 8
_2 equ 16
_1 equ 32


bien_lap equ 40h
hieu_chinh_truong_do equ 41h
bien_truong_do equ 42h		;bien truong do
bien_lang  equ 43h  	;bien lang
;mov bien_truong_do,#01h
;mov bien_lang,#01h

clr P2.3
mov 35h, #0D
mov 50h, #3Ah  
mov 60h, #0D
mov 65h, #0D
mov 75h, #0D
acall LCD_init
lcall password
menu_selection:
	acall option
	acall clr_screen
	menu:
	mov P3, #11111111B
	clr col4
	Jnb row1, enter_pass
	jnb row2, change_pass
	jnb row3, Sound_mode
	acall delay10ms
	setb col4
	jmp menu
option: 
    MOV DPTR ,#home
	home1: 
		MOV A,#00H   
		MOVC A,@A+DPTR    
		JZ home2      
		ACALL LCD_data    
		INC DPTR    
		SJMP home1 
	home2:
		jmp menu
change_pass:
	acall change
sound_mode:
	acall music
//==========================================================option1=============================================================
enter_pass:
	acall clr_screen
	mov P1, #11111111B
	MOV DPTR ,#option1
	REV: MOV A,#00H   
	MOVC A,@A+DPTR    
	JZ FINISH      
	ACALL LCD_data    
	INC DPTR    
	SJMP REV    
FINISH: 
	acall line2           ;Thanh ghi 50h co gia tri 3A

PASS1:
	clr A
	clr col1
	jnb row1, display_7_1
	jnb row2, display_4_1
	jnb row3, display_1_1
	jnb row4, display_enter_enter
	acall delay10ms
	setb col1
	clr col2
	jnb row1, display_8_1
	jnb row2, display_5_1
	jnb row3, display_2_1
	jnb row4, display_0_1
	acall delay10ms
	setb col2
	clr col3
	jnb row1, display_9_1
	jnb row2, display_6_1
	jnb row3, display_3_1
	jnb row4, check_pass2
	acall delay10ms
	setb col3
	clr col4
	jnb row4, menu_1
	acall delay10ms
	setb col4
jmp PASS1

check_pass2:
	acall  check_pass22
menu_1:
	acall clr_screen
	jmp menu_selection	

 display_enter_enter:
	clr col1
	jnb row4, display_enter
	acall delay10ms
	setb col1

	clr col3
	jnb row4, check_pass222
	acall delay100us
	setb col3
	jmp display_enter_enter

 check_pass222:
 	clr 65h
 	acall check_pass22		
	display_enter:
		CLR 60H
		acall check_pass1

	display_0_1:
		acall display_0
	display_1_1:
		acall display_1
	display_2_1:
		acall display_2
	display_3_1:
		acall display_3
	display_4_1:
		acall display_4
	display_5_1:
		acall display_5
	display_6_1:
		acall display_6
	display_7_1:
		acall display_7
   	display_8_1:
		acall display_8
	display_9_1:
		acall display_9
 PASS_letter0_3:
 	jmp PASS1
//=========================================================keypad_setting============================================================
	display_0:	
		lcall display_sao
		acall delay100us
		mov R1, 50h			
		mov @R1, #0h			
		inc 50h
		jnb row4, $
		acall delay100us
		inc 65h 
		mov A, 65h
		cjne A, #4, PASS_letter0_3			
		jnb row4, $
		jmp display_enter_enter
		clr A
		ret
	display_1:
		lcall display_sao
		mov R1, 50h			
		mov @R1, #1h			
		inc 50h
		jnb row3, $ 
		acall delay100us
		inc 65h			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row3, $
		jmp display_enter_enter
		ret
	display_2:
		lcall display_sao
		mov R1, 50h
		mov @R1, #2h
		inc 50h
		jnb row3, $
		acall delay100us
		inc 65h
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row3	, $
		jmp display_enter_enter
		ret
	display_3:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#3h			
		inc 50h
		jnb row3, $ 
		acall delay100us
		inc 65h			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row3, $
		jmp display_enter_enter
		ret
	display_4:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#4h			
		inc 50h 
		jnb row2, $
		acall delay100us
		inc 65h			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row2, $
		jmp display_enter_enter
		ret
	option_1_11:
		ljmp PASS1
	display_5:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#5h			
		inc 50h 
		jnb row2, $
		acall delay100us
		inc 65h			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row2, $
		jmp display_enter_enter
		ret
	display_6:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#6h			
		inc 50h
		jnb row2, $
		acall delay100us
		inc 65h 			
		mov A, 65h
		cjne A, #4,option_1_11			
		jnb row2, $
		jmp display_enter_enter
		ret
	display_7:
		lcall display_sao
		mov R1, 50h				; dua gia tri cua thanh ghi 50h vao thanh ghi R1		     
		mov @R1,#7h				; dua gia tri 7 vao thanh ghi co dia chi bang gia tri R1	  
		inc 50h 
		jnb row1, $
		inc 65h					; Tang gia tri thanh ghi 50h len 1
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row1, $
		jmp display_enter_enter
		ret
	display_8:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#8h			
		inc 50h
		jnb row1, $ 
		inc 65h			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row1, $
		jmp display_enter_enter
		ret
	display_9:
		lcall display_sao
		mov R1, 50h			
		mov @R1,#9h			
		inc 50h
		jnb row1, $
		inc 65h 			
		mov A, 65h
		cjne A, #4, option_1_11			
		jnb row1, $
		jmp display_enter_enter
		ret
		
			
 //==============================================================option_1_bonus=======================================================
check_pass1:
	check_check:
		clr 50h
		clr 3Ah
		mov 50h, #3Ah
		mov R1, 50h
		pass:
		clr A
		mov A, @R1		    ; lap 4 lan
		acall check_letter1			  


FAIL1:
	 	acall clr_screen
		MOV DPTR ,#fail
		REV3: 
			MOV A,#00H   
			MOVC A,@A+DPTR    
			JZ FINISH2      
			ACALL LCD_data    
			INC DPTR   
			SJMP REV3
		FINISH2:
		mov 65h, #0
		acall delay10ms
		clr A
		#include <warning.asm>
		inc 60h
		mov A, 60h
		cjne A , #3D , enter_pass_2
		acall clr_screen
		MOV DPTR , #delay_50s_string
		REV6: 
			MOV A,#00H   
			MOVC A,@A+DPTR    
			JZ FINISH6      
			ACALL LCD_data    
			INC DPTR   
			SJMP REV6
		FINISH6:

		acall delay_10s
		acall delay_10s
		acall delay_10s
		acall delay_10s
		acall delay_10s
		acall clr_screen

		lcall password
		mov 60h, #0h
		clr A
		jmp menu_selection
		ret

enter_pass_2:
		acall enter_pass	
success:	
	acall clr_screen
    	MOV DPTR , #sucess
	success1:
		MOV A,#00H   
		MOVC A,@A+DPTR    
		JZ FINISH3      
		ACALL LCD_data    
		INC DPTR    
		SJMP success1 
	FINISH3:
	setb P2.3
	mov 65h, #0
	acall delay10ms
	acall clr_screen
	mov 60h, #0D
	clr A
	acall delay0_1s
	clr P2.3
	jmp menu_selection

check_letter1: 
	cjne A,30h, FAIL1
	jmp check_letter2
check_letter2:
	clr A
	inc R1
	mov A, @R1 
	cjne A,31h, FAIL1
	jmp check_letter3
check_letter3:	
	clr A
	inc R1
	mov A, @R1 
	cjne A,32h, faifai
	jmp check_letter4
check_letter4:	
	clr A
	inc R1
	mov A, @R1 
	cjne A,33h, faifai
	clr A
	mov R1, #0h
	jmp success

faifai:
	lcall FAIL1
//==============================================option2================================================

change:
	clr 50h
	acall clr_screen
	MOV DPTR ,#option2
	option_2: 
		MOV A,#00H   
		MOVC A,@A+DPTR    
		JZ DONE      
		ACALL LCD_data    
		INC DPTR    
		SJMP option_2    
DONE:
acall delay10ms

	old_pass:
		acall clr_screen
		mov dptr, #oldpass
		oldpass1:
			mov A, #00H
			movc A, @A + dptr
			jz DONE1
			acall LCD_data
			inc dptr
			sjmp oldpass1
		DONE1:
acall line2
mov 50h, #3Ah 
jmp PASS1
		
check_pass22:
	mov R0, #4D				   ;lap 4 lan
	mov R1, #3Ah
	pass2:
		clr A
		mov A, @R1
		acall check_letter
		inc R1
		djnz R0, check_pass22			   ; lap 4 lan
		;jmp menu_selection	


check_letter: 
	cjne A,30h, FAIL2
	jmp check_letter22
check_letter22:
	inc R1
	clr A
	mov A, @R1 
	cjne A,31h, FAIL2
	jmp check_letter32
check_letter32:
	inc R1
	clr A
	mov A, @R1 
	cjne A,32h, FAIL2
	jmp check_letter42
check_letter42:
	inc R1
	clr A
	mov A, @R1 
	cjne A,33h, FAIL2
	ljmp new_pass

FAIL2:
		acall clr_screen
		MOV DPTR ,#fail22
		REV4: 
			MOV  A,#00H   
			MOVC A,@A+DPTR    
			JZ DONE3      
			ACALL LCD_data    
			INC DPTR   
			SJMP REV4
		DONE3:
		clr A
		acall clr_screen
		jmp menu_selection

//=======================================================================================================
new_pass:
	newpass:
		acall clr_screen
		mov dptr, #newpass_string
		newpass1: 
			mov A, #00H
			movc A, @A + dptr
			jz DONE2
			acall LCD_data
			inc dptr
			sjmp newpass1
		DONE2:
	acall line2
	mov 70h, #4Ah
	sjmp newpass2				

newpass2:
	call newpass22	

newpass222:
	clr A
	clr col1
	jnb row1, newpass_7 
	jnb row2, newpass_4 
	jnb row3, newpass_1
	;jnb row4, display_enter
	acall delay10ms
	setb col1

	clr col2
	jnb row1, newpass_8
	jnb row2, newpass_5
	jnb row3, newpass_2
	jnb row4, newpass_0
	acall delay10ms
	setb col2

	clr col3
	jnb row1, newpass_9
	jnb row2, newpass_6
	jnb row3, newpass_3
	jnb row4, pass_changed
	acall delay10ms

	setb col3

	clr col4
	jnb row4, menu_3
	setb col4
	jmp newpass22
	acall line2
	
menu_3:
	acall clr_screen
	jmp menu_selection	
pass_changed:
	acall change_pass1
newpass_4:
	acall newpass_41
newpass_5:
	acall newpass_51
newpass_6:
	acall newpass_61
newpass_7:
	acall newpass_71
newpass_8:
	acall newpass_81
newpass_9:	
	acall newpass_91
newpass_0:
	     lcall display_sao
		mov  R1, 70h			
		mov @R1, #0h			
		inc 70h
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22		
		acall delay100us
		jmp option_2_11
newpass_1:
		lcall display_sao
		mov  R1, 70h			
		mov @R1, #1h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22		
		acall delay100us
		jmp option_2_11
newpass_2:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #2h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11
newpass_3:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #3h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11
newpass_41:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #4h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11
		ret

option_2_11:  
	clr col3
	acall delay100us
	jnb row4,  change_pass1
	setb col3
	jmp option_2_11

newpass22:
	acall newpass222
	
newpass_51:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #5h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22		
		acall delay100us
		jmp option_2_11
newpass_61:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #6h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11
newpass_71:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #7h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		jmp option_2_11
newpass_81:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #8h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11
newpass_91:
		lcall display_sao
		mov R1, 70h			
		mov @R1, #9h			
		inc 70h 			
		acall delay100us
		inc 75h
		mov A, 75h
		cjne A, #4, newpass22			
		acall delay100us
		jmp option_2_11				

change_pass1:
	mov 30h, 4Ah
	mov 31h, 4Bh
	mov 32h, 4Ch
	mov 33h, 4Dh	
	acall clr_screen
  	jmp recheck_pass


recheck_pass:
	acall clr_screen
     MOV DPTR ,#re_check
	re_check_1:
		MOV A,#00H   
		MOVC A,@A+DPTR    
		JZ re_check_2      
		ACALL LCD_data    
		INC DPTR    
		SJMP re_check_1 
	re_check_2:

		acall line2
		mov 50h, #5Ah
		jmp re_check_3


re_check_31:
	clr A
	clr col1
	jnb row1, recheck_7
	jnb row2, recheck_4
	jnb row3, recheck_1
	acall delay10ms
	setb col1

	clr col2
	jnb row1, recheck_8
	jnb row2, recheck_5
	jnb row3, recheck_2
	jnb row4, recheck_0
	acall delay10ms
	setb col2

	clr col3
	jnb row1, recheck_9
	jnb row2, recheck_6
	jnb row3, recheck_3
	jnb row4, recheck_func_1
	acall delay10ms
	setb col3

	clr col4
	jnb row4, menu_4
	setb col4

	jmp re_check_3

menu_4:
	acall clr_screen
	jmp menu_selection

recheck_func_1:
	acall recheck_func
recheck_4:
	acall recheck_4_1
recheck_5:
	acall recheck_5_1
recheck_6:
	acall recheck_6_1
recheck_7:
	acall recheck_7_1
recheck_8:
	acall recheck_8_1
recheck_9:
	acall recheck_9_1	
	
recheck_0:
		mov A, #'0'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #0h			
		inc 50h 
		acall delay100us
		inc 35h
		mov A, 35h
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_1:
		mov A, #'1'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #1h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_2:
		mov A, #'2'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #2h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_3:
		mov A, #'3'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #3h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_4_1:
		mov A, #'4'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #4h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
		ret
re_check_3:
	acall re_check_31
	ret
last_check:
	clr col3
	jnb row4, recheck_func
	acall delay100us
	setb col3
	jmp last_check

recheck_5_1:
		mov A, #'5'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #5h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_6_1:
		mov A, #'6'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #6h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_7_1:
		mov A, #'7'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #7h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_8_1:
		mov A, #'8'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #8h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check
recheck_9_1:
		mov A, #'9'
		acall LCD_data
		mov R1, 50h			
		mov @R1, #9h			
		inc 50h 			
		cjne A, #4, re_check_3		
		acall delay10ms
		jmp last_check

recheck_func:
	mov R0, #4D				   ;lap 4 lan
	mov R1, #5Ah
	pass__:
	clr A
	mov A, @R1
	acall re_check_letter1
	inc R1
	djnz R0, recheck_func		   ; lap 4 lan
	jmp enter_pass	


re_check_letter1: 
	cjne A,30h, FAIL_1
	jmp re_check_letter2
re_check_letter2:
	inc R1
	clr A
	mov A, @R1 
	cjne A,31h, FAIL_1
	jmp re_check_letter3
re_check_letter3:
	inc R1
	clr A
	mov A, @R1 
	cjne A,32h, FAIL_1
	jmp re_check_letter4
re_check_letter4:
	inc R1
	clr A
	mov A, @R1 
	cjne A,33h, FAIL_1
	jmp success_1

success_1:
		acall delay0_1s
		acall clr_screen
    	MOV DPTR ,#sucess
		success_1_1:
			MOV A,#00H   
			MOVC A,@A+DPTR    
			JZ success_1_2      
			ACALL LCD_data    
			INC DPTR    
			SJMP success_1_1 
		success_1_2:
			clr A
			acall clr_screen
			ljmp menu_selection

FAIL_1:
		acall clr_screen
    		MOV DPTR ,#fail
		fail_1_1_1:
			MOV A,#00H   
			MOVC A,@A+DPTR    
			JZ fail_1_2     
			ACALL LCD_data    
			INC DPTR    
			SJMP fail_1_1_1
		fail_1_2:
			clr A
			lcall password
			lcall clr_screen
			ljmp menu_selection
	
//================================================option_3==========================================================

music:
	acall clr_screen

		mov dptr, #music_button
		music_1: 
			mov A, #00H
			movc A, @A + dptr
			jz next
			acall LCD_data
			inc dptr
			sjmp music_1
		next:
		acall delay0_1s
		acall line2

		song_options:
			mov P1, #11111111B 
			clr A
			clr col1
			jnb row2, song_4
			jnb row3, song_1
			acall delay10ms
			setb col1

			clr col2
			jnb row3, song_2
			jnb row2, song_5
			acall delay10ms
			setb col2

			clr col3
			jnb row3, song_3
			acall delay10ms
			setb col3

			clr col4
			jnb row4, menu_2
			setb col4

			jmp song_options


menu_2:
	acall clr_screen
	jmp menu_selection
song_1:
	acall clr_screen
	lcall tay_du_ky
	acall music_option_1

song_2:
	acall clr_screen
	acall music_option_2
	lcall furelise
	jmp music

song_3:	
	acall clr_screen
	acall music_option_3
	lcall gia_vo_yeu

song_4:	
	acall clr_screen
	acall music_option_4
	lcall pink_panther
	
song_5:
	acall clr_screen
	acall music_option_5
	lcall harry_porter	
	music_option_1:
			mov dptr, #music_song_1
			music_1_1:
			mov A, #00h
			movc A, @A + dptr
			jz next_1
			acall LCD_data
			inc dptr
			sjmp music_1_1
		next_1:
		acall delay0_1s
		acall clr_screen
		jmp menu_selection 


	music_option_2:
			mov dptr, #music_song_2
			music_2_1:
			mov A, #00h
			movc A, @A + dptr
			jz next_2
			acall LCD_data
			inc dptr
			sjmp music_2_1	
		next_2:
		acall delay0_1s
		ret


	 music_option_3:
	 		mov dptr, #music_song_3
			music_3_1:
		 	mov A, #00h
			movC A, @A + dptr
			jz next_3
			acall LCD_data
			inc dptr
			sjmp music_3_1
		next_3:
		acall delay0_1s	
		ret

			 
		music_option_4:
	 		mov dptr, #music_song_4
			music_4_1:
		 	mov A, #00h
			movC A, @A + dptr
			jz next_4
			acall LCD_data
			inc dptr
			sjmp music_4_1
		next_4:
		acall delay0_1s	
		ret

		music_option_5:
	 		mov dptr, #music_song_5
			music_5_1:
		 	mov A, #00h
			movC A, @A + dptr
			jz next_5
			acall LCD_data
			inc dptr
			sjmp music_5_1
		next_5:
		acall delay0_1s	
		ret
//==============================================LCD_setting============================================

LCD_init:
	mov A, #38H
	acall LCD_command
	mov A, #0EH
	acall LCD_command
	mov A, #80H
	acall LCD_command
	mov A, #01H
	acall LCD_command
	mov A, #06H
	acall LCD_command
	ret

LCD_command:
	acall LCD_delay 
	mov P0, A
	clr RS
	setb E
	clr  E
	ret
LCD_data:
	acall LCD_delay
	mov P0, A
	setb RS
	setb E
	clr E
	ret 	
line2:
	mov A, #0xC0
	acall LCD_command
	acall delay10ms
	ret

clr_screen:
	mov A, #0x01
	acall LCD_command
	acall delay10ms
	ret
//===============================================Delay_function==============================================



LCD_delay:
	MOV R0, #0FFH  
	L11: MOV R1, #0FFH   
	L12: DJNZ R1, L12    
	DJNZ R0, L11     
	RET

delay0_1s:
	mov 52H, #200
	s: mov 53h, #250
	s1: mov 54H, #2
	djnz 54H, $
	djnz 53H, s1
	djnz 52H, s
	ret

delay100us:
	mov R1, 100
	dec R1
delay10ms:
    MOV TMOD, #0x01   	  ; Set Timer0 in 16-bit mode
    MOV TH0,  #0x00    	  ; Load Timer0 high byte with initial value
    MOV TL0,  #0x00    	  ; Load Timer0 low byte with initial value

    SETB TR0              ; Start Timer0
WAIT_LOOP:
    JNB TF0, WAIT_LOOP    ; Wait until Timer0 overflows (TF0 flag is set)
    CLR TR0          	  ; Stop Timer0
    CLR TF0          	  ; Clear Timer0 overflow flag
    RET


delay_10s:
	mov R4, #200D
	delay_50ms:
		loop1:
 		mov TMOD,#10h                ; timer 1, mode 1 (16 bit )
		mov TH1,#3Ch                 ; or mov TH1,#high(-50000),thoi
 		mov TL1,#0AFh                ; or mov TL1,#low(-50000),
 		setb TR1                     ; cho phép timer ch?y
 		jnb TF1,$                    ; nh?y t?i ch?, không làm gì
 		clr TR1                      ; n?u timer tràn thì d?ng 
 		clr TF1                      ; xoá c? tràn
 		djnz R4,loop1
		ret	       	
//=================================setting cac not de chay nhac=====================================
c_1:  mov r3,bien_truong_do ;not do  ;1911us	  bien_lap=191
lc_1:
	mov hieu_chinh_truong_do,#16
loopc_1:
	mov bien_lap,#191
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_1
	djnz r3,lc_1
	ret

c_1t:  mov r3,bien_truong_do   				;not do thang  ;1804us	  bien_lap=180
lc_1t:
	mov hieu_chinh_truong_do,#17
	loopc_1t:
	mov bien_lap,#180
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_1t
	djnz r3,lc_1t
	ret

d_1:	mov r3,bien_truong_do				;not re  ;1703us	  bien_lap=170
	ld_1:
	mov hieu_chinh_truong_do,#18
	loopd_1:
	mov bien_lap,#170
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_1
	djnz r3,ld_1
	ret

d_1t:   mov r3,bien_truong_do				;not re thang  ;1607us	  bien_lap=161
	ld_1t:
	mov hieu_chinh_truong_do,#19
	loopd_1t:
	mov bien_lap,#161
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_1t
	djnz r3,ld_1t
	ret


e_1:   ;not mi   ;1517us	  bien_lap=152
		mov r3,bien_truong_do
		le_1:
		mov hieu_chinh_truong_do,#21
		loope_1:
		mov bien_lap,#152
		setb p1.4
		call delay
		clr p1.4
		call delay 
		djnz hieu_chinh_truong_do,loope_1
		djnz r3,le_1
		ret

f_1:   ;not pha   ;1432us	  bien_lap=143
	mov r3,bien_truong_do
	lf_1:
	mov hieu_chinh_truong_do,#22
	loopf_1:
	mov bien_lap,#143
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_1
	djnz r3,lf_1
	ret

f_1t:   ;not pha thang   ;1351us	  bien_lap=135
	mov r3,bien_truong_do
	lf_1t:
	mov hieu_chinh_truong_do,#23
	loopf_1t:
	mov bien_lap,#135
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_1t
	djnz r3,lf_1t
	ret

g_1:   ;not sol    ;1276us	  bien_lap=128
	mov r3,bien_truong_do
	lg_1:
	mov hieu_chinh_truong_do,#25
	loopg_1:
	mov bien_lap,#128
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_1
	djnz r3,lg_1
	ret

g_1t:   ;not sol thang   ;1204us	  bien_lap=120
	mov r3,bien_truong_do
	lg_1t:
	mov hieu_chinh_truong_do,#26
	loopg_1t:
	mov bien_lap,#120
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_1t
	djnz r3,lg_1t
	ret

a_1:   ;not la    ;1136us	  bien_lap=114
	mov r3,bien_truong_do
	la_1:
	mov hieu_chinh_truong_do,#28
	loopa_1:
	mov bien_lap,#114
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_1
	djnz r3,la_1
	ret

a_1t:   ;not la thang   ;1073us	  bien_lap=107
	mov r3,bien_truong_do
	la_1t:
	mov hieu_chinh_truong_do,#29
	loopa_1t:
	mov bien_lap,#107
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_1t
	djnz r3,la_1t
	ret

b_1:   ;not si    ;1012us	  bien_lap=101
	mov r3,bien_truong_do
	lb_1:
	mov hieu_chinh_truong_do,#31
	loopb_1:
	mov bien_lap,#101
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopb_1
	djnz r3,lb_1
	ret

c_2:   ;not do  ;956us	  bien_lap=96
	mov r3,bien_truong_do
	lc_2:
	mov hieu_chinh_truong_do,#33
	loopc_2:
	mov bien_lap,#96
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_2
	djnz r3,lc_2
	ret

c_2t:   ;not do thang  ;902us	  bien_lap=90
	mov r3,bien_truong_do
	lc_2t:
	mov hieu_chinh_truong_do,#35
	loopc_2t:
	mov bien_lap,#90
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_2t
	djnz r3,lc_2t
	ret

d_2:   ;not re  ;851us	  bien_lap=85
	mov r3,bien_truong_do
	ld_2:
	mov hieu_chinh_truong_do,#37
	loopd_2:
	mov bien_lap,#85
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_2
	djnz r3,ld_2
	ret

d_2t:   ;not re thang  ;804us	  bien_lap=80
	mov r3,bien_truong_do
	ld_2t:
	mov hieu_chinh_truong_do,#39
	loopd_2t:
	mov bien_lap,#80
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_2t
	djnz r3,ld_2t
	ret

e_2:   ;not mi   ;758us	  bien_lap=76
	mov r3,bien_truong_do
	le_2:
	mov hieu_chinh_truong_do,#41
	loope_2:
	mov bien_lap,#76
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loope_2
	djnz r3,le_2
	ret

f_2:   ;not pha   ;716us	  bien_lap=72
	mov r3,bien_truong_do
	lf_2:
	mov hieu_chinh_truong_do,#44
	loopf_2:
	mov bien_lap,#72
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_2
	djnz r3,lf_2
	ret

f_2t:   ;not pha thang   ;676us	  bien_lap=68
	mov r3,bien_truong_do
	lf_2t:
	mov hieu_chinh_truong_do,#46
	loopf_2t:
	mov bien_lap,#68
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_2t
	djnz r3,lf_2t
	ret

g_2:   ;not sol    ;638us	  bien_lap=64
	mov r3,bien_truong_do
	lg_2:
	mov hieu_chinh_truong_do,#49
	loopg_2:
	mov bien_lap,#64
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_2
	djnz r3,lg_2
	ret

g_2t:   ;not sol thang   ;602us	  bien_lap=60
	mov r3,bien_truong_do
	lg_2t:
	mov hieu_chinh_truong_do,#52
	loopg_2t:
	mov bien_lap,#60
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_2t
	djnz r3,lg_2t
	ret

a_2:   ;not la    ;568us	  bien_lap=57
	mov r3,bien_truong_do
	la_2:
	mov hieu_chinh_truong_do,#55
	loopa_2:
	mov bien_lap,#57
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_2
	djnz r3,la_2
	ret

a_2t:   ;not la thang   ;536us	  bien_lap=54
	mov r3,bien_truong_do
	la_2t:
	mov hieu_chinh_truong_do,#58
	loopa_2t:
	mov bien_lap,#54
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_2t
	djnz r3,la_2t
	ret

b_2:   ;not si    ;506us	  bien_lap=51
	mov r3,bien_truong_do
	lb_2:
	mov hieu_chinh_truong_do,#62
	loopb_2:
	mov bien_lap,#51
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopb_2
	djnz r3,lb_2
	ret

c_3:   ;not do  ;478us	  bien_lap=48
	mov r3,bien_truong_do
	lc_3:
	mov hieu_chinh_truong_do,#65
	loopc_3:
	mov bien_lap,#48
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_3
	djnz r3,lc_3
	ret

c_3t:   ;not do thang  ;451us	  bien_lap=45
	mov r3,bien_truong_do
	lc_3t:
	mov hieu_chinh_truong_do,#69
	loopc_3t:
	mov bien_lap,#45
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopc_3t
	djnz r3,lc_3t
	ret

d_3:   ;not re  ;426us	  bien_lap=43
	mov r3,bien_truong_do
	ld_3:
	mov hieu_chinh_truong_do,#73
	loopd_3:
	mov bien_lap,#43
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_3
	djnz r3,ld_3
	ret

d_3t:   ;not re thang  ;402us	  bien_lap=40
	mov r3,bien_truong_do
	ld_3t:
	mov hieu_chinh_truong_do,#78
	loopd_3t:
	mov bien_lap,#40
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopd_3t
	djnz r3,ld_3t
	ret

e_3:   ;not mi   ;379us	  bien_lap=38
	mov r3,bien_truong_do
	le_3:
	mov hieu_chinh_truong_do,#82
	loope_3:
	mov bien_lap,#38
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loope_3
	djnz r3,le_3
	ret

f_3:   ;not pha   ;358us	  bien_lap=36
	mov r3,bien_truong_do
	lf_3:
	mov hieu_chinh_truong_do,#87
	loopf_3:
	mov bien_lap,#36
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_3
	djnz r3,lf_3
	ret

f_3t:   ;not pha thang   ;338us	  bien_lap=34
	mov r3,bien_truong_do
	lf_3t:
	mov hieu_chinh_truong_do,#92
	loopf_3t:
	mov bien_lap,#34
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopf_3t
	djnz r3,lf_3t
	ret

g_3:   ;not sol    ;319us	  bien_lap=32
	mov r3,bien_truong_do
	lg_3:
	mov hieu_chinh_truong_do,#98
	loopg_3:
	mov bien_lap,#32
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_3
	djnz r3,lg_3
	ret

g_3t:   ;not sol thang   ;301us	  bien_lap=30
	mov r3,bien_truong_do
	lg_3t:
	mov hieu_chinh_truong_do,#104
	loopg_3t:
	mov bien_lap,#30
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopg_3t
	djnz r3,lg_3t
	ret

a_3:   ;not la    ;284us	  bien_lap=28
	mov r3,bien_truong_do
	la_3:
	mov hieu_chinh_truong_do,#110
	loopa_3:
	mov bien_lap,#28
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_3
	djnz r3,la_3
	ret

a_3t:   ;not la thang   ;268us	  bien_lap=27
	mov r3,bien_truong_do
	la_3t:
	mov hieu_chinh_truong_do,#117
	loopa_3t:
	mov bien_lap,#27
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopa_3t
	djnz r3,la_3t
	ret
b_3:   ;not si    ;253us	  bien_lap=25
	mov r3,bien_truong_do
	lb_3:
	mov hieu_chinh_truong_do,#123
	loopb_3:
	mov bien_lap,#25
	setb p1.4
	call delay
	clr p1.4
	call delay 
	djnz hieu_chinh_truong_do,loopb_3
	djnz r3,lb_3
	ret

lang:
	mov r4,bien_lang
	llang:
	mov tmod,#01h
	mov th0,#high(-62487)
	mov tl0,#low(-62487)
	setb tr0
	jnb tf0,$
	clr tf0
	clr tr0
	djnz r4,llang
	ret

delay:
	mov r0,bien_lap
	loop:
	nop	   ;1us
	nop	   ;1us
	nop	   ;1us	   
	nop	   ;1us
	nop	   ;1us
	nop	   ;1us
	nop	   ;1us
	nop	   ;1us
	djnz r0,loop
	ret	   ;2us	
x1:
	mov bien_truong_do,#_1
	ret
x2:
	mov bien_truong_do,#_2
	ret
x4:
	mov bien_truong_do,#_4
	ret
x8:
	mov bien_truong_do,#_8
	ret
x16:
	mov bien_truong_do,#_16
	ret
x32:
	mov bien_truong_do,#_32
	ret

;;;;;;
l1:
	mov bien_lang,#_1
	call lang
	ret
l2:
	mov bien_lang,#_2
	call lang
	ret
l4:
	mov bien_lang,#_4
	call lang
	ret
l8:
	mov bien_lang,#_8
	call lang
	ret
l16:
	mov bien_lang,#_16
	call lang
	ret
l32:
	mov bien_lang,#_32
	call lang
	ret

Tay_du_ky: 
#include <tay du ky.asm>
furelise:
#include <furelise.asm>
gia_vo_yeu:
#include <gia vo yeu.asm>
pink_panther:
#include <pink panther.asm>
harry_porter:
#include <harry porter.asm>
//===================================================================================
display_sao:
	mov A, #'*'
	lcall LCD_data
	ret
password:
	mov 30h, #1
	mov 31h, #2
	mov 32h, #3
	mov 33h, #4
	ret
//==================================================================================
home: DB 'HOME SWEET HOME',0
option1: DB 'Enter pass', 0
option2: DB 'reset pass', 0
option3: DB 'old pass', 0
option4: DB 'new pass', 0
sucess: DB 'sucess', 0
fail: DB 'wrong pass', 0
fail22: DB 'incorect pass',0
oldpass: DB 'old pass', 0
newpass_string: DB 'new pass', 0
pass_change: DB 'pass changed', 0
re_check: DB 'recheck pass', 0
delay_50s_string: DB 'Wait 50s', 0

music_button: DB 'choose a song', 0
music_song_1: DB 'Tay du ky', 0
music_song_2: DB 'furelise', 0
music_song_3: Db 'gia vo yeu',0
music_song_4: DB 'pink panther', 0
music_song_5: DB 'harry porter', 0
END
