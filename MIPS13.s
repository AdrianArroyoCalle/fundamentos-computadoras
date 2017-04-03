.data
C: .word 0,0,0,0,0,0,0,0,0,0,10,0
.text
main:
	addi $t0, $zero, 10
	addi $t1, $zero, 2
	la $t2, C
loop:
	lw $t3, 0($t2)
	addi $t2, $t2, 4
	bne $t0, $t3, loop
	li $v0, 10
	syscall