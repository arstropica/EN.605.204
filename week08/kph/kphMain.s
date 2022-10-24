# Filename: kphMain.s
# Author: Akin Williams
# Date: 23/10/2022
# Purpose: Prompts user for miles and hours, then calculates 
# speed in km/h with kph.
#
# Functions defined:
# 	- main
#
# Changes: 23/10/2022 - Initial release
.global main
.text
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt for user hours input and read integer value
	LDR r0, =prompth
	BL printf
	LDR r0, =format
	LDR r1, =hours
	BL scanf

	# Prompt for user distance input and read integer value
	LDR r0, =promptm
	BL printf
	LDR r0, =format
	LDR r1, =miles
	BL scanf

	# Pass input values for hours and miles to kph
	LDR r0, =hours
	LDR r0, [r0, #0]
	LDR r1, =miles
	LDR r1, [r1, #0]
	BL kph

	# Store the return value in preserved register
	MOV r4, r0

	# Print the result
	LDR r0, =output
	LDR r1, =miles
	LDR r1, [r1, #0]
	LDR r2, =hours
	LDR r2, [r2, #0]
	MOV r3, r4
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	hours:		.word	0
	miles:		.word	0
	prompth:	.asciz "\nEnter hours: "
	promptm:	.asciz "\nEnter distance in miles: "
	output: 	.asciz "\n%d miles in %d hours is %d km/h.\n"
	format: 	.asciz "%d"
# End main

