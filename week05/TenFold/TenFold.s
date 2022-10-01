#
# Program Name: TenFold.s
# Author: Akin Williams
# Date: 9/30/2022
# Purpose: This program multiplies an input integer by ten.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt for user input and read integer value
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =input
	BL scanf

	# Left shift input value by 3 and 1 bits
	LDR r4, =input
	LDR r4, [r4]
	LSL r5, r4, #3
	LSL r6, r4, #1

	# Add shifted values together
	ADD r7, r6, r5

	# Print the result
	LDR r0, =output
	MOV r1, r4
	MOV r2, r7
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	input:	.word	0
	prompt: .asciz "\nEnter an integer: "
	output: .asciz "\n%d x 10 = %d.\n"
	format: .asciz "%d"

