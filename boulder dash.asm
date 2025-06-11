[org 0x0100]


jmp start


entrym1: db 'Name of file: $'

chkm1: db 'Reading file...$'

;chkm31: db '

chkm2: db 'Success!!!$'
chkm3: db 'Press any key to start game...'

m1: db 'Error! Invalid file name. Try again...$'
m2: db 'Error! Couldn', 27h, 't read file. Try again...$'
errm3: db 'what ifds this error?$'

m3: db 'Bytes in file: $'

m41: db 'Points: $'
m42: db 'exit/target'
m43: db 'boulder'
m44: db 'diamond'

m51: db 'Collect points and reach the target!$'

m61: db 'Oops! Beware of falling objects! Try again!$'
m62: db 'Looks like you left quite a few points... try again!$'
m63: db 'You missed a couple of points ;) ... try again!$'
m64:db 'Wow! You make it look so easy! Invite others to play sometime!$'
m65: db 'Wait... gone already? Try again!$'


nl: db 0xa, 0xa, '$'




buffer: times 2000 db 0
filen: db 'file.txt', 0

fn: 	db 50
	db 0
	 times 50 db 0

buff: times 10 db 0
pts: times 5 db 0
;------------------------------------------------------------------





whathuh:  mov ah, 9h
	mov dx, nl
	int 21h	
	mov ah, 9h
	mov dx, nl
	int 21h	
	mov ah, 9h
	mov dx, nl
	int 21h	
	mov ah, 9h
	mov dx, nl
	int 21h	

	mov ah, 9h
	mov dx, errm3
	int 21h	
	jmp end


err1:	mov ah, 9h
	mov dx, nl
	int 21h	

	mov ah, 9h
	mov dx, m1
	int 21h

	mov ah, 9h
	mov dx, nl
	int 21h

	jmp end

err2:	mov ah, 9h
	mov dx, m2
	int 21h

	mov ah, 9h
	mov dx, nl
	int 21h

	jmp end


clrscr:	mov ax, 0xb800
	mov es, ax
	xor di, di
	mov cx, 2000
	mov ax, 0720h

	rep stosw
	ret

prtPoints:	
	mov ax, 0xb800
	mov es, ax
	mov di, 326
	mov si, m41
	mov ah, 0x0f
	mov cx, 8

prtPointsL1:
	mov al, [si]
	mov [es:di], ax     ;loop printing "print: "
	inc si
	add di, 2 
	loop prtPointsL1
	
	;mov al, 0x30
	;mov [es:di], ax	;points count
	;add di, 30 


mov ax, 0
XOR BX, BX          ; Set BX to 0 (used to count digits)
MOV SI,  pts   ; Point SI to the buffer
add si, 2

; Convert the value to a string

convertpts:
XOR DX, DX          ; Clear DX for division
MOV CX, 10          ; Divide by 10 to extract the last digit
DIV CX              ; Divide AX by CX
ADD DL, '0'         ; Convert the remainder to ASCII
MOV [SI], DL        ; Store the digit in the buffer
dec SI              ; Move to the next position in the buffer
INC BX              ; Increment the digit count
CMP AX, 0           ; Check if value is 0
JNE convertpts         ; If not, repeat the conversion


	mov ah, 0x0f
	mov si, pts
	mov cx, 3
	

prtPointsL11:
	mov al, [si]
	mov [es:di], ax     ;loop printing the points digits
	inc si 
	add di, 2 
	loop prtPointsL11

	;mov word [es:342], 0x1020
	add di, 28








	mov ax, 0x507F	;legend target/exit
	mov [es:di], ax
	add di, 4

	mov ax, 0xb800
	mov es, ax
	mov si, m42
	mov cx, 11
	mov ah, 0x0f

prtPointsL2:
	mov al, [si]
	mov [es:di], ax     
	inc si
	add di, 2 
	loop prtPointsL2

	add di, 8
	mov ax, 0x0609	;legend bouldah
	mov [es:di], ax
	add di, 4

	mov ax, 0xb800
	mov es, ax
	mov si, m43
	mov cx, 7
	mov ah, 0x0f

prtPointsL3:
	mov al, [si]
	mov [es:di], ax     
	inc si
	add di, 2 
	loop prtPointsL3	

	add di, 8
	mov ax, 0x0304	;legend diamondo
	mov [es:di], ax
	add di, 4

	mov ax, 0xb800
	mov es, ax
	mov si, m44
	mov cx, 7
	mov ah, 0x0f

prtPointsL4:
	mov al, [si]
	mov [es:di], ax     
	inc si
	add di, 2 
	loop prtPointsL4

	ret













PointsTracker:

	push bp
	mov bp, sp
	
	push bx
	push cx	;save old values
	push si
	push ax
	push di

	mov ax, [bp+4]


