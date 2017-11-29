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

	la $a0, input
	li $v0, 4
	syscall
	
	la $a0, input
	li $a1, 1001
	li $v0, 8
	syscall
	
	add $t0, $zero, $a0
	
	addi $s0, $zero, 0
	
	addi $s1, $zero, 32
	
string_check:
	lb $t2, 0($t0)
	beqz $t2, end
	beq $t2, 10, end
	beq $t2, 44, comma
	

	
check_lower_maximum:

	blt $t2, 103, check_lower_minimum		#If within max then jump to check if it is in the min.
	j ignore				#If outside then it is invalid.
	
check_lower_minimum:

	bgt $t2, 96, store_lower_value		#If withn min then jump to store decimal value.
	j check_upper_maximum			#If less than min then check if uppercase.
	
store_lower_value:

	addi $t3, $t2, -87			#Store decimal in $t3.
	j ignore				#Jump to next character.
	
check_upper_maximum:
	
	blt $t2, 71, check_upper_minimum		#If withn min then jump to store decimal value.
	j invalid			#If outside then it is invalid
	
check_upper_minimum:

	bgt $t2, 64, store_upper_value		#If withn min then jump to store decimal value.
	j check_number_maximum				#If less than min then check if number.
	
store_upper_value:

	addi $t3, $t2, -55			#Store decimal in $t3.
	j ignore				#Jump to next character.
	
check_number_maximum:

	blt $t2, 58, check_number_minimum		#If within max then check min.
	j invalid				#If outside of max then invalid.
	
check_number_minimum:

	bgt $t2, 47, store_num_value		#If within min then jump to store decimal value.
	j invalid				#If outside of min then invalid.				
		
store_num_value:
	
	addi $t3, $t2, -48			#Store decimal in $t3.
	j ignore				#Jump to next character.
	
	
ignore:
	addi $t0, $t0, 1
	j next_string
	
comma:
	beqz $s0, invalid
	beq $s1, 44, invalid
	j next_string
	
next_string:
	addi $t0, $t0, 1
	j string_check
	
	
invalid:

	la $a0, error_msg				
	li $v0, 4					
	syscall
	li $s0, 0
	addi $s1, $zero, 44
	j next_string
	
	
end:
	li $v0, 10
	syscall


subprogram1:

subprogram2:

subprogram3:
