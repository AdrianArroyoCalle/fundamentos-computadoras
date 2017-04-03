.text
main:
	addi $s5, $zero, 0
	addi $s3, $zero, 10
loop:
	add $s5, $s3, $s5
	addi $s3, $s3, -1
	bne $s3, $zero, loop
	li $v0, 10
	syscall