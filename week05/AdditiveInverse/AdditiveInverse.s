#
# Program Name: AdditiveInverse.s
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program outputs the value of the additive inverse of an integer.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#Prompt for integer and read input
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =input
	BL scanf

	# Get the 1's complement via inversion
	LDR r4, =input
	LDR r4, [r4]
	MVN r5, r4

	# Add one for the 2's complement
	ADD r6, r5, #1

	# Print the result
	LDR r0, =output
	MOV r1, r6
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	input:	.word 0
	prompt: .asciz "\nEnter an integer: "
	output: .asciz "The additive inverse value is %d.\n"
	format: .asciz "%d"
	


