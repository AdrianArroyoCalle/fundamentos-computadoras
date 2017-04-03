.data
C: .word 0,0,0,0,0,0,0,0,0,0,0
.text
main:
	addi $t0, $zero,0
	addi $t2,$zero,10
	la $t3,C
loop:
	addi $t0,$t0,1
	addi $t3,$t3,4
	lw $t4,0($t3)
	sll $t5,$t0,1
	sw $t5,0($t3)
	slt $t1,$t0,$t2
	bne $t1, $zero,loop
	li $v0,10
	syscall
	 
