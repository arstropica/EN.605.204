#
# Program Name: PrintFloat.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: This program prints out a floating point number from user input.
#
.text
.global main
main:
	# push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt the user to enter a float
	LDR r0, =prompt1
	BL printf

	# Read the user integer
	LDR r0, =format1
	LDR r1, =float1
	BL scanf

	# Print the user input
	LDR r0, =output1
	LDR r1, =float1
	LDR r1, [r1, #0]
	BL printf

	# pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt1: 	.asciz 	"Enter an float number: "
	format1: 	.asciz	"%f"
	float1:		.word 	0
	output1:	.asciz	"You entered the float %f\n"


