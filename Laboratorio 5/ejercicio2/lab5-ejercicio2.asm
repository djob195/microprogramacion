.model small
.stack
.data
	primero db 10,13, 'Ingresa la Primera palabra:', 10, 13, '$' 				; Muestra la primera palabra
	segundo db 10,13, 'Ingresa la segunda palabra:', 10, 13, '$'				; Muestra la segunda palabra
	igual db 10,13, 'Son iguales', 10, 13, '$'								; Muestra si son iguales
	nigual db 10,13, 'no son iguales:', 10, 13, '$'							; Muestra si no son iguales
	vtext1 db 100 dup('$')														; Vector 100 bytes que almacena la primera paralbra
	vtext2 db 100 dup('$')														; Vector de 100 bytes que almcana la segunda palabra

.code																; inicio del còdgio
	mov ax, @data;													Respalda los datos
	mov ds, ax;														y los almacena en el registro ds (Es decir no se pierde los datos)
	
	lea dx, primero												; Imprime  el mensaje de la primera palabra
	mov ah, 09													; Asigna al registro correspondiete la imrpesion
	int 21h														; interrumpcion de pantalla para imprimir
	
	mov si, 00h														;Iniciamos contador a 00h
	mov ax, 0;														;Limpiamos registro
	mov ah, 01h;													;Mueve el cursor
	leer:
		int 21h;													Interrumpcion de pantalla
		cmp al, 0dh;												Verifica si ha presionado enter
		je salir1;													Sale si son iguales (Enter)
		mov vtext1[si],al;											guardamos el valor del teclado
		inc si;														Incrementa el contador
		jmp leer;													salta a leer1
	
	salir1:															; etiqueta de salida1

			lea dx, segundo												; Imprime el mensaje de la segunda palabra
			mov ah, 09													; Asigna al registro correspondiete la imrpesion
			int 21h														; interrumpcion de pantalla para imprimir
	
			mov di, 00h													;Iniciamos contador a 00h
			mov ax, 0;													;Limpiamos registro
			mov ah, 01h;													;Mueve el cursor
			
			leer2:
					int 21h;													Interrumpcion de pantalla
					cmp al, 0dh;												Verifica si ha presionado enter
					je salir2;													Sale si son iguales (Enter)
					mov vtext2[di],al;											guardamos el valor del teclado
					inc di;														Incrementa el contador
					jmp leer2;													salta a leer2
					
	salir2:
	
		mov cx,100;	 							Determina la cantidad de datos a comparar
		mov ax,ds;								Se le asigna espacio al registro ax (100)
		mov es, ax;								Realiza la comparacion compare to			
		
		lea si, vtext1;		Lee cadena1
		lea di, vtext2;		lee cadena2
		repe cmpsb;			compara cadenas
		je iguales; salta si son iguales
			lea dx, nigual;														msj no son iguales
			mov ah, 09;															Prepara para imprimir
			int 21h;															Muestra el mensaje correspondiente
		jmp fin;																salta al fin
		
		iguales:	
			lea dx, igual;												lee el msj de iguales
			mov ah, 09;													Prepara para imprimir
			int 21h;													Muestra el mensaje correspondiente

	fin:
	mov ah,4ch
	int 21h
end	
	