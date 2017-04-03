.data
Vector: .word 0,0,0,0,0,0,0,0,0,0
.text
main:
	#inicializar vector
	la $t0, Vector
	addi $t1, $zero, 1
	addi $t2, $zero, 1024
loop:
	sw $t1, 0($t0)
	sll $t1, $t1, 1
	addi $t0, $t0, 4
	bne $t1, $t2, loop
	#operacion
	la $t0, Vector
	lw $t1,16($t0)
	lw $t2, 32($t0)
	add $t1, $t1,$t2
	sw $t1, 36($t0)