#
# Program Name: Fib.s
# Author: Akin Williams
# Date: 11/07/2022
# Purpose: Prints the nth number of a Fibonacci sequence.
#
# Functions defined:
# 	- main
# 	- fib
#
# Changes: 11/07/2022 - Initial release
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt user for index and read integer value
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =index
	BL scanf

	# Load index value and branch to function
	LDR r0, =index
	LDR r0, [r0]
	BL fib

	# Store the return value in register
	MOV r2, r0

	# Print the result
	LDR r0, =output
	LDR r1, =index
	LDR r1, [r1]
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	index:		.word	0
	format:		.asciz	"%d"
	prompt:		.asciz	"Enter a Fibonacci sequence index: "
	output:		.asciz	"Fib(%d) = %d.\n"
# End main
#
#
# Function: fib
# Purpose: Recursive program that calculates a Fibonacci number.
#
# Note: fib is implemented as a static function, not a global symbol.
#
# Input:	r0 - fibonacci index
#
# Output:	r0 - sequence value
#
.text
fib:
	# Program Dictionary:
	#	r4 - input index
	#	r5 - recursive return value

	# Push the stack record
	SUB sp, sp, #12
	STR lr, [sp, #0]
	STR r4, [sp, #4]							// save preserved registers
	STR r5, [sp, #8]

	# Save first operand
	MOV r4, r0

	# If block
	MOV r1, #0
	CMP r4, r1
	BNE ElseIf
		MOV r0, #1								// if (n == 0) return 1
		B EndIf

	ElseIf:
		MOV r1, #1
		CMP r4, r1
		BNE Else
			MOV r0, #1							// if (n == 1) return 1
			B EndIf

	Else:
		SUB r0, r4, #1
		BL fib									// Fib(n - 1)
		MOV r5, r0
		SUB r0, r4, #2
		BL fib									// Fib(n - 2)
		ADD r0, r5, r0							// r0 = Fib(n - 1) + Fib(n - 2) 
		B EndIf

	EndIf:
		B Return

	# Pop the stack record and return
	Return:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]						// restore preserved registers
		LDR r5, [sp, #8]
		ADD sp, sp, #12
		MOV pc, lr
.data
# End fib

