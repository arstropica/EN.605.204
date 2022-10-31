#
# Program Name: PrintGrade.s
# Author: Akin Williams
# Date: 10/30/2022
# Purpose: Calculates and prints a student grade.
#
.text 
.global main 

main: 
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Prompt for user input and read input name value
	LDR r0, =promptn
	BL printf
	LDR r0, =formatn
	LDR r1, =name
	BL scanf

	# Prompt for user input and read input score value
	LDR r0, =prompts
	BL printf
	LDR r0, =formats
	LDR r1, =score
	BL scanf

	# Load score value in preserved register
	LDR r4, =score
	LDR r4, [r4]

	#if block 
		# Is the score valid (0 - 100)?
		MOV r6, #0 
		MOV r5, #0 
		CMP r4, r5 
		MOVGE r6, #1 
		
		MOV r7, #0 
		MOV r5, #100 
		CMP r4, r5 
		MOVLE r7, #1 
		
		AND r6, r6, r7 
		MOV r7, #1 
		CMP r6, r7 
		BEQ grade_A // Check for A
		
		# Invalid Score
		LDR r0, =invalid 
		BL printf 
		B EndIf 

	grade_A: 
		MOV r5, #90 
		CMP r4, r5 
		BLT grade_B // Check for B
			
		# Grade is A 
		LDR r0, =gradea
		LDR r1, =name 
		BL printf 
		B EndIf
		
	grade_B: 
		MOV r5, #80 
		CMP r4, r5 
		BLT grade_C
		
		# Grade is B
		LDR r0, =gradeb
		LDR r1, =name 
		BL printf 
		B EndIf
		
	grade_C: 
		MOV r5, #70 
		CMP r4, r5 
		BLT Else
		
		# Grade is C
		LDR r0, =gradec
		LDR r1, =name 
		BL printf 
		B EndIf
		
	Else: 
		# Grade is F
		LDR r0, =gradef
		LDR r1, =name 
		BL printf 
		B EndIf 
		
	EndIf:


	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	score:	  .word   0
	name:	   .space  40
	gradea:	 .asciz  "\n%s\'s grade is A.\n"
	gradeb:	 .asciz  "\n%s\'s grade is B.\n"
	gradec:	 .asciz  "\n%s\'s grade is C.\n"
	gradef:	 .asciz  "\n%s\'s grade is F.\n"
	promptn:	.asciz  "Enter your name: "
	prompts:	.asciz  "\nEnter your average score: "
	formatn:	.asciz  "%s"
	formats:	.asciz  "%d"
	invalid:	.asciz  "Grade must be 0 <= grade <= 100\n"

