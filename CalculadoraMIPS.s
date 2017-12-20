.data
operandos: .space 32 # $s1
operadores: .space 32 # $s0
input: .space 15
mensaje: .asciiz "Introduzca una cadena de operaciones:"
salida: .space 16
tmp: .space 16

.macro push(%stack,%val)
        sw %val, 0(%stack)
        addiu %stack, %stack, 4
.end_macro

.macro pop(%stack,%val)
        subiu %stack, %stack, 4
        lw %val, 0(%stack)
.end_macro

.macro print_int(%int)
        li $v0, 1
        add $a0, $zero, %int
        syscall
.end_macro

.macro print_str(%str)
        la $a0, %str
        li $v0, 4
        syscall
.end_macro

.macro exit()
        li $v0, 10
        syscall
.end_macro

.macro read_str(%vector, %size)
        li $v0, 8
        la $a0, %vector
        li $a1, %size
        syscall
.end_macro

.text
main:
	print_str(mensaje)
        li $t6,10
        la $s0, operandos # PUNTERO A LA PILA DE OPERADORES, no se modifica fuera de las macros bajo pena de excomunion
        la $s1, operadores # PUNTERO A LA PILA DE OPERANDOS, no se modifica fuera de las macros bajo pena de excomunion
        read_str(input,158)
        la $a0, input
        jal quitar_espacios
        #teqi $zero, 0
        la $s2, input
        li $s4, 0 # numero temporal
bucle_de_lectura:
        lb $s3, 0($s2)
        # comprobar si es numero
        beq $s3, 'x', activar_hexadecimal
        bge $s3, '0', numero
        beq $s3, '-', fin_numero
        beq $s3, '+', fin_numero
        beq $s3, '*', fin_numero
        beq $s3, '/', fin_numero
        beq $s3, ')', fin_numero
        beq $s3, '(', continuar_de_operacion_prioritaria
        beq $s3, '\n', fin_numero
        # siguiente caracter
continuar:
        addi $s2, $s2, 1
        bne $s3, '\n', bucle_de_lectura
        # realizar las sumas y restas restantes
        pop($s1,$zero)
        jal sumar
        teqi $v1, 1
        # obtener resultado final y mostrar en pantalla
        pop($s0,$t0)
        #print_int($t0) # TODO: Esto, mensajes, errores de 1*-1, hexadecimal, overflows
        move $a0, $t0
        la $a1, tmp
        jal binario_to_decimal_ascii
        #print_str(tmp)
        la $a0, tmp
        la $a1, salida
        jal invertir
        print_str(salida)
        exit()

fin_numero:  
        li $t6,10
        pop($s1,$t0)
        beq $t0, '-', oponer_numero
continuar_oponer_numero:
        push($s0,$s4) # anadir numero a la pila  
        beq $t0,'*',operacion_prioritaria
        beq $t0,'/',operacion_prioritaria
        push($s1,$t0)
continuar_de_operacion_prioritaria:
	beq $s3,')', colapsar_parentesis
        push($s1,$s3)
        li $s4, 0
continuar_de_colapsar_parentesis:
        
        b continuar
oponer_numero:
	sub $s4, $zero, $s4
	b continuar_oponer_numero

operacion_prioritaria:
	pop($s0,$t1)
	pop($s0,$t2)
	beq $t0,'/',division
	mul $t1,$t1,$t2
	mfhi $t7
	beq $t7, $zero, no_es_overflow
	beq $t7, 0xffffffff, no_es_overflow
	teq $zero, $zero
no_es_overflow:
	push($s0,$t1)
	b continuar_de_operacion_prioritaria
division:
	div $t2,$t1
	mflo $t1
	push($s0,$t1)
	b continuar_de_operacion_prioritaria

colapsar_parentesis:
	jal sumar
	teqi $v1, 0
	pop($s0,$s4)
	b continuar_de_colapsar_parentesis
	
numero:
	beq $t6,16,hex
        bgt $s3, '9', error
        addi $s3,$s3,-48
        b continuarhex
