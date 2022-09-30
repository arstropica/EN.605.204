#
# Program Name: FahrenheitToCelsius.s 
# Author: Akin Williams
# Date: 9/29/2022
# Purpose: This program converts a temperature from fahrenheit to celsius.
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
	LDR r1, =tempc
	BL scanf

	# Subtract immediate value
	LDR r6, =tempc
	LDR r6, [r6]
	SUB r6, r6, #32

	# Multiply by immediate value
	MOV r7, #5
	MUL r5, r6, r7

	# Divide by immediate value
	MOV r0, r5
	MOV r1, #9
	BL __aeabi_idiv
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
	tempc:  .word 0
	prompt: .asciz "\nEnter temperature (in Fahrenheit): "
	output: .asciz "\nThat is %d°C degree(s) in Celsius.\n"
	format: .asciz "%d"



