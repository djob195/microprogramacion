;Diego José Orellana -1010114
.model small
.stack
.data
	v1 db ?
	v2 db ?
	suma db 0
	resta db 0
	multiplicacion db 1
	division db 1
.code
.startup
	mov ah, 01h;			Leer caracter desde el teclado
	int 21h;				lee primer caracter
	
	sub al, 30h;			Resto 30H (48D) para obtener el numero
	mov v1, al;				Guarda la variable 1
	
	mov ah, 01h;			Lee el caracter del teclado
	int 21h;				lee el segundo variable
	sub al, 30h;			Resto las hexadecimal
	mov v2, al;				se le asigno la segunda variable
	
	add suma, v1;			suma +=v1
	add suma, v2;			suma +=v2
	
	add resta, v1;			resta+=v1
	sub resta, v2;			resta-=v2 (v1-v2=resta)
	
	mov al, v1;				al=v1
	mov multiplicacion, v2;	multiplicacion = v2
	mul multiplicacion;		al*=multiplicacion
	mov multiplicacion, al;	multiplicacion = al
	
	mov dl, suma;			dl=suma
	add dl, 30h;			Obtengo el numero en decimal
	mov ahm 02h;			funcion a imprimir
	int 21h;
	
	mov dl, resta;			dl=resta
	add dl, 30h;			Obtengo el numero en decimal
	mov ahm 02h;			funcion a imprimir
	int 21h;
	
	mov dl, multiplicacion;	dl=suma
	add dl, 30h;			Obtengo el numero en decimal
	mov ahm 02h;			funcion a imprimir
	int 21h;
	.exit
end