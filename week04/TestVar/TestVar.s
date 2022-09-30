#
# Program Name: PrintAge.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: This program ask the user for their age, and outputs it using scanf and printf.
#
.text
.global main

main:
	# Push the program stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	LDR r0, =fmt1
	LDR r1, =var1
	BL printf

	LDR r0, =fmt1
	LDR r1, =var2
	BL printf

	# Pop the program stack and return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	fmt1:	.asciz "%s\n"
	var1:	.asciz	"a"
	var2:	.asciz "A"
