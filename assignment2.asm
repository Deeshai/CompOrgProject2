# Deeshai Escoffery - 11/15/2017
# Hexadecimal to Decimal Converter

#Begin

.data

	error_msg: .asciiz "NaN"    #error message for invalid hexadecimal
	output_line: .asciiz "\n"			  #stores new line for output
	input: .space 1001				#space for characters (1000 + 1)
	
	
.text

main:

	addi $t8, $zero, 16
	addi $t4, $zero, 0
	addi $t2 $zero, 0

	la $a0, input
	li $v0, 4
	syscall
	
	
get_input:
	la $a0, input
	li $a1, 1001
	li $v0, 8
	syscall
	
	add $t0, $zero, $a0
	
getLocation:
	lb $t1,0($t0)
	beqz $t1, end
	beq $t1, 10, end
	beq $t1, 9, step
	beq $t1, 32, step
	beqz $t2, setFirstPointer
	beq $t1, 44, setLastPointer
	
setFirstPointer:
	add $t2, $zero, $t0
	j step
	
	
setLastPointer:
	add $t4, $zero, $t0
	add $s0, $zero, $t0
	addi $t4, $t4, -1
	j validateCurrWord
	
validateCurrWord:
	lb $t1, 0($t2)
	
step:
	addi $t0, $t0, 1
	j getLocation
	

subprogram1:

subprogram2:

subprogram3:
