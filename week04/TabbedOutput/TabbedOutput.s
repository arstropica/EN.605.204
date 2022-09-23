#
# Program Name: TabbedOutput.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: Outputs a string with tabs between an input number and the characters before and after it
#
.text
.global main

main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]


	# Prompt the user for an integer
	LDR r0, =prompt1
	BL printf

	# Read the user input with scanf
	LDR r0, =format1
	LDR r1, =input1
	BL scanf

	# Print the user input as a formatted single tabbed string
	LDR r0, =output1
	LDR r1, =input1
	LDR r1, [r1, #0] // Load register r1 with address of input1 at offset 0 
	BL printf

    # Print the user input as a formatted multi-tabbed string
    LDR r0, =output2
    LDR r1, =input1
    LDR r1, [r1, #0] // Load register r1 with address of input1 at offset 0 
    BL printf

	# Pop the stack record and return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt1: 	.asciz 	"Enter an integer number: "
	format1: 	.asciz	"%d"
	input1:		.word 	0
	output1:	.asciz	"This is your input number:\t%d\t. It has been surrounded by a single tab.\n"
    output2:    .asciz  "This is your input number:\t\t\t%d\t\t\t. It has been surrounded by multiple tabs.\n"

