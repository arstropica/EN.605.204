#
# Program Name: helloWorldMain.s
# Author: Akin Williams
# Date: 9/12/2022
# Purpose: This program shows how to print a string using the C function printf.
#
.text
.global main

main:
	# Save return to OS on stack
	SUB sp, sp, #4
	STR lr, [sp, #0]


	# Printing the Message
	LDR r0, =helloWorld // load register r0 with the address of the string "helloWorld"
	BL printf // branch (and link) to the printf function, look for the above address in r0

	# Return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	# Stores the string to be printed
	helloWorld: .asciz "Hello World\n"


