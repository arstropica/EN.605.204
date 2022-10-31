#
# Program Name: IsCharacterLogicalAscii.s
# Author: Akin Williams
# Date: 10/30/2022
# Purpose: Check if a user input integer value is a valid character code using logical variables.
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

	# Load value to r0
	LDR r0, =input
	LDR r0, [r0, #0]

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
# Input:    r0 - input code
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
		LDR r1, [r1]
        BL  printf

	# Pop the stack and return
        LDR lr, [sp, #0]
		LDR r0, [sp, #4]
		ADD sp, sp, #8
		MOV pc, lr
# End isCharacter
.data
	input:     .asciz  ""
	format:    .asciz  "%d"
	prompt:    .asciz  "Enter a character ascii code: "
	invalid:   .asciz  "You entered \"%d\" which is not a valid character ascii code.\n"
    valid:     .asciz  "You entered \"%d\" which is a valid character ascii code.\n"

