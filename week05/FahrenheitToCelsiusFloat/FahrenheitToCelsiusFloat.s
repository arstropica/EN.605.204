#
# Program Name: FahrenheitToCelsiusFloat.s 
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program converts a float temperature from fahrenheit to celsius.
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
	LDR r1, =tempf
	BL scanf

	# Move float values into single point registers
	LDR r5, =tempf
	LDR r5, [r5]
	VMOV s0, r5

	LDR r6, =num
	LDR r6, [r6]
	VMOV s1, r6

	LDR r7, =denom
	LDR r7, [r7]
	VMOV s2, r7

	LDR r8, =deduct
	LDR r8, [r8]
	VMOV s3, r8

	# Subtract float value
	VSUB.F32 s4, s0, s3

	# Multiply difference and numerator
	VMUL.F32 s5, s4, s1

	# Divide by denominator
	VDIV.F32 s6, s5, s2

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
	num:	.float 5.0
	denom:	.float 9.0
	deduct:	.float 32.0
	tempf:  .word 0
	prompt: .asciz "\nEnter temperature (in Fahrenheit): "
	output: .asciz "\nThat is %.1f°C degree(s) in Celsius.\n"
	format: .asciz "%f"



