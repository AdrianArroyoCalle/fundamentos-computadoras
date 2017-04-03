.data
A: .asciiz "Bosque deja los barcos"
B: .space 42
.text
main:
	la $a0, A
	la $a1, B 
	jal copia_cadena
	li $v0, 10
	syscall
copia_cadena:
lOOP:
	lb $t0, 0($a0)
	sb $t0, 0($a1)
	addi $a0,$a0,1
	addi $a1,$a1,1
	bne $0,$t0,lOOP
	jr $ra
	
	