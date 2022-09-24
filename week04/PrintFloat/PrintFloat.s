#
# Program Name: PrintFloat.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: This program prints out a floating point number from user input.
#
.text
.global main
main:
	# Push the stack record
	# Increase stack frame to (4 * 4 = 16 bytes) for multiple registers
	SUB sp, sp, #16
	STR lr, [sp, #0]

	# Prompt the user to enter a float
	LDR r0, =prompt1
	BL printf

	# Read the user float
	LDR r0, =format1
	LDR r1, =float1
	BL scanf

	# Using indirect addressing, load contents of float1 from r1 into single precision register s14
	LDR r1, =float1
	VLDR s14, [r1]

	# Move float from single precision to double precision register
	VCVT.F64.F32 d5, s14

	# (Vector) Move float value from  double precision register to r2/r3
	LDR r0, =output1
	VMOV r2, r3, d5
	# Print out user output
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #16
	MOV pc, lr

.data
	float1:		.word   0
	prompt1: 	.asciz 	"Enter an float number: "
	format1: 	.asciz	"%f"
	output1:	.asciz	"You entered the float %f\n"


