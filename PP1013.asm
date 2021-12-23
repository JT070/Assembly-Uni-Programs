include PP1013M.lib
.model small
.data
Datos
.stack
.code

Inicio:
	
	call PIDE_DATOS	
	call HEXADECIMAL	
	call DECIMAL
	
	ImprimeResultado ax,dx,Cad03,ArNumero
	
	;;--------------------------------------------------------------------------------------------------------
	
	PIDE_DATOS:
		Cargar	
		Imprime Cad01, Cad02	
		Limpia_SIDICX si,di,cx
		
		lea si, ArNum
		lea di, ArmuN
		
		leer:
			mov ah,1   ;scanf
			int 21h		
			cmp al,13  ;compara y salta		
			je InvierteArreglo		
			LeerMac ax,bx,cx,si		
			jmp leer
		
		InvierteArreglo:	
			Invertir ax,si,di
		loop InvierteArreglo
			
		Limpia_Todo si,di,cx,ax,bx
		
		mov cx,contador   ;Asigna
		lea si,ArMul
		
		LlenaArregloMultiplicador:     
			LlenaArregloMultiplicadorMacro Mult,MultD,ax,bx,si
		loop LlenaArregloMultiplicador
	RET
	
	HEXADECIMAL:
		Limpia_Todo si,di,cx,ax,bx
	
		mov cx,contador		;Asigna
		lea si,ArMul
		lea di,ArmuN
		
		SacarYMultiplicar:			
			SacarYMultiplicarMacro ax,bx,si,di,Acumulador				
		loop SacarYMultiplicar  		
		
		xor di,di				
		xor cx,cx
		mov ax,00h
		mov bx,00h
		
		mov cx,contador			;Asigna
		lea di,ArMultiplicador
	RET
	
	DECIMAL:
		InvierteMultiplicador:		
			Invertir ax,si,di
		loop InvierteMultiplicador
		
		Limpia_Todo si,di,cx,ax,bx
		
		mov cx,contador			;Asigna
		lea si,ArMultiplicador
		lea di,ArNumero
		
		DivideySuma:
			DivideySumaMacro ax,bx,dx,si,di,Acumulador		
		loop DivideySuma	
			
		mov [di], byte ptr"$"
	RET

end Inicio