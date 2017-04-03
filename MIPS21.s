.text
main:
	li $v0, 5
	syscall
	move $a0, $v0
	sll $a0, $a0, 2
	addi $a0, $a0, 1
	li $v0, 1
	syscall
	li $v0, 10
	syscall