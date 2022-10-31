#
# Program Name: IsChar.s
# Author: Akin Williams
# Date: 10/29/2022
# Purpose: Check if an ascii value is a character by implementing 
# if ((r1 >=0x41 && r1 <=0x5a) || (r1>=0x61 && r1<=0x7a))
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
	LDR r1, =char
	BL scanf

	# Read input value
	LDR r1, =char
	LDR r1, [r1]

	# Greater than 0x41
	MOV r2, #0 // All bits are 0
	CMP r1, #0x41
	ADDGE r2, #1 // If true, bit 0 is set to 1

	# Less than 0x5a
	MOV r3, #0
	CMP r1, #0x5a
	ADDLT r3, #1
	AND r2, r2, r3 // r3 is set to 1, if r1 is uppercase

	# Greater than 0x61
	MOV r0, #0
	CMP r1, #0x61
	ADDGE r0, #1

	# Less than 0x7a
	MOV r3, #0
	CMP r1, #0x7a
	ADDLT r3, #1

	AND r3, r3, r0 // r3 is set to 1, if r1 is lowercase
	ORR r4, r2, r3 // r4 is set to 1, if r1 is uppercase or lowercase

	# Output conditional result
	LDR r0, =output
	LDR r1, =char
	LDR r1, [r1]

	# Conditional branch to T/F labels
	CMP r4, #0
	BNE Else
		LDR r2, =false
		BL printf
		B EndIf

	Else:
		LDR r2, =true
		BL printf
		B EndIf

	EndIf:
		B return

	return:
		# Pop the stack record
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

.data
	char:		.word	0
	true:		.asciz "is"
	false:		.asciz "is not"
	prompt:		.asciz "\nEnter a value: "
	output: 	.asciz "\n%d %s a character code.\n"
	format: 	.asciz "%d"
# END main


