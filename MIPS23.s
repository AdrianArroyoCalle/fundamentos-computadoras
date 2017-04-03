.text
main:
	li $v0, 5
	syscall
	move $a0,$v0
	jal suma_pares
	move $a0, $v0
	li $v0,1
	syscall
	li $v0,10
	syscall

suma_pares:
	li $v0,0
	addi $a0, $a0, -1
	li $t1,0
loop:
	addi $t1,$t1,2
	add $v0,$v0,$t1
	addi $a0,$a0,-1
	bne $0,$a0,loop
	jr $ra