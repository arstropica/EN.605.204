#
# Program Name: OutputFloat.s
# Author: Akin Williams
# Date: 9/24/2022
# Purpose: This program prints out a floating point number.
#
.text
.global main
.func main

main:
	# push the stack record
	SUB sp, sp, #16
	STR lr, [sp, #0]

	LDR r1, addr_value1
	VLDR s14, [r1]
	VCVT.F64.F32 d5, s14

	LDR r0, =output1
	VMOV r2, r3, d5
	BL printf

	# pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #16
	MOV pc, lr

addr_value1:
	.word value1

.data
	value1:		.float  108.65625
	prompt1: 	.asciz 	"Enter an float number: "
	format1: 	.asciz	"%f"
	output1:	.asciz	"You entered the float %f\n"

