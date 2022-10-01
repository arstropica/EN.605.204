#
# Program Name: SwapEOR.s
# Author: Akin Williams
# Date: 9/30/2022
# Purpose: This program swaps two registers using EOR instructions.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt for user input and read the first integer
	LDR r0, =prompt1
	BL printf
	LDR r0, =format
	LDR r1, =input1
	BL scanf

	# Prompt for user input and read the second integer
	LDR r0, =prompt2
	BL printf
	LDR r0, =format
	LDR r1, =input2
	BL scanf

	# Load initial values in registers
	LDR r1, =input1
	LDR r1, [r1]
	LDR r2, =input2
	LDR r2, [r2]

	# Perform EOR Operations
	EOR r1, r1, r2
	EOR r2, r1, r2
	EOR r1, r2, r1

	# Print the outcome
	LDR r0, =output
   	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	input1:		.word	0
	input2:		.word	0
	prompt1: 	.asciz	"\nEnter a first integer: "
	prompt2: 	.asciz	"\nEnter a second integer: "
	output: 	.asciz	"\nYou entered %d second and %d first.\n"
	format: 	.asciz	"%d"

