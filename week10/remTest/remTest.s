#
# Program Name: remTest 
# Author: Akin Williams
# Date: 11/03/2022
# Purpose: Test arm remainder function.
#
.text
.global main
main:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Write Program here
	MOV r4, #10
	MOV r0, r4
	MOV r1, #4
	BL __aeabi_idiv
	MUL r0, r0, r1
	SUB r1, r4, r0

	LDR r0, =output
	BL printf

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	output: 	.asciz "The remainder is  %d.\n"
	format: 	.asciz "%d"



