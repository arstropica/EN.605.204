#
# Function name: SummationLoop.s
# Author: Akin Williams
# Date: 12/11/2022
# Purpose: Implementation of a summation program that
# uses a Sentinel (while) loop structure
#
.text 
.global main 

main: 

	# Program Dictionary:
	#	r4 - input counter
	#	r5 - input total
	#	r6 - input value

	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]
	
	# Initialize program variables
	MOV r4, #0 				// Initialize counter
	MOV r5, #0 				// Initialize total

	# Initialize by prompting user for value and read integer value
	LDR r0, =prompt 
	BL printf 
	LDR r0, =format 
	LDR r1, =input
	BL scanf

	# Prepare input value for comparison
	LDR r0, =input
	LDR r6, [r0, #0]
	
StartSentinelLoop: 
	MOV r1, #-1
	CMP r6, r1
	BEQ EndSentinelLoop 		// Branch to end if -1

		# Begin loop block
		ADD r4, r4, #1 			// Increment counter
		ADD r5, r5, r6 			// Add input value to total

		# Prompt user for next input value
		LDR r0, =prompt
		BL printf
		LDR r0, =format
		LDR r1, =input 
		BL scanf

		# Prepare input value for comparison
		LDR r0, =input 
		LDR r6, [r0, #0]
 
		B StartSentinelLoop 	// Branch to loop start

EndSentinelLoop:
	# Output the result
	LDR r0, =output
	MOV r1, r4
	MOV r2, r5
	BL printf
	B Return 					// Branch to program return (trivial)

Return:
	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
# End main

.data 
	input: 	.word 0
	prompt:	.asciz "Please enter a number (-1 to end): \n" 
	output:	.asciz "You entered %d values, totalling %d.\n" 
	format:	.asciz "%d" 


