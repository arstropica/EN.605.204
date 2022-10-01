#
# Program Name: SwapEORVerbose.s
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
	LDR r4, =input1
	LDR r4, [r4]
	LDR r5, =input2
	LDR r5, [r5]
	LDR r0, =status1
	MOV r1, r4
	MOV r2, r5
	BL printf

	# First EOR Operation
	EOR r4, r4, r5
	LDR r0, =status2
	MOV r1, r4
	MOV r2, r5
	BL printf

	# Second EOR operation
	EOR r5, r4, r5
	LDR r0, =status3
	MOV r1, r4
    MOV r2, r5
	BL printf

	# Third EOR operation
	EOR r4, r5, r4
	LDR r0, =status4
    MOV r1, r4
    MOV r2, r5
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
	status1:	.asciz	"\nValues after Input:\tr1: %d\tr2: %d"
	status2:    .asciz  "\nValues after EOR #1:\tr1: %d\tr2: %d"
	status3:    .asciz  "\nValues after EOR #2:\tr1: %d\tr2: %d"
	status4:    .asciz  "\nValues after EOR #3:\tr1: %d\tr2: %d\n"
	format: 	.asciz	"%d"