XOR BX, BX          ; Set BX to 0 (used to count digits)
MOV SI,  pts   ; Point SI to the buffer
add si, 2

; Convert the value to a string

PointsTrackerL1:
XOR DX, DX          ; Clear DX for division
MOV CX, 10          ; Divide by 10 to extract the last digit
DIV CX              ; Divide AX by CX
ADD DL, '0'         ; Convert the remainder to ASCII
MOV [SI], DL        ; Store the digit in the buffer
dec SI              ; Move to the next position in the buffer
INC BX              ; Increment the digit count
CMP AX, 0           ; Check if value is 0
JNE PointsTrackerL1        ; If not, repeat the conversion


	mov ah, 0x0f
	mov si, pts
	mov cx, 3
	mov di, 342
	

PointsTrackerL2:
	mov al, [si]
	mov [es:di], ax     ;loop printing the points digits
	inc si 
	add di, 2 
	loop PointsTrackerL2

	
	pop di
	pop ax
	pop si
	pop cx
	pop bx
	pop bp

	ret 
















start:
	;call clrscr



	;mov ah, 9h
	;mov dx, nl	;nl
	;int 21h

	mov ah, 9h
	mov dx, entrym1	; name of file msg
	int 21h


mov ah, 0x0a	;user input
mov dx, fn
int 0x21

mov bh, 0		;input syntax format
mov bl , [fn + 1]
mov byte [fn + 2 + bx], 0
mov byte [fn + 2 + bx + 1], '$'	;safeproofing from garbage values


	mov ah, 9h
	mov dx, nl   ;nl
	int 21h


mov ah, 0x9
mov dx, chkm1		;msg reading
int 0x21


mov ah, 0x9
mov dx, fn + 2	;show inputted file
int 0x21

mov ah, 3dh
mov dx, fn + 2	; 'open' the file
mov al, 0
int 21h
jc err1

mov bx, ax	;store generated file handle in BX

mov ah, 3fh
mov cx, 2000	;actually read the damn file
mov dx, buffer	;and store contents in BUFFER
int 21h
jc err2
push ax	;save # of bytes read from file 

 	mov ah, 9h
	mov dx, nl   ;nl
	int 21h

mov ah, 0x9
mov dx, chkm2		;msg successs
int 0x21


	mov ah, 9h
	mov dx, nl   ;nl
	int 21h

;mov ah, 0x9
;mov dx, chkm3		;msg press key
;mov cx, 30
;mov bl, 0x87
;int 0x10






MOV AH, 13h       ; Interrupt 0x10 function to print string with attribute
MOV AL, 1         ; Display the string with attribute
MOV BH, 0         ; Page number
MOV BL, 0x0F      ; Set the foreground and background color
MOV CX, 30 ; Length of the message string
MOV DH, 24         ; Row position
MOV DL, 0         ; Column position
MOV BP, chkm3   ; DS:BP points to the message string
OR  BL, 0x80      ; Set bit 7 to enable blinking
INT 10h        









	;mov ah, 9h
	;mov dx, nl   ;nl
	;int 21h





mov ah, 0		;press any keystroke
int 0x16

call clrscr
call prtPoints

	;mov ah, 9h
	;mov dx, nl   ;nl
	;int 21h

;---------------------------------------------------- print how many bytes in file



mov ah, 9h
mov dx, m3	;msg number of bytes
int 21h

pop ax	;get # of bytes to print it

XOR BX, BX          ; Set BX to 0 (used to count digits)
MOV SI,  buff   ; Point SI to the buffer
add si, 3
; Convert the value to a string

convert:
XOR DX, DX          ; Clear DX for division
MOV CX, 10          ; Divide by 10 to extract the last digit
DIV CX              ; Divide AX by CX
ADD DL, '0'         ; Convert the remainder to ASCII
MOV [SI], DL        ; Store the digit in the buffer
dec SI              ; Move to the next position in the buffer
INC BX              ; Increment the digit count
CMP AX, 0           ; Check if value is 0
JNE convert         ; If not, repeat the conversion

; Display the string on the screen
MOV CX, BX          ; Load the digit count into CX
MOV SI, buff  ; Point SI to the start of the buffer

print:
MOV AL, [SI]        ; Load the character from memory
CMP AL, 0           ; Check for end of string
JE out1		; Jump if end of string
MOV AH, 0Eh         ; BIOS function to print character
MOV BH, 0           ; Display page (0 for text mode)
MOV BL, 7           ; Attribute (7 for white on black)
INT 10h             ; Call BIOS
INC SI              ; Point to next character
JMP print           ;

out1:	mov ah, 9h
	mov dx, nl
	int 21h


;------------------------------------------------ now print file data
mov si, buffer

mov ax, 0xb800
mov es, ax
mov di, 480	   ;top border
mov cx, 80

topBord:	mov word[es:di], 0x6020
	add di, 2
	loop topBord


