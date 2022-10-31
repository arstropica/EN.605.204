#
# Program Name: Summation.s
# Author: Akin Williams
# Date: 10/29/2022
# Purpose: Implementation of a recursive summation function.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Call the summation function
	MOV r0, #10
	BL Summation

	# Print the result
	MOV r1, r0
	LDR r0, =output1
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output1:	.asciz "Summation is %d\n"
# END main
.text
Summation:
	# Push the stack record
	SUB sp, sp, #8
	STR lr, [sp, #0]

	# Save r4
	STR r4, [sp, #4]
	MOV r4, r0

	# Base Case: Return, if n is zero
	MOV r1, #0
	CMP r1, r4
	BEQ return @ r0 is zero

	# Recursive Case: Recurse if n is NOT zero
	ADD r0, r4, #-1
	BL Summation @ return value in r0
	ADD r0, r4, r0 @ return sum of summation and r0
	B return

	# Pop the stack record and return
	return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		ADD sp, sp, #8
		MOV pc, lr
# END Summation

