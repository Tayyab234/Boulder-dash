[org 0x0100]
jmp start
;____________________________________
m1: db 'Please Enter File name : $'
m3:db 'Press Enter for default file (cave1.txt) $'
error: db 'Given file does not exit : error occur $'
error1: db 'Given file may have incomplete or invalid content : program is now quit $'
m2: db 'cave1.txt 0'
;__________________________________

m5: db 'BOULDER DASH $'
m6: db 'NUCES EDITION$'
m7: db ' Arrow keys: move $'
m8: db 'Esc: quit$'
m9: db 'Score: $'
m10: db ' Level: 1$'
m11: db ' Level Complete   $'
m12: db ' GAME OVER  !!!   $'
m13: db 'Press any key to exit--  $'
m14: db 'Welcome To The BOULDER DASH $'
m15: db 'MADE BY TAYYAB AKHTAR AND AHMED SHAHZAD $'
m16: db 'Collect diamonds to increase score $' 
m17: db 'Beware Of Red Balls $'
m18: db 'Get Home Safely To Complete The Level $'
m19: db 'Goodluck On Your Adventure!!! $'
m20: db 'Press Any Key To Continue... $'
charpos: dw 0
Score: dw 0
finish: dw 0
val: dw 0
;___________________________________
filename: db 15
db 0
times 15 db 0
handle: dw 0
buffer: times 1520  db 0

;________________________
clrscr:push bp
mov bp,sp
push ax
push di
push es
push cx

mov di,[bp+4]
mov cx,[bp+6]

mov ax,0xb800
mov es,ax

l2:mov word[es:di],0x0720
add di,2
loop l2

pop cx
pop es
pop di
pop ax
pop bp
ret
;---------------------------------------helping funtions
space:push dx
push ax
mov dl,' '
mov ah,2
int 0x21
pop ax
pop dx
ret

nextline:push ax
push dx
mov dl,10
mov ah,2
int 0x21
mov dl,13
mov ah,2
int 0x21
pop dx
pop ax
ret
next:push ax
push dx
mov dl,10
mov ah,2
int 0x21
pop dx
pop ax
ret

num:push bp
mov bp,sp
push es
push ax
push bx
push cx
push dx
push di

mov ax,0xb800
mov es,ax
mov ax,[bp+4]
mov bx,10
mov cx,0

nextdigit: mov dx,0
div bx
add dl,0x30
push dx
inc cx
cmp ax,0
jnz nextdigit

prin:pop dx
call charin
loop prin

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2
charin:push dx
push ax
mov dh,0x07
mov ah,2
int 21h
pop ax
pop dx
ret
stringin:push dx
push ax
mov ah,9
int 21h
pop ax
pop dx
ret
setcur:push ax
push bx
mov ah,2
mov bh,0
int 10h
pop bx
pop ax
ret
color:push ax
mov al,0
int 10h
pop ax
ret

;------------------------------------------------------
hrzline:push di
push ax
push cx
mov cx,80
mov ax,0xb800
mov es,ax
p7:mov word[es:di],0x11DF
add di,2
loop p7
pop di
pop cx
pop ax
ret
vrtline:push di
push ax
push cx
mov cx,19
mov ax,0xb800
mov es,ax
p10:mov word[es:di],0x11DF
add di,160
loop p10
pop di
pop cx
pop ax
ret
;_____________________________________________border
border:mov cx,22
p1:call space
loop p1
mov cx,3
p2:mov dl,16
call charin
loop p2
call space
mov dx,m5
call stringin
call space
mov dl,3
call charin
call space
call space
mov dx,m6
call stringin
call space
mov cx,3
p4:mov dl,17
call charin
loop p4
call nextline
mov dx,m7
call stringin
mov cx,50
p3:call space
loop p3
mov dx,m8
call stringin
call nextline
;---------------------------------------------
mov di,320
call hrzline
mov di,480
call vrtline
mov di,638
call vrtline
mov di,3520
call hrzline

