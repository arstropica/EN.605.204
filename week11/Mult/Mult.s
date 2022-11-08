#
# Program Name: Mult.s
# Author: Akin Williams
# Date: 11/07/2022
# Purpose: Prints the product of two user defined integers.
#
# Functions defined:
# 	- main
# 	- mult
#
# Changes: 11/07/2022 - Initial release
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt user for first value and read integer value
	LDR r0, =prompt1
	BL printf
	LDR r0, =format
	LDR r1, =num_1
	BL scanf

	# Prompt user for second value and read integer value
	LDR r0, =prompt2
	BL printf
	LDR r0, =format
	LDR r1, =num_2
	BL scanf

	# Load input values and branch to function
	LDR r0, =num_1
	LDR r0, [r0]
	LDR r1, =num_2
	LDR r1, [r1]
	BL mult

	# Store the return value in register
	MOV r3, r0

	# Print the result
	LDR r0, =output
	LDR r1, =num_1
	LDR r1, [r1]
	LDR r2, =num_2
	LDR r2, [r2]
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	num_1:		.word	0
	num_2:		.word	0
	format:		.asciz	"%d"
	prompt1:	.asciz	"Enter first integer: "
	prompt2:	.asciz	"Enter second integer: "
	output:		.asciz	"%d x %d = %d.\n"
# End main
#
#
# Function: mult
# Purpose: Recursive program that calculates multiplication using successive addition.
#
# Note: mult is implemented as a static function, not a global symbol.
#
# Input:	r0 - first integer
#			r1 - second integer
#
# Output:	r0 - multiplication result
#
.text
mult:
	# Program Dictionary:
	#	r4 - input value

	# Push the stack record
	SUB sp, sp, #8
	STR lr, [sp, #0]
	STR r4, [sp, #4]							// save preserved register

	# Save first operand
	MOV r4, r0

	# If block
	MOV r2, #1
	CMP r1, r2									// if (n == 1) return m
	BNE Else
		B EndIf

	Else:
		SUB r1, r1, #1							// r1 = n - 1
		BL mult									// r0 = mult(m, n - 1)
		ADD r0, r4, r0							// r0 = m + mult(m, n - 1)
		B EndIf

	EndIf:
		B Return								// trivial

	# Pop the stack record and return
	Return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]						// restore preserved register
		ADD sp, sp, #8
		MOV pc, lr
.data
# End mult

