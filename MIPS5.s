.data
F: .word 1
G: .word 10
H: .word 5
.text
main:	lw $t0, F
	lw $t1, G
	lw $t2, H
	add $t0, $t0, $t2
	sll $t0,$t0,2
	add $t1,$t1,$t2
	sll $t1,$t1,3
	add $t0,$t0,$t1
	sw $t0, F