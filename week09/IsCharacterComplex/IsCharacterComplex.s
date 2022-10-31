#
# Program Name: IsCharacterComplex.s
# Author: Akin Williams
# Date: 10/30/2022
# Purpose: Check if a user input value is a character without using logical variables.
#
	.text
	.global main

main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt the user for string input
	LDR r0, =prompt
	BL  printf

	# Store user input in variable
	LDR r0, =format
	LDR r1, =input
	BL  scanf

	# Load input value to r4
	LDR r4, =input
	LDR r4, [r4]

	isInCharRange:
		# Check 0x41 <= r0 <= 0x7A
		MOV r2, #0
		MOV r1, #0x41
		CMP r4, r1
		MOVGE r2, #1

		MOV r3, #0
		MOV r1, #0x7A
		CMP r4, r1
		MOVLE r3, #1

		AND r2, r2, r3
		MOV r3, #1
		CMP r2, r3
		BEQ IsUppercase // Within the valid range
		B NotACharacter // Invalid

	IsUppercase:
		# Test less or equal to 'Z'
		MOV r1, #0x5A
		CMP r4, r1
		BLE IsACharacter // Valid
		B IsLowercase

	IsLowercase:
		# Test greater or equal to 'a'
		MOV r1, #0x61
		CMP r4, r1
		BLT NotACharacter // Invalid
		B IsACharacter // Valid

	NotACharacter:
		LDR r0, =invalid
		LDR r1, =input
		LDR r1, [r1]
		BL  printf
		B return

	IsACharacter:
		LDR r0, =valid
		LDR r1, =input
		LDR r1, [r1]
		BL  printf
		B return

	return:
		# Pop the stack record
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr
# End main
.data
	input:	 .asciz  ""
	format:	.asciz  "%d"
	prompt:	.asciz  "Enter a character ascii code: "
	invalid:   .asciz  "You entered \"%d\" which is not a valid character code.\n"
	valid:	 .asciz  "You entered \"%d\" which is a valid character code.\n"


