.model small
.data
.stack

datos segment
	msj00 db "Alumno: Trejo Rodirguez Javier Enrique", 13,10 "Grupo: ICO O-6",13,10, "Materia: Ensambladores", 13,10, "$"
	msj01 db "Introduce una palabra:  $", 13,10,"$"
	msj02 db "la cadena leida fue:  $"
	msj03 db "la cadena escrita fue:  $"
	ARR 255 dup(0)
	db COUNTER  00
	db FLAG 00
	dw FLAG 0
datos ends

Main:

Pedir:
	lea si, ARR
	
	Pedir01:
	
	mov ah, 01h
	int 21h
	mov ah, 00h
	
	cmp ax,13
	jz Compara
	jnz Mete
	
Mete:
	
	push ax
	mov [si],ax
	mov ax,si
	add ax,02h
	mov si,ax
	mov ax,COUNTER
	add ax,01h
	mov COUNTER,ax
	jmp Pedir
	
Saca:

	lea si, ARR
	mov cx, COUNTER
	
	for:
	
		pop ax
		mov bx,[si]
		cmp ax,bx
		jz Bandera0
		jnz Bandera1
		
		Bandera0:
		
			mov ax,si
			add ax,02h
			mov si,ax
			
		Bandera1:
		
			mov ax, FLAG
			mov ax,01h
			mov FLAG,ax
			
			mov ax,si
			add ax,02h
			mov si,ax
			
	loop for
	
	mov ax,FLAG
	cmp ax,00h
	
	jz Palindromo
	jnz NoPalindromo
	
	Palindromo:
	
		mov bx, offset msj
		mov ah,09h
		int 21h
		jmp salir
	
	NoPalindromo:
		
		mov bx, offset msj
		mov ah,09h
		int 21h
		jmp salir
		
	Salir:
	
		mov ah,4ch
		int 21h
		
Main ends