mov ax, 0xb800
mov es, ax
mov di, 640

mov cx, di

placebord:    mov word [es:di], 0x6020	;border 
	     add di, 2
	     add cx, 160


nextchar:	cmp di, cx
	je placebord

	mov al, [si]
	mov ah, 0x07

	cmp al, 0
	je endOfPrinting



notborder: cmp al, 0xA
	je notA
	cmp al, 0xD
	je notA


	jmp not01

notA:	add si, 2
	mov word [es:di], 0x6020	;border 
	add di, 2
	jmp nextchar


not01:	cmp al,0x78	;found dirt 
	jne notDirt
	mov ah, 0x08
	mov al, 0xB0		
	jmp not2


notDirt:	cmp al,0x52	;found rockford 
	jne notRockford
	push di		;save starting [psition
	mov ah, 0x84
	mov al, 0x02		
	jmp not2

notRockford:    cmp al,0x54	;found target/exit 
	jne notTarget
	push di
	mov ah, 0x50	
	mov al, 0x7F		
	jmp not2

notTarget:	   cmp al,0x42	;found boulder 
	jne notBoulder
	mov ah, 0x06
	mov al, 0x09		
	jmp not2

notBoulder:   cmp al,0x44	;found diamond 
	jne notDiamond
	mov ah, 0x03
	mov al, 0x04		
	jmp not2


notDiamond:  cmp al,0x57	;found wall 
	jne notWall
	mov ah, 0x60
	mov al, 0x20		
	jmp not2

notWall:	jmp whathuh




;not:	;mov ah,0eh
	;mov bh, 0
	;mov bl, 7
	;int 10h
	;inc si
	;jmp nextchar

not2:	mov [es:di], ax
	add di, 2
	inc si
	jmp nextchar


endOfPrinting: mov word [es:di], 0x6020

mov ax, 0xb800
mov es, ax
mov cx, 81	;bottom border


botBord:	mov word[es:di], 0x6020
	add di, 2
	loop botBord

;--------------------------------------------------- now start contorlling

mov ah, 1        ; Set AH to 1 to hide the cursor
mov ch, 20h      ; Set CH to 20h to move the cursor off the screen
int 10h  

pop bx 	;save exit pos 
pop di	;store strating in di
mov dx, 0

CheckArrowKey:
  mov ah, 0       ; Set AH to 0 to read a character from the keyboard buffer
  int 16h         ; Call the BIOS interrupt to read a character from the keyboard buffer
    
  cmp al, 0x1B	;escape
	je end

  ;cmp ah, 0       ; Check if the scan code is in AH (should be 0 for arrow keys)
  ;jne CheckArrowKey  ; If not, keep reading from the keyboard buffer until a valid key is pressed
hh2:  cmp ah, 48h     ; Check if up arrow was pressed (scan code 48h)
  je HandleUpArrow   ; If so, jump to the code to handle the up arrow
  cmp ah, 50h     ; Check if down arrow was pressed (scan code 50h)
  je HandleDownArrow  ; If so, jump to the code to handle the down arrow
  cmp ah, 4Bh     ; Check if left arrow was pressed (scan code 4Bh)
  je HandleLeftArrow  ; If so, jump to the code to handle the left arrow
  cmp ah, 4Dh     ; Check if right arrow was pressed (scan code 4Dh)
  je HandleRightArrow  ; If so, jump to the code to handle the right arrow
  jmp CheckArrowKey 


HandleUpArrow:;je end
	mov cx, di	   ;save current pos
	sub di, 160  ;the new position (before all checks)

	cmp di, bx  ;check if target/exit  reached
	je end
	
	mov ax, word [es:di]     ; store in ax the character which is at new position


	cmp ax, 0x0304	;check if new pos is diamondo
	jne UpDiaNot	

	inc dx
	push dx
	call PointsTracker	;update points on screen
	pop dx
	jmp HalfGoodUP2	


UpDiaNot:
	cmp ax, 0x6020       ;check if new pos is  wall
	jne HalfGoodUP1

	add di, 160       ;if yes dont move
	jmp CheckArrowKey	

HalfGoodUP1:  cmp ax,0x0609    ;check for bouldah
	jne HalfGoodUP2

	add di, 160
	mov word [es:di], 0x8458
	jmp endBoul

HalfGoodUP2:  sub di, 160 
	mov ax, word [es:di]
	cmp ax,0x0609    ;check for bouldah
	jne AllGoodUp

	add di, 160
	mov word [es:di], 0x8458

	push di
	mov di, cx
	mov word[es:di], 0x0720    ;empty prev pos
	pop di
	jmp endBoul



AllGoodUp: add di, 160 
	mov word [es:di], 0x8B02  ;go to new pos
	push di
	mov di, cx
	mov word[es:di], 0x0720    ;empty prev pos
	pop di
	jmp CheckArrowKey


HandleDownArrow:;je end
	mov cx, di
	add di, 160
	cmp di, bx
	je endTarget

	mov ax, word [es:di]


	cmp ax, 0x0304	;check if new pos is diamondo
	jne DownDiaNot	

	inc dx
	push dx
	call PointsTracker	;update points on screen
	pop dx
	jmp AllGoodDown	


DownDiaNot:	
	cmp ax, 0x6020
	jne HalfGoodDown  

	sub di, 160
	jmp CheckArrowKey

HalfGoodDown:     cmp ax,0x0609    ;check for bouldah
	jne AllGoodDown

	sub di, 160
	jmp CheckArrowKey

AllGoodDown:   mov word [es:di], 0x8C02
	push di
	mov di, cx
	mov word[es:di], 0x0720
	pop di
	jmp CheckArrowKey



HandleLeftArrow:;je end
	mov cx, di
	sub di, 2
	cmp di, bx
	je endTarget

	mov ax, word [es:di]


	cmp ax, 0x0304	;check if new pos is diamondo
	jne LeftDiaNot

	inc dx
	push dx
	call PointsTracker	;update points on screen
	pop dx
	jmp HalfGoodLeft2	


LeftDiaNot:

	cmp ax, 0x6020
	jne HalfGoodLeft1

	add di, 2
	jmp CheckArrowKey


HalfGoodLeft1:  cmp ax,0x0609    ;check for bouldah on left
	jne HalfGoodLeft2

	add di, 2		;if yes dont move
	jmp CheckArrowKey

HalfGoodLeft2: sub di, 160 
	mov ax, word [es:di]
	cmp ax,0x0609    ;check for bouldah
	jne AllGoodLeft  

	add di, 160
	mov word [es:di], 0x8458
	push di
	mov di, cx
	mov word[es:di], 0x0720    ;empty prev pos
	pop di
	jmp endBoul


AllGoodLeft: add di ,160 
	mov word [es:di], 0x8D02
	push di
	mov di, cx
	mov word[es:di], 0x0720
	pop di
	jmp CheckArrowKey




HandleRightArrow:;je end
	mov cx, di
	add di, 2
	cmp di, bx
	je endTarget

	mov ax, word [es:di]

	cmp ax, 0x0304	;check if new pos is diamondo
	jne RightDiaNot

	inc dx
	push dx
	call PointsTracker	;update points on screen
	pop dx
	jmp HalfGoodRight2	


RightDiaNot:
	cmp ax, 0x6020
	jne HalfGoodRight1  

	sub di, 2
	jmp CheckArrowKey

HalfGoodRight1:  cmp ax,0x0609    ;check for bouldah on left
	jne HalfGoodRight2

	sub di, 2		;if yes dont move
	jmp CheckArrowKey

HalfGoodRight2:  sub di, 160 
	mov ax, word [es:di]
	cmp ax,0x0609    ;check for bouldah
	jne AllGoodRight  

	add di, 160
	mov word [es:di], 0x8458
	push di
	mov di, cx
	mov word[es:di], 0x0720    ;empty prev pos
	pop di
	jmp endBoul


AllGoodRight: add di, 160 
	mov word [es:di], 0x8A02
	push di
	mov di, cx
	mov word[es:di], 0x0720
	pop di
	jmp CheckArrowKey


endBoul:	mov cx, dx   ; total points scored 

	mov ah, 9h
	mov dx, nl
	int 21h

	mov ah, 9h
	mov dx, m61
	int 21h
	jmp endFinal

endTarget: mov cx, dx   ; total points scored 

	mov ah, 9h
	mov dx, nl
	int 21h	


	cmp cx, 10
	jl LessTen	

	cmp cx, 27
	jl LessHalf



	mov ah, 9h
	mov dx, m64
	int 21h
	jmp endFinal



LessTen:   mov ah, 9h
	mov dx, m62
	int 21h
	jmp endFinal

LessHalf:    mov ah, 9h
	mov dx, m63
	int 21h
	jmp endFinal



end: 	mov cx, dx   	; end reached from escape ley

	mov ah, 9h
	mov dx, nl
	int 21h

	mov ah, 9h
	mov dx, m65
	int 21h


endFinal:	mov ax, 0xb800
	mov es, ax
	mov di, 3810

	push cx

	mov si, m41
	mov ah, 0x0f
	mov cx, 8

endPointsL1:
	mov al, [si]
	mov [es:di], ax    
	inc si
	add di, 2 
	loop endPointsL1


	mov ah, 0x0f
	mov si, pts
	mov cx, 3
	
	

endTrackerL2:
	mov al, [si]
	mov [es:di], ax     ;loop printing the points digits
	inc si 
	add di, 2 
	loop endTrackerL2












mov ax, 0x4c00
	int 21h