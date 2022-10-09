#
# Program Name: Operand2.s
# Author: Akin Williams
# Date: 10/08/2022
# Purpose: This program calculates values from base and shift values
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt and read base
	LDR r0, =promptb
	BL printf
	LDR r0, =format
	LDR r1, =base
	BL scanf
	
	# Prompt and read shift
	LDR r0, =prompts
	BL printf
	LDR r0, =format
	LDR r1, =shift
	BL scanf

	# Perform shift
	LDR r4, =base
	LDR r4, [r4]
	LDR r5, =shift
	LDR r5, [r5]
	LSL r6, r4, r5

	# Print the result
	LDR r0, =output
	LDR r1, =base
	LDR r1, [r1]
	LDR r2, =shift
	LDR r2, [r2]
	MOV r3, r6
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	base:		.word 0
	shift:		.word 0
	promptb:	.asciz "\nEnter base value: "
	prompts:	.asciz "\nEnter shift value: "
	output:		.asciz "\n%d shifted %d bit(s) is %d.\n"
	format:		.asciz "%d"

