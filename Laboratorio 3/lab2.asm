.model small
.stack
.data
	v1 db ? 	;divisor 
	v2 db ?		;dividiendo
	vdiv db ?	; resta de dividiendo
	residuo db ?	; almacena residuo
	vcontador db 0	; almacena cociente
	aux db ?	; verifica si divisor > dividiendo
.code
programa:
	mov AX, @DATA
	
	mov ah, 01h;  leer el carácter desde el teclado
	int 21h; 	lee primer caracter
	
	sub al, 30h; resto 30H (48 dec) para obtener el número
	mov v1, al;	v1=caracter leido divisor
	
	mov ah, 01h;  leer el carácter desde el teclado
	int 21h; 	lee primer caracter
	
	sub al, 30h; resto 30H (48 dec) para obtener el número
	mov v2, al;	v1=caracter leido dividiendo
	cmp v2, 0;	COMPARA SI ES DIVISION INDEFINIDA
	JE fin;	SI LO ES SOLO REALIZA LA MULTIPLICACION
	
	mov ah, v1
	mov aux, ah;	aux = divisor
	
	sub aux,al; 	divisor-dividiendo
	JG sincociente;	sin cociente
	
	mov ah, v2; ah= v2
	mov vdiv, ah  ; vdiv = ah = dividiendo


	division:	;Etiqueta de division
	add vcontador,1	; aumenta el residuo
	mov bh, v1	; ah=divisor
	mov al, vdiv	;al =vdiv
	mov residuo, al	; residuo=al=vdiv
	sub vdiv, bh	; vdiv-=v1
	
	JGE division; salta si es menor a cero 
		
	sub vcontador,1 ;Reduce el contador para saber el cociente
	
	mov dl, vcontador; cociente
	add  dl, 30h ; agrego la cantidad correspondiente
	mov ah, 02h; funcion para imprimir un caracter
	int 21h ; imprime el cociente
	
	mov dl, residuo; residuo
	add  dl, 30h ; agrego la cantidad correspondiente
	mov ah, 02h; funcion para imprimir un caracter
	int 21h ; imprime el cociente
	jmp fin
	
	sincociente:
	mov dl, 0; cociente
	add  dl, 30h ; agrego la cantidad correspondiente
	mov ah, 02h; funcion para imprimir un caracter
	int 21h ; imprime el cociente
	
	mov dl, v2; residuo
	add  dl, 30h ; agrego la cantidad correspondiente
	mov ah, 02h; funcion para imprimir un caracter
	int 21h ; imprime el cociente
	
	fin:
	mov cl, v1; 	contador=v1
	mov aux, 0;	aux=0

	multiplicacion:
	mov al, v2;	AL=V2
	add aux,al;	aux+=al=v2
	loop multiplicacion

	mov dl, aux; multiplicacion
	add  dl, 30h ; agrego la cantidad correspondiente
	mov ah, 02h; funcion para imprimir un caracter
	int 21h ; imprime el cociente
end programa