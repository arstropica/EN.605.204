#
# Program Name: GuessNumberInline.s
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
	#	r7 - user hint
	#	r8 - answers array base address

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
			LDR r0, =hint
			MOV r1, r5
			BL printf

			# Get the user hint
			LDR r0, =inputf
			LDR r1, =input
			BL scanf

			# Parse the user input
			LDR r7, =input
			LDR r7, [r7]
			MOV r1, #0xFF
			AND r7, r7, r1						// mask the upper 24 bits for ascii
			LDR r8, =answers

			# If block
			MOV r1, #0
			ADD r2, r8, r1, lsl #2					// address the next element
			LDR r2, [r2, #0]					// load the element value
			CMP r7, r2						// compare against input
			BNE Greater_Than
				Correct:
				B EndSearchLoop

			Greater_Than:
				MOV r1, #1
				ADD r2, r8, r1, lsl #2
				LDR r2, [r2, #0]
				CMP r7, r2
				BNE Less_Than
					SUB r0, r4, r5				// subtract mid from max value
					MOV r1, #1
					CMP r0, r1
					ADDEQ r0, r0, #1			// break rounding error for upper limit
					MOV r1, #2
					BL __aeabi_idiv				// divide by 2
					ADD r0, r0, r5				// calculate new upper mid-point
					MOV r6, r5				// set old mid-point to minimum
					MOV r5, r0				// set new mid-point
					B EndComparison

			Less_Than:
				MOV r1, #2
				ADD r2, r8, r1, lsl #2
				LDR r2, [r2, #0]
				CMP r7, r2
				BNE InvalidComparison
					SUB r0, r4, r6
					MOV r1, #1
					CMP r0, r1				// choose minimum if: max - min = 1
					BLE Minimum	
						SUB r0, r5, r6			// subtract min value from mid-point
						MOV r1, #2
						BL __aeabi_idiv			// divide by 2
						ADD r0, r0, r6			// calculate new lower mid-point
						MOV r4, r5			// set old mid-point to maximum
						MOV r5, r0			// set new mid-point
						B EndComparison

			Minimum:						// new mid-point is equal to minimum
				MOV r4, r6					// set maximum to minimum
				MOV r5, r6
				B EndSearchLoop					// Only 1 integer left, so end search

			InvalidComparison:
				B StartComparison				// invalid input, ask user again

			# End if block & restart loop
			EndComparison:
				B StartSearchLoop				// iterate binary search

		EndSearchLoop:
			B Answer						// branch to answer block

	ElseInvalidInput:
		LDR r0, =prompt
		BL printf
		LDR r0, =format
		LDR r1, =maxval
		BL scanf
		B StartInputCheck
	EndInputCheck:

	# Output an answer
	Answer:
		LDR r0, =output
		MOV r1, r5							// r5 is the mid-point from loop block
		BL printf

	# Pop the stack record
	Return:
		LDR lr, [sp, #0]
		ADD sp, sp, #4
		MOV pc, lr

.data
	answers:	.word	99
			.word	104
			.word	108
	maxval:		.word 	0
	minval:		.word 	1
	input:		.space	40
	format:		.asciz	"%d"
	inputf:		.asciz	"%s"
	info:		.asciz	"Choose a secret number between 1 and a maximum value, and I will try to guess it.\n"
	prompt:		.asciz	"Enter a maximum value greater or equal to 1: "
	hint:		.asciz	"My guess is \"%d\".\nIs that correct, or is your secret number higher or lower? [c/h/l]: "
	output:		.asciz	"Your secret number is \"%d\".\n"
# End main

