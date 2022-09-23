#
# Program Name: QuotedString.s
# Author: Akin Williams
# Date: 9/23/2022
# Purpose: This program prints out a Hello World string with quotes.
#
.text
.global main

main:
	# Push the program stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Print Hello World in a formatted string with quotes
	LDR r0, =quotedFormat
	LDR r1, =helloWorld
	BL printf

	# Pop the program stack and return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	# Store the unquoted message
	helloWorld:		.asciz	"Hello World"
	# Store the format for the quoted output, escaping the quote characters
	quotedFormat:	.asciz	"The quoted string is \"%s\".\n"

