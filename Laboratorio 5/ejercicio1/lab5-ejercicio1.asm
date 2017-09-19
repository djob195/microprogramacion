.model small
.stack
.data
	nombre db 10,13, 'Ingresa tu nombre:', 10, 13, '$' 				; Cadena que indica que muestre su nombre
	mayuscula db 10,13, 'Su nombre en mayuscula es:', 10, 13, '$'	; Su nombre en mayuscula es
	vtext db 100 dup('$')											; Declaracion de vector de 100 b
	aux db ?;														variable auxiliar que guarda el caracter mayuscula

.code																; inicio del còdgio
	mov ax, @data;													Respalda los datos
	mov ds, ax;														y los almacena en el registro ds (Es decir no se pierde los datos)
		lea dx, nombre												; Aparta espacio de memoria de cadena nombre
		mov ah, 09													; Preparam impresiòn
		int 21h														;interrumpcion de pantalla para imprimir
	
	mov si, 00h														;Iniciamos contador a 00h
	mov ax, 0;														Limpiamos registro
	mov ah, 01h;													Mueve el cursor
	leer:
		int 21h;													Interrumpcion de pantalla
		cmp al, 0dh;												Verifica si ha presionado enter
		je salir;													Sale si son iguales
		mov bl, al;													bl=al
		mov aux, bl 												;aux=bl=al
		sub aux, 20h												; se le resta el offset correspondiente de minuscula a mayuscula										
		mov bl, aux;												bl=aux
		mov vtext[si],bl;											guardamos el valor del teclado
		inc si;														Incrementa el contador
		jmp leer;													salta a leer
	
	salir:															; etiqueta de salida														
		lea dx, mayuscula;											lee el mensaje de mayuscula
		mov ah, 09;													Prepara para imprimir
		int 21h;													Muestra el mensaje correspondiente
		
		mov dx, offset vtext;										Lee la cantidad de caracteres del texto
		mov ah, 09;													Mueve a la cola el texto a imrpimir
		int 21h; 													Interrumpcion que imprime el registro ah

	mov ah,4ch
	int 21h
	
end	
	