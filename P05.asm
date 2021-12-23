.model small
.data

datos segment
	msj00 db "Alumno: Trejo Rodirguez Javier Enrique", 12,10, "Grupo: ICO O-6",13,10, "Materia: Ensambladores", 13,10, "$"
	msj01 db "Introduce una palabra : ", 13,10,"$"
	msj02 db "la cadena leida fue :  $"
	msj03 db "la cadena escrita fue :  $"
	nuevalinea db 13,10, "$"
	buf db 255 dup(0)
	fub db 255 dup(0)
datos ends


code segment
	assume cs:code, ds:datos
	
main:
	mov ax, datos
	mov ds,ax
	
	lea dx,msj00
	mov ah,09h
	int 21h
	
	lea dx,msj01
	mov ah,09h
	int 21h
	
	xor si,si
	xor di,di
	xor cx,cx
	lea si, buf
	lea di, fub
	
	leer:
		mov ah,1
		int 21h
		
		cmp al,13
		je mostrarAntes
		
		mov [si],al
		inc si
		inc cx
		jmp leer

mostrarAntes:
	mov dx, offset msj02
	mov ah, 09h
	int 21h
	
	mov dx, offset nuevalinea	
	mov ah,09h
	int 21h
	
	mov [si], byte ptr"$"
	
	mov dx, offset buf
	mov ah,09h
	int 21h
	
	invertir:
		dec si
		mov al,[si]
		mov [di],al
		inc di
	loop invertir
	
	mov [di], byte ptr "$"
	
	mov dx, offset nuevalinea
	mov ah, 09h
	int 21h
	
	mov dx, offset msj03
	mov ah, 09h
	int 21h
	
	mov dx, offset fub
	mov ah, 09h
	int 21h
	
	mov ax, 4c00h
	int 21h
	
code ends
	
end main
		