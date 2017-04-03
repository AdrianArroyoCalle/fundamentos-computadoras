.data
F: .word 1
G: .word 10
H: .word 5

.text
main:	#la $t3, F
	lw $t0, F
	#la $t1, G
	lw $t1, G
	#la $t2, H
	lw $t2, H
	add $t1, $t1, $t2
	addi $t1, $t1, -2
	sub $t0, $t0, $t1
	sw $t0, F