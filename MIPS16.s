.data
A: .word 1,2,3,4,5,6,7,8,9,10
B: .word 10,9,8,7,6,5,4,3,2,1
C: .word 0,0,0,0,0,0,0,0,0,0
.text
main:
	la $t0,A
	la $t1,B
	la $t2,C
	addi $t5,$zero,10
loop:
	lw $t3,0($t0)
	lw $t4,0($t1)
	add $t3,$t4,$t3
	sw $t3,0($t2)
	addi $t0,$t0,4
	addi $t1,$t1,4
	addi $t2,$t2,4
	addi $t5, $t5, -1
	bne $t5, $0, loop
	li $v0,10
	syscall