mov dx,0x1404
call setcur
mov cx,3
p8:call nextline
loop p8
mov dx,m9
call stringin
mov ax,[Score]
push ax
call num
mov cx,60
p9:call space
loop p9
mov dx,m10
call stringin
ret
;_______________________________________________________________
read1:mov ax,0xb800
mov es,ax
mov bx,19
mov si,buffer
mov di,482
j1:mov cx,80
j2:cmp byte[si],'x'
   jne skip2
   mov word[es:di],0x07B1  
;-------------------------------------------
   skip2:cmp byte[si],'W'
   jne skip3
   mov word[es:di],0x11DF

;-------------------------------------------------------
   skip3:cmp byte[si],'B'
   jne skip4
   mov word[es:di],0x0409
;------------------------------------------------------
   skip4:cmp byte[si],'D'
   jne skip5
   mov word[es:di],0x0304
;---------------------------------------------------
   skip5:cmp byte[si],'T'
   jne skip6
   mov word[es:di],0x067F
;----------------------------------------------------
   skip6:cmp byte[si],'R'
   jne skip8
   mov word[charpos],di
   mov word[es:di],0x0202
;---------------------------------------------------
   skip8:add si,1
   add di,2
   loop j2
dec bx
cmp bx,0
ja j1

ret
;___________________________________________________________________
beep:push ax
push dx
mov ah,2
mov dl,7
int 21h
mov ah,2
mov dl,7
int 21h
pop dx
pop ax
ret
;-------------------------------------------------------------------
check1:push bx
mov si,di                   ;left wall check
sub si,2
mov cx,19
mov bx,480
z1:cmp bx,si
   je z2
   add bx,160
   loop z1

   mov bx,word[es:si]
   cmp bx,0x11DF   ;inside wall
   je z2
   cmp bx,0x0409   ;inside bolt
   je z2
   sub di,2
pop bx
   ret
   z2:call beep
pop bx
   ret   
;----------------------------------------------------------------------
check2:push bx
mov si,di                  ;right wall check
add si,2
mov cx,19
mov bx,638
z3:cmp bx,si
   je z4
   add bx,160
   loop z3

    mov bx,word[es:si]
   cmp bx,0x11DF   ;inside wall
   je z4
   cmp bx,0x0409   ;inside bolt
   je z4
   add di,2
pop bx
   ret
   z4:call beep
pop bx
   ret   

;_---------------------------------------------------------
check3:push bx
mov si,di                ;up wall check
sub si,160
mov cx,78
mov bx,322
z5:cmp bx,si
   je z6
   add bx,2
   loop z5
   mov bx,word[es:si]
   cmp bx,0x11DF   ;inside wall
   je z6
   cmp bx,0x0409   ;inside bolt
   je z6
   sub di,160
   mov ax,word[es:di]
   mov word[val],ax
   pop bx
   ret
   z6:call beep
pop bx
   ret   

;---------------------------------------------------------------
check4:push bx
mov si,di                   ;down wall check
add si,160
mov cx,78
mov bx,3680
z7:cmp bx,si
   je z8
   add bx,2
   loop z7
   mov bx,word[es:si]
   cmp bx,0x11DF   ;inside wall
   je z8
   cmp bx,0x0409   ;inside bolt
   je z8
   add di,160
pop bx
   ret
   z8:call beep
pop bx
   ret   
   
;__________________________________________________________________
gameplay:cmp al, 0x48 ;up
  jne skip10
  mov word[es:di],0x0720
  call check3
jmp v2
;----------------------------------------------------
  skip10:cmp al,0x50   ;down
  jne skip11
   mov word[es:di],0x0720
  call check4
  mov ax,word[es:di]
  mov word[val],ax
jmp v2
;----------------------------------------------------
  skip11:cmp al,0x4d   ;right
  jne skip12
   mov word[es:di],0x0720
  call check2
  mov ax,word[es:di]
  mov word[val],ax
