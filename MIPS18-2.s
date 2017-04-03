# Arroyo Calle, Adrián

# Entregable MIPS
.data
A: .asciiz "Bastida es bueno"
B: .space 40
.text
main:
	la $t0, A
	la $t2, B
	#sub $t5, $t2, $t0
	#add $t2, $t2, $t5
	addi $t9, $zero, 32
ir_al_final:
	lb $t1, 0($t0)
	addi $t0,$t0,1
	bne $t1, $zero, loop	
loop:
	lb $t1, 0($t0)
	beq $t9, $t1, es_un_espacio
	sb $t1, 0($t2)
	addi $t2, $t2, 1
es_un_espacio:
	addi $t0, $t0, -1
	bne $t1, $zero, loop
	 