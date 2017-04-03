.text
main:
	li $v0, 5
	syscall
	li $a0,0 
	move $t0,$v0
	addi $t0, $t0, -1
	li $t1,0
loop:
	addi $t1,$t1,2
	add $a0,$a0,$t1
	addi $t0,$t0,-1
	bne $0,$t0,loop
	li $v0,1
	syscall
	li $v0,10
	syscall