jmp v2
;-----------------------------------------------------
  skip12:cmp al,0x4b  ;left
  jne v2
  mov word[es:di],0x0720
  call check1
  mov ax,word[es:di]
  mov word[val],ax
;-----------------------------------------------------------
 v2: mov bx,word[val]
     cmp bx, 0x0304
     jne skip31
     add word[Score],1
mov dx,0x1404
call setcur
mov cx,3
p22:call nextline
loop p22
mov dx,m9
call stringin
mov ax,[Score]
push ax
call num
call nextline
jmp v1
;__------------------------------------____
  skip31:cmp bx, 0x067F
     jne skip32
mov word[finish],1
mov word[es:di],0x8502
mov dx,0x0100
call setcur
mov dx,m11
call stringin
a2:jmp v1
;__------------------------------------____
  skip32:mov si,di
     sub di,160
     mov bx,word[es:di]
     cmp bx,0x0409
     jne v1
     mov word[finish],1
     mov di,si
     mov word[es:di],0x8402
     mov dx,0x0100
     call setcur
     mov dx,m12
     call stringin
;__-----------------------------------_____
 v1:mov di,si
 cmp word[finish],1
    jne v3
    ret
v3:mov word[es:di],0x0202
ret
;_______________________________________________________________
start: push 0
push 2000
call clrscr
mov dx, 0
call setcur
mov dx, m14
call stringin
call nextline
mov dx, m15
call stringin
call nextline
mov dx, m16
call stringin
call nextline
mov dx, m17
call stringin
call nextline
mov dx, m18
call stringin
call nextline
mov dx, m19
call stringin
call nextline
mov dx, m20
call stringin
call nextline
mov ah, 0
int 0x16
push 0
push 2000
call clrscr
mov dx,m3
call stringin
call nextline
mov dx,m1
call stringin

mov dx,filename
mov ah,0Ah
int 0x21
push 0
push 2000
call clrscr
;___________________________________
mov ah,2
mov bh,0
mov dx,0000h
int 10h
;_________________________________

mov bh,0
mov bl,[filename+1]
cmp bl,2
jb skip
mov byte[filename+2+bx],'0'


mov ah,3Dh
mov dx,filename+2
mov al,0
int 21h
mov word[handle],ax
jnc continue

mov dx,error
mov ah,9
int 0x21
jmp exit
;____________read file______________________and error handling related to file
skip:mov ah,3Dh
mov dx,m2
mov al,0
int 21h
mov word[handle],ax
jnc continue

mov dx,error
call stringin


jmp exit
continue:mov ah,3Fh
mov bx,[handle]
mov cx,1520
mov dx,buffer
int 21h

mov cx,1520
mov si,buffer
mov di,0
l19:cmp byte[si],'x'
    je ad
    cmp byte[si],'W'
    je ad
    cmp byte[si],'D'
    je ad
    cmp byte[si],'B'
    je ad
    cmp byte[si],'T'
    je ad
    cmp byte[si],'R'
    je ad
    jmp skip1
  ad: add di,1
skip1:add si,1
loop l19

cmp di,1482
jb err
jmp further
err:mov dx,error1
call stringin

jmp exit

;_______________________________________

further:push 0
push 2000
call clrscr
mov ah,2
mov bh,0
mov dx,0000h
int 10h

call border
call nextline
call read1
mov di,word[charpos]
mov ax,0xb800
mov es,ax

main1:mov ah,0
int 0x16
in al,0x60
cmp al,01
je exit
call gameplay
x1:cmp word[finish],1
je exit
mov al,0x20
out 0x20,al
jmp main1

exit:mov dx,0x1404
call setcur
mov cx,4
p23:call nextline
loop p23
mov dx,m13
call stringin
mov ah,0
int 0x16
mov ax,0x4c00
int 0x21




