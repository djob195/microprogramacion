Factorial MACRO a,resp
    mov si,0
    cmp a,0
    jne else
        jmp fin   
    else: 
        mov si, a
        fac:  
            mov ax, si
            mul resp 
            mov resp, ax 
            dec si
            cmp si ,0
        jne fac
    jmp fin
    fin:
ENDM  

exponente macro base, exp, res  
    mov aux2, 1
    cmp exp, 0
    jne realizar
        mov res,1
    jmp fin2
    realizar:
    mov si, 0
    mov si,exp 
    exponenciar:
        mov ax, aux2
        mul base
        mov aux2, ax
        dec si
        cmp si,0
    jne exponenciar 
    mov dx, base
    mov res, dx  
    fin2:
    
endm
     
dividir macro arriba, abajo, cos, res
    mov dx,0
    mov ax, arriba
    div abajo
    mov cos, ax
    mov res, dx
endm     
     
PrintNumero Macro numero, salida
    mov di, 4H
    imprimiendo:
       mov cx, 0AH
       mov aux, di
       exponente cx, di, bx  
       mov di, aux
       mov dx,0
       mov ax, numero 
       div bx
       mov numero, dx
       mov cx, di
       mov bx, 4H 
       sub bx, di
       mov di, bx
       add ax, 30h
       mov salida[di], ax
       mov di, cx
       dec di
       cmp di, -1
    jne imprimiendo
Endm 
		

; multi-segment executable file template.
.model small
.stack
.data  
    error1 db 'Error no se puede ingresar un numero mayor a 8 y menor a cero',10,13, '$'
    inst1 db 'Ingrese un numero de 1 al 8',10,13, '$'    
    inst2 db 'El factorial es = ',10,13, '$'   
    resultado dw 1
    total dw 8 dup('$')
    aux dw 0 
    aux2 dw 1
.code
    mov ax, @data
    mov ds, ax 

    mov di, 4H
    mov cx, 0AH
    
    ; add your code here  
    lea dx, inst1
    mov ah, 09
    int 21h
    
    mov si, 00h
    mov ax, 00h
    mov ah, 01h 
    int 21h
    
    sub al, 30h
    mov ah, al  
    sub ah,9h
    jge error
    mov ah, 0 
    Factorial ax,resultado   
    PrintNumero resultado, total    
    
    lea dx, inst2
    mov ah, 09
    int 21h   
    
    mov dx,offset total  ;Imprime el contenido del vector con la misma instrucción de una cadena
    mov ah,09h
    int 21h   
    jmp noerror
        
    error:
    lea dx, error1
    mov ah, 09
    int 21h 
    
    noerror:
    mov ah, 4ch ; exit to operating system.
    int 21h    


end  ; set entry point and stop the assembler.
