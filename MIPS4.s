.text
main:	addi $s0, $zero,1
	addi $s1, $zero,10
	addi $s2, $zero,5
	add $s0, $s0, $s2
	sll $s0,$s0,2
	add $s1,$s1,$s2
	sll $s1,$s1,3
	add $s0,$s0,$s1
	
	