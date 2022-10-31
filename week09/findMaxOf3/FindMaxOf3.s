#
# Program Name: FindMaxOf3.s
# Author: Akin Williams
# Date: 10/30/2022
# Purpose: Find the largest of 3 values.
#
# Functions defined:
# 	- miles2kilometer
# 	- kph
#
# Changes: 10/30/2022 - Initial release
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	MOV r4, #2
	MOV r5, #0
	MOV r6, #1
	StartInputLoop:
		CMP r5, r4
		BGT EndInputLoop

		# Loop Block: 
		# Prompt for user input and read integer value
		LDR r0, =prompt
		BL printf
		LDR r0, =format

		#if block
		CMP r5, r4
		BLE First

		First:
			CMP r5, r6
			BGE Second
			LDR r1, =int_1
			B EndIf
		Second:
			CMP r5, r6
			BGT Third
			LDR r1, =int_2
			B EndIf
		Third:
			LDR r1, =int_3
			B EndIf
		EndIf:
			BL scanf

			# Get next value
			ADD r5, r5, #1			
			B StartInputLoop
	EndInputLoop:

	# Load input values and branch to function
	LDR r0, =int_1
	LDR r0, [r0]
	LDR r1, =int_2
	LDR r1, [r1]
	LDR r2, =int_3
	LDR r2, [r2]
	BL FindMaxOf3

	# Store the return value in preserved register
	MOV r4, r0

	# Print the result
	LDR r0, =output
	MOV r1, r4
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	int_1:		.word	0
	int_2:		.word	0
	int_3:		.word	0
	prompt:		.asciz "\nEnter next value: "
	output: 	.asciz "\n%d is the greatest value.\n"
	format: 	.asciz "%d"

# End main
#
#
# Function: FindMaxOf3
# Purpose: Return the largest value of 3 integers.
#
# Input:	r0 - first integer
#			r1 - second integer
#			r2 - third integer
#
# Output:	r0 - pointer to the largest integer
#
.text
FindMaxOf3:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	BL FindMax
	MOV r1, r2
	BL FindMax

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
# End FindMaxOf3
#
#
# Function: FindMax
# Purpose: Return the largest of 2 integers.
#
# Input:	r0 - first integer
#			r1 - second integer
#
# Output:	r0 - pointer to the largest integer
#
.text
FindMax:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#if block
		CMP r0, r1
		BLT Else // r0 < r1
		B EndIf_2

	Else:
		MOV r0, r1 // set r1 as return

	EndIf_2:
		# Pop the stack record
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr
.data
# End FindMax
