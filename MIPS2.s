.text
main:	addi $s0, $zero, 1
	addi $s1, $zero, 10
	addi $s2, $zero, 5
	add $s1, $s1, $s2
	addi $s1, $s1, -2
	sub $s0, $s0, $s1