hex:
	blt $s3, '0', error
	bgt $s3, 'f', error
	bgt $s3, '9', check_error
continue:
	bgt $s3, 'F', check_error2
continue2:
	sub $s3, $s3, 55
	bge $s3, 3, no_es_numero_idiota
	addi $s3, $s3, 7
no_es_numero_idiota:
	ble $s3,15,no_es_minuscula_idiota
	addi $s3,$s3,-32
no_es_minuscula_idiota:
	b continuarhex
check_error:
	blt $s3, 'A', error
	b continue
check_error2:
	blt $s3, 'a', error
	b continue2       
continuarhex:        
        mul $s4, $s4, $t6
        mfhi $t7
	beq $t7, $zero, no_es_overflow2
	beq $t7, 0xffffffff, no_es_overflow2
        add $s4, $s4, $s3
        li $s3, 1	#Para evitar problemas con el valor a sea igual al valor ascii de \n
        b continuar
error:
        teq $zero, $zero
activar_hexadecimal:
	la $t1, input	#Comprobar que pone 0x y no otra cosa rara
	beq $s2,$t1,error
	lb $t0, -1($s2)		
	bne $t0, '0', error
	addi $t1,$t1,1
	beq $t1,$s2, correcto
	lb $t0, -2($s2)
	beq $t0, '-', correcto
        beq $t0, '+', correcto
        beq $t0, '*', correcto
        beq $t0, '/', correcto
        beq $t0, '(', correcto
	b error
correcto:
	li $t6,16
	b continuar
# FUNCION SUMAR: Suma en Notacion Polaca Inversa  (destruye las pilas)
sumar:
	la $t3, operandos
bucle:
	beq $s0, $t3, fin_suma
	pop($s1,$t2)
	beq $t2, '(', fin_suma_par
	pop($s0,$t0)
	pop($s0,$t1)
	add $t0, $t0, $t1
	push($s0,$t0)

	b bucle
fin_suma:
	li $v1, 0
	jr $ra
fin_suma_par:
	li $v1, 1
	jr $ra

# QUITA LOS ESPACIOS DE UNA CADENA - PUNTERO A CADENA EN $a0
quitar_espacios:
        move $t0, $a0
bucle_quitar_espacios:
        lb $t1, 0($a0)
        bne $t1, ' ', no_es_espacio
        b comprobar_fin
no_es_espacio:
        sb $t1, 0($t0)
        addi $t0, $t0, 1
comprobar_fin:
        addi $a0, $a0, 1
        bne $t1, $zero, bucle_quitar_espacios
        jr $ra
        
# BINARIO TO DECIMAL ASCII        
        
binario_to_decimal_ascii:
	move $t0, $a0
bucle_3:
	li $t1, 10
	div $t0, $t1 # LO cociente, HI resto
	mfhi $t1 # resto 
	mflo $t0 # cociente
	addi $t1, $t1, 48
	sb $t1, 0($a1)
	addi $a1, $a1, 1
	bgt $t0, 9, bucle_3
	addi $t0, $t0, 48
	sb $t0, 0($a1)
	li $t9, '\0'
	sb $t9, 1($a1)
	jr $ra

invertir:
	move $t0, $a0
	move $t2, $a1
	addi $t9, $zero, 32
ir_al_final:
	lb $t1, 0($t0)
	addi $t0,$t0,1
	bne $t1, $zero, ir_al_final
	addi $t0, $t0, -2
loop2:
	lb $t1, 0($t0)
	beq $t9, $t1, es_un_espacio
	sb $t1, 0($t2)
	addi $t2, $t2, 1
es_un_espacio:
	addi $t0, $t0, -1
	bne $t1, $zero, loop2
	move $v1, $t1
	jr $ra
# EXCEPCIONES

.ktext 0x80000180
        print_str(msg)
        mfc0 $k0, $14
        addi $k0, $k0, 4
        mtc0 $k0, $14
        exit()
        eret
.kdata
        msg: .asciiz "ERROR: Vuelve a introducir una expresion correcta o que no provoque overflow"
