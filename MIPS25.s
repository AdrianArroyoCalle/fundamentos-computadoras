.data
#String: .asciiz "Monty Pyhton lives forever"
#A: .asciiz "Bastida no pongas examenes tan largos"
Mensaje: .asciiz "Introduzca una cadena\n"
Mensaje2: .asciiz "Cuantas veces quieres repetir la frase?\n"
HUECO_A: .space 100
HUECO_B: .space 4224
.text
main:
	la $a0, Mensaje
	li $v0, 4
	syscall
	li $v0, 8
	la $a0, HUECO_A
	li $a1, 4224
	syscall
	
	jal mayuscula
	
	la $a0, Mensaje2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $a0, HUECO_A
	la $a1, HUECO_B
	move $a2,$v0
	jal multiplicar_cadenas
	
	li $v0, 4
	la $a0, HUECO_B
	syscall
	
	li $v0, 10
	syscall

# METODO: MAYUSCULA

mayuscula:
	lb $t2, 0($a0)
	slti $t0, $t2, 91 # Comprobamos si es mayuscula
	bne $t0, $zero, anadir
	addi $t2, $t2, -32 # Si es minuscula le bajamos reducimos 32 posiciones
anadir:
	sb $t2, 0($a0)
	addi $a0, $a0, 1
	bne $zero, $t2, mayuscula
	jr $ra

# METODO: MULTIPLICAR STRING
multiplicar_cadenas:
	li $t1,0
loop:
	lb $t0, 0($a0)
	sb $t0, 0($a1)
	addi $t1,$t1,1 # contar letras
	addi $a0,$a0,1 # pasamos al siguiente caracter lectura
	addi $a1,$a1,1 # pasamos al siguiente caracter escritura
	bne $0,$t0,loop
	addi $a1,$a1,-1
	addi $a2,$a2,-1 # Ya hemos hecho una copia
	sub $a0, $a0, $t1
	bne $a2, 0,multiplicar_cadenas
	jr $ra
	
	
	
	