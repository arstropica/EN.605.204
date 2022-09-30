#
# Program Name: CelsiusToFahrenheit.s 
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program converts a temperature from celsius to fahrenheit.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt for user input and read integer value
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =tempf
	BL scanf

	# Multiply by immediate value
	LDR r7, =tempf
	LDR r7, [r7]
	MOV r8, #9
	MUL r6, r7, r8

	# Divide by immediate value
	MOV r0, r6
	MOV r1, #5
	BL __aeabi_idiv
	MOV r5, r0

	# Add by immediate value
	ADD r4, r5, #32

	# Print the result
	LDR r0, =output
	MOV r1, r4
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	tempf:  .word 0
	prompt: .asciz "\nEnter temperature (in Celsius): "
	output: .asciz "\nThat is %d°F degree(s) in Fahrenheit.\n"
	format: .asciz "%d"



