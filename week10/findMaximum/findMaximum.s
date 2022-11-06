#
# Program Name: findMaximum.s
# Author: Chuck Kahn
# Date: 11/03/2022
# Purpose: Find the maximum value in an array.
#
.text
.global main
main:
	# Program Dictionary:
	#	r4 - counter
	#	r5 - number of array elements
	#	r6 - base address of list (or array)
	#	r7 - current maximum value
	#	r8 - value at current array index

	# Push the stack record
	# Save preserved register values
	SUB sp, sp, #24
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]

	# Initialize Loop
	MOV r4, #0 // set starting counter value
	LDR r5, =array_size // set array size
	LDR r5, [r5]
	LDR r6, =array // set base array address
	MOV r7, #-1 // set starting maximum value

	# Start the loop
	startMaxLoop:
		# Check terminating condition
		CMP r4, r5
		BGE endMaxLoop

		# Loop statement
		ADD r8, r6, r4, lsl #2 // load address of current element
		LDR r8, [r8]
		CMP r8, r7
		MOVGT r7, r8

		# Increment and restart iteration
		ADD r4, r4, #1
		B startMaxLoop

	endMaxLoop:

	# Print the result
	LDR r0, =output
	MOV r1, r7
	BL printf


	# Restore preserved register values
	# Pop the stack record
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	LDR r6, [sp, #12]
	LDR r7, [sp, #16]
	LDR r8, [sp, #20]
	ADD sp, sp, #24
	MOV pc, lr

.data
	output:		.asciz "The maximum value in the list is: %d\n"
	array:		.word 5
				.word 12
				.word 8
				.word 27
	array_size:	.word 4
# End main

