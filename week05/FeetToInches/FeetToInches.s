#
# Program Name: FeetToInches.s
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program performs a conversion from feet to inches.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Read first integer value
	LDR r0, =promptf
	BL printf
	LDR r0, =format
	LDR r1, =feet
	BL scanf

    # Read second integer value
    LDR r0, =prompti
    BL printf
    LDR r0, =format
    LDR r1, =inch
    BL scanf

	# Multiply by immediate value
	LDR r0, =feet
	LDR r0, [r0]
	MOV r1, #12
	MUL r4, r0, r1

	# Add second integer value
	LDR r5, =inch
	LDR r5, [r5]
	ADD r6, r4, r5

	# Print the result
	LDR r0, =output
	MOV r1, r6
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	feet:		.word	0
	inch:		.word	0
	promptf:	.asciz "\nEnter an integer for feet: "
	prompti:	.asciz "\nEnter an integer for inches: "
	output: 	.asciz "\nThat is %d\" inches.\n"
	format: 	.asciz "%d"



