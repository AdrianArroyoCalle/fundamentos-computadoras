.data
A: .word 10
B: .word 5
C: .word 6,7,8,9,10,11,12,13,14,15
.text
main:
	lw $t0, A
	lw $t1, B
	add $t0, $t0, $t1
	addi $t0, $t0, 1
	la $t1, C
	sw $t0, 16($t1)