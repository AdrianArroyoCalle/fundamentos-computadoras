.data
A: .asciiz "Feliz 42"
DESTINO: .space 40
.text
main:
	la $t0, A
	addi $t0, $t0, 2 # B - Se salta los dos primeros caracteres
	la $t2, DESTINO
loop:
	lb $t3, 0($t0)
	sb $t3, 0($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	bne $t3, $zero, loop 
	li $v0, 10
	syscall
	
	
	