.model small
.stack
.data
	fact db 0 	; variable factorial
	dis db ?	; Variable la cual almacena los contadores que disminuye
	aux db ?	; variable auxiliar que permitira almacenar valores de operaciones
.code
programa:
	
	mov ah, 01h;  leer el carácter desde el teclado
	int 21h; 	se elimina el caracter enter
	
	sub al, 30h; se convierte  el número décimal
	mov aux, al;	se almacena en factorial
	
	mov fact,1 ;Factorial es 1
	cmp aux, 0; compara si es factorial de cero
	je factorial0; salta a factorial de cero
	mov fact,0; se reinicia el valor de cero
	call factorial; llama la funcion factorial
	
	factorial0:
		mov dl, fact; dl = factorial
		add  dl, 30h ;  se le suma el desplazamiento 
		mov ah, 02h; Se le suma el enter
		int 21h ;imprime caracter

;----------------Procedimientos--------------------------
	multiplicar proc near
		mov cl, dis; 	contador de for = aux
		multiplicacion:	; loop de multiplciacion
			mov al, dis; al = fact
			add fact,al;	se le adiciona al factorial
		loop multiplicacion
	multiplicar endp
	
	factorial proc near
		factores:
			mov dis, cl; Se obtiene el valor dismunido
			call multiplicar ; Se multiplica valor
			sub dis, 1; se disminuye 1 el contador
			JE factores
	factorial endp
end programa


