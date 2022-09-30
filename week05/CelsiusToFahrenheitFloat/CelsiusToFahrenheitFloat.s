#
# Program Name: CelsiusToFahrenheitFloat.s 
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program converts a float temperature from celsius to fahrenheit.
#
.text
.global main
main:
	# Push the stack record
	# Increase stack frame to (4 * 4 = 16 bytes) for multiple registers
	SUB sp, sp, #16
	STR lr, [sp, #0]

	# Prompt for user input and read float value
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =tempc
	BL scanf

	# Move float values into single point registers
	LDR r5, =tempc
	LDR r5, [r5]
	VMOV s0, r5

	LDR r6, =num
	LDR r6, [r6]
	VMOV s1, r6

	LDR r7, =denom
	LDR r7, [r7]
	VMOV s2, r7

	LDR r8, =addend
	LDR r8, [r8]
	VMOV s3, r8

	# Multiply input float and numerator
	VMUL.F32 s4, s0, s1

	# Divide by denominator
	VDIV.F32 s5, s4, s2

	# Add float value to quotient
	VADD.F32 s6, s5, s3

	# Move float from single precision to double precision register
	VCVT.F64.F32 d5, s6

	# (Vector) Move float value from double precision register to r2/r3
	LDR r0, =output
	VMOV r2, r3, d5
	# Print the result
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #16
	MOV pc, lr

.data
	num:	.float 9.0
	denom:	.float 5.0
	addend:	.float 32.0
	tempc:  .word 0
	prompt: .asciz "\nEnter temperature (in Celsius): "
	output: .asciz "\nThat is %.1f°F degree(s) in Fahrenheit.\n"
	format: .asciz "%f"



