#
# Program Name: IsCharacterLogical.s
# Author: Akin Williams
# Date: 10/30/2022
# Purpose: Check if a user input string value is a character using logical variables.
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

	# Mask the upper 24 bits for ascii
	LDR r0, =input
	LDR r0, [r0]
	MOV r1, #0xFF
	AND r0, r0, r1

	# Branch to function
	BL isCharacter

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
# End main

# Function: isCharacter
# Purpose: Prints whether input argument is an ascii character code.
#
# Input:	r0 - input code
#
# Output:   None
isCharacter:
	# Push the stack record	
	SUB sp, sp, #8
	STR r0, [sp, #4]
	STR lr, [sp, #0]

	#if block
	# Check 0x41 <= r0 <= 0x7A
	MOV r2, #0
	MOV r1, #0x41
	CMP r0, r1
	MOVGE r2, #1

	MOV r3, #0
	MOV r1, #0x7A
	CMP r0, r1
	MOVLE r3, #1

	AND r4, r2, r3 

	# Check NOT 0x5A > r0 < 0x61
	MOV r2, #0
	MOV r1, #0x5A
	CMP r0, r1
	MOVGT r2, #1

	MOV r3, #0
	MOV r1, #0x61
	CMP r0, r1
	MOVLT r3, #1

	EOR r3, r3, r2
	AND r2, r3, r4

	MOV r1, #0
	CMP r2, r1
	BEQ Else
		LDR r0, =valid
		B EndIf

	Else:
		LDR r0, =invalid
		B EndIf

	EndIf:
		# Print result
		LDR r1, =input
		BL  printf

	# Pop the stack and return
		LDR lr, [sp, #0]
		LDR r0, [sp, #4]
		ADD sp, sp, #8
		MOV pc, lr
# End isCharacter
.data
	input:	 .asciz  ""
	format:	.asciz  "%s"
	prompt:	.asciz  "Enter a character: "
	invalid:   .asciz  "You entered \"%s\" which is not a valid character\n"
	valid:	 .asciz  "You entered \"%s\" which is a valid character\n"

