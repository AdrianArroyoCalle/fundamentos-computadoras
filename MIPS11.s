# f = $t0
# g = $t1
.text

main:
	addi $t0, $zero, 20
	addi $t1, $zero, 20
	beq $t0, $t1, equal
	addi $t0, $zero, 4
	sub $t0, $t0, $t1
	j ok
equal:
        addi $t0, $t1, 4
ok:
	li $v0, 10
	syscall