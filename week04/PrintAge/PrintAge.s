#
# Program Name: PrintAge.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: This program ask the user for their age, and outputs it using scanf and printf.
#
.text
.global main

main:
	# Push the program stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt the user for their age
	LDR r0, =prompt1
	BL printf

	# Read the user age with scanf
	LDR r0, =format1
	LDR r1, =input1
	BL scanf

	# Print the user input as a formatted string
	LDR r0, =output1
	LDR r1, =input1
	LDR r1, [r1, #0] // Load register r1 with address of input1 at offset 0 
	BL printf

	# Pop the program stack and return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	# Store the text for the user prompt
	prompt1:	.asciz	"Please enter your age: "
	# Store the format for the user input
	format1:	.asciz "%d"
	# Store a default value for the user input in a 32-bit variable
	input1:		.word	0
	# Store the text for the program output
	output1:	.asciz	"Your age is %d\n"


