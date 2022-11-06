#
# Program Name: GuessNumber.s
# Author: Akin Williams
# Date: 11/04/2022
# Purpose: Identifies an unknown number using a binary search algorithm.
#
.text
.global main
main:

	# Program Dictionary:
	#	r4 - binary search upper limit
	#	r5 - binary search current mid-point
	#	r6 - binary search lower limit
	#	r7 - relationship to unknown value

	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Print instructions
	LDR r0, =info
	BL printf

	# Prompt user for maximum value and read integer value
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =maxval
	BL scanf

	# Input check
	StartInputCheck:
	LDR r4, =maxval
	LDR r4, [r4]
	LDR r6, =minval
	LDR r6, [r6]
	CMP r4, r6
	BLT ElseInvalidInput

		# Initialize Loop Variables
		ADD r0, r4, #1							// Add 1 to dividend to avoid zero quotient
		MOV r1, #2
		BL __aeabi_idiv
		MOV r5, r0							// calculate mid-point

		# Start the loop
		StartSearchLoop:						// start loop
			MOV r1, #0
			CMP r5, r1						// trivial: check terminating condition
			BLE EndSearchLoop

			# Loop block
			StartComparison:
			MOV r0, r5
			BL getLogicalHint
			MOV r7, r0			

			# If block
			MOV r1, #0
			CMP r7, r1						// compare against user hint
			BNE Greater_Than

			Equal_To:
				B EndSearchLoop

			Greater_Than:
			MOV r1, #0
			CMP r7, r1						// trivial: compare against user hint
			BLT Less_Than
				SUB r0, r4, r5					// subtract mid from max value
				MOV r1, #1
				CMP r0, r1
				ADDEQ r0, r0, #1				// break rounding error for upper limit
				MOV r1, #2
				BL __aeabi_idiv					// divide by 2
				ADD r0, r0, r5					// calculate new upper mid-point
				MOV r6, r5					// set old mid-point to minimum
				MOV r5, r0					// set new mid-point
				B EndComparison

			Less_Than:
				SUB r0, r4, r6
				MOV r1, #1
				CMP r0, r1					// choose minimum if: max - min = 1
				BLE Minimum	
					SUB r0, r5, r6				// subtract min value from mid-point
					MOV r1, #2
					BL __aeabi_idiv				// divide by 2
					ADD r0, r0, r6				// calculate new lower mid-point
					MOV r4, r5				// set old mid-point to maximum
					MOV r5, r0				// set new mid-point
					B EndComparison

			Minimum:						// new mid-point is equal to minimum
				MOV r4, r6					// set maximum to minimum
				MOV r5, r6
				B EndSearchLoop					// only 1 integer left, so end search

			# Restart loop
			EndComparison:
				B StartSearchLoop				// iterate binary search

		EndSearchLoop:							// end loop
			B Answer						// branch to answer block

	ElseInvalidInput:
		LDR r0, =prompt
		BL printf
		LDR r0, =format
		LDR r1, =maxval
		BL scanf
		B StartInputCheck						// restart user input
	EndInputCheck:

	# Output an answer
	Answer:
		LDR r0, =output
		MOV r1, r5
		BL printf

	# Pop the stack record
	Return:
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

.data
	maxval:		.word 	0
	minval:		.word 	1
	format:		.asciz	"%d"
	info:		.asciz	"Choose a secret number between 1 and a maximum value, and I will try to guess it.\n"
	prompt:		.asciz	"Enter a maximum value greater or equal to 1: "
	output:		.asciz	"Your secret number is \"%d\".\n"
# End main

# Function: getLogicalHint
# Purpose: Asks the user for the relationship between an unknown value and a given integer.
# Returns a corresponding value.
#
# Note: getLogicalHint is implemented as a static function, not a global symbol.
#
# Input:	r0 - input integer
#
# Output:   r0 - relationship to unknown (0 = equal, -1 = lower, +1 = higher)
#
.text
getLogicalHint:
	# Program Dictionary:
	#	r4 - input value
	#	r5 - equality value

	# Push the stack record
	SUB sp, sp, #12
	STR lr, [sp, #0]
	STR r4, [sp, #4]							// save preserved registers
	STR r5, [sp, #8]

	# Save input value
	MOV r4, r0

	# Prompt user for hint and read input
	StartHint:
	LDR r0, =hint
	MOV r1, r4
	BL printf

	LDR r0, =input_format
	LDR r1, =input
	BL scanf

	# Get the user clue
	LDR r0, =input
	LDR r0, [r0]
	MOV r1, #0xFF
	AND r0, r0, r1								// mask the upper 24 bits for ascii
	LDR r1, =answers

	StartCheckHint:
	MOV r3, #0
	ADD r2, r1, r3, lsl #2							// address the next element
	LDR r2, [r2, #0]							// load the element value
	CMP r0, r2								// compare against input
	BNE High

	Equal:
		MOV r5, #0							// set equality value
		B EndCheckHint

	High:
		MOV r3, #1
		ADD r2, r1, r3, lsl #2
		LDR r2, [r2, #0]
		CMP r0, r2
		BNE Low
			MOV r5, #1						// set equality value
			B EndCheckHint

	Low:
		MOV r3, #2
		ADD r2, r1, r3, lsl #2
		LDR r2, [r2, #0]
		CMP r0, r2
		BNE InvalidHint
			MOV r5, #-1						// set equality value
			B EndCheckHint

	InvalidHint:
		B StartHint							// invalid input, ask user again

	EndCheckHint:
		MOV r0, r5

	# Pop the stack record and return
	Return_getLogicalHint:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]
		LDR r5, [sp, #8]						// restore preserved registers
		ADD sp, sp, #12
		MOV pc, lr
.data
	answers:		.word	99
				.word	104
				.word	108
	input:			.space	40
	hint:			.asciz	"My guess is \"%d\".\nIs that correct, or is your secret number higher or lower? [c/h/l]: "
	input_format:		.asciz	"%s"
# End getLogicalHint

