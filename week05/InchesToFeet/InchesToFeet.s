#
# Program Name: FeetToInches.s
# Author: Akin Williams
# Date: 9/20/2022
# Purpose: This program performs a conversion from inches to feet.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Read the user integer value
	LDR r0, =prompti
	BL printf
	LDR r0, =format
	LDR r1, =inch
	BL scanf

	# Divide by immediate value
	LDR r0, =inch
	LDR r0, [r0]
	MOV r1, #12
	BL __aeabi_idiv
	MOV r4, r0

	# Calculate the quotient multiple
	MUL r5, r4, r1

	# Subtract the quotient multiple for a remainder
	LDR r0, =inch
	LDR r0, [r0]
	SUB r6, r0, r5

	# Print the result
	LDR r0, =output
	MOV r1, r4
	MOV r2, r6
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	inch:		.word	0
	prompti:	.asciz "\nEnter an integer for inches: "
	output: 	.asciz "\nThat is %d\' feet and %d\" inches.\n"
	format: 	.asciz "%d"

