#
# Program Name: IsPrime.s
# Author: Akin Williams
# Date: 11/03/2022
# Purpose: Determines whether a given number is prime.
#
.text
.global main
main:
	# Program dictionary:
	# Note: r0/r1 are used for loop input as its value is short lived.

	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Initialize Loop
	LDR r0, = promptPrime
	BL  printf
	LDR r0, =primeFormat
	LDR r1, =input
	BL  scanf							// prompt user for input

	# Start the loop
	StartSentinelLoop:
		LDR r0, =input
		LDR r0, [r0]
		MOV r1, #-1
		CMP r0, r1						// check terminating condition
		BEQ EndSentinelLoop

		# Start loop block				// if block
		MOV r1, #2
		CMP r0, r1						// check invalid input
		BLE ElseInvalid
			BL isPrime
			MOV r1, #1
			CMP r0, r1					// check logical variable: isPrime
			BNE Invalid_Prime
				LDR r0, =output_valid	// r0 is a valid prime
				LDR r1, =input
				LDR r1, [r1]
				BL printf
				B EndInputCheck

			Invalid_Prime:				// r0 is not prime
				LDR r0, =output_invalid
				LDR r1, =input
				LDR r1, [r1]
				BL printf
				B EndInputCheck

		ElseInvalid:					// else input is invalid
            # Print an error message
            LDR r0, =badInput
            BL printf
        EndInputCheck:					// endif block

		# Get next value
		LDR r0, = promptPrime
		BL printf
		LDR r0, =primeFormat
		LDR r1, =input
		BL scanf						// prompt user for input
		B StartSentinelLoop

	EndSentinelLoop:

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	input:			.word	0
	primeFormat:	.asciz	"%d"
	promptPrime:	.asciz	"Enter an integer greater than 2, or -1 to end: "
	output_valid:	.asciz	"%d is a prime number.\n\n"
	output_invalid:	.asciz	"%d is not a prime number.\n\n"
	badInput: 		.asciz	"Your input value must be greater than 2.\n\n"
# END main

# Function: isPrime
# Purpose: Determines whether an input value is prime through division by any 
# potential factors, then returns the result as a boolean (logical) value.
#
# Note: isPrime is implemented as a static function, not a global symbol.
#
# Input:	r0 - input integer value
#
# Output:   r0 - boolean result (1 is prime, 0 is non-prime)
#
.text
isPrime:
	# Program Dictionary:
	#	r4 - input value
	#	r5 - current divisor value
	#	r6 - maximum divisor value

	# Push the stack record
	SUB sp, sp, #16
	STR lr, [sp, #0]
	STR r4, [sp, #4]					// save preserved registers
	STR r5, [sp, #8]
	STR r6, [sp, #12]

	# Store input value in preserved register
	MOV r4, r0

	# Initialize Loop
	MOV r5, #2							// set starting divisor value
	MOV r0, r4							// trivial: set the dividend
	MOV r1, #2
	BL  __aeabi_idiv					// calculate largest divisor value
	MOV r6, r0

	# Start the loop
	StartPrimeLoop:
		# Check terminating condition
		CMP r5, r6						// if the current divisor exceeds maximum
		BGT EndPrimeLoop

		# Enter loop block
		MOV r0, r4
		MOV r1, r5
		BL rem							// branch to remainder fn
		MOV r1, #0
		CMP r0, r1						// if there is no remainder
		BEQ EndPrimeLoop

		# Increment counter & restart loop
		ADD r5, r5, #1
		B StartPrimeLoop

	EndPrimeLoop:
		# Check if a common factor was found
		MOV r0, #0
		CMP r5, r6						// if the current divisor exceeds maximum
		MOVGT r0, #1					// then no factors found, thus prime!
		B Return_isPrime				// trivial: not really needed

	# Pop the stack record and return
	Return_isPrime:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]				// restore preserved registers
		LDR r5, [sp, #8]
		LDR r6, [sp, #12]
		ADD sp, sp, #16
		MOV pc, lr

.data
# End isPrime

# Function: rem
# Purpose: Returns the remainder of a division.
#
# Note: rem is implemented as a static function, not a global symbol.
#
# Input:	r0 - integer dividend value
#			r1 - integer divisor value
#
# Output:   r0 - division remainder value
#
.text
rem:
	# Program Dictionary:
	#	r4 - input value

	# Push the stack record
	SUB sp, sp, #8
	STR lr, [sp, #0]
	STR r4, [sp, #4]					// save preserved register

	# Save the input dividend
	MOV r4, r0

	# Perform the division operation
	BL  __aeabi_idiv

	# Calculate the remainder
	MUL r2, r0, r1						// r2 = quotient * divisor
	SUB r0, r4, r2						// r0 = remainder from dividend

	# Pop the stack record and return
	Return_rem:
		LDR lr, [sp, #0]
		LDR r4, [sp, #4]				// restore preserved register
		ADD sp, sp, #8
		MOV pc, lr

.data
# End rem

