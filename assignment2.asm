# Deeshai Escoffery - 11/15/2017
# Hexadecimal to Decimal Converter

#Begin

.data

	error_msg: .asciiz "NaN"    #error message for invalid hexadecimal
	too_large_msg: .asciiz "too large"
	output_line: .asciiz "\n"			  #stores new line for output
	input: .space 1001				#space for characters (1000 + 1)
	
	
.text

main:

	addi $t8, $zero, 16
	addi $t3, $zero, 0
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

	li $t2, 0
	li $t4, 0
	li $s1, 0
	
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
	add $s1, $zero, $t0
	addi $t4, $t4, -1
	j validateCurrWord
	
validateCurrWord:
	lb $t1, 0($t2)

	check_lower_maximum:

	blt $t2, 103, check_lower_minimum		#If within max then jump to check if it is in the min.
	j invalid_hex				#If outside then it is invalid.
	
	check_lower_minimum:

	bgt $t2, 96, nextChar		#If withn min then jump to store decimal value.
	j check_upper_maximum			#If less than min then check if uppercase.
	
	check_upper_maximum:
	
	blt $t2, 71, check_upper_minimum		#If withn min then jump to store decimal value.
	j invalid_hex				#If outside then it is invalid
	
	check_upper_minimum:

	bgt $t2, 64, nextChar		#If withn min then jump to store decimal value.
	j check_number_maximum				#If less than min then check if number.
	
	
	check_number_maximum:

	blt $t2, 58, check_number_minimum		#If within max then check min.
	j invalid_hex				#If outside of max then invalid.
	
	check_number_minimum:

	bgt $t2, 47, nextChar		#If within min then jump to store decimal value.
	j invalid_hex				#If outside of min then invalid.				

invalid_hex:
	li $t2, 0
	li $t4, 0
	li $s1, 0

	li $v0, 4
	la $a0, too_large_msg
	syscall
	j getLocation

step:
	addi $t0, $t0, 1
	j getLocation

nextChar:
	addi $t3, $t3, 1
	bgt $t3, 8, invalid_hex
	addi $t2, $t2, 1
	#beq $t2, $s1, subprogram2


subprogram1:

subprogram2:

subprogram3:

end:

	li $v0, 10					#End program.
	syscall
