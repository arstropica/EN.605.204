# Filename: conversions.s
# Author: Akin Williams
# Date: 23/10/2022
# Purpose: Conversion Function Library
#
# Functions defined:
#   - CToF
#   - InchesToFt
#
# Changes: 23/10/2022 - Initial release
.global CToF
.global InchesToFt

# Function: CToF
# Purpose: Convert an integer value for temperature from celsius to fahrenheit.
#
# Input:    r0 - integer temperature in celsius
#
# Output:   r0 - integer temperature in fahrenheit
.text
CToF:
    # Push the stack record
    SUB sp, sp, #4
    STR lr, [sp, #0]

	# Multiply by immediate value
	MOV r1, #9
	MUL r0, r0, r1

	# Divide by immediate value
	MOV r1, #5
	BL __aeabi_idiv

	# Add immediate value
	ADD r0, r0, #32

    # Pop the stack record
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
# End CToF

# Function: InchesToFt
# Purpose: Convert an integer value for inches to feet and inches.
#
# Input:    r0 - integer value for inches
#
# Output:   r0 - integer value for feet
#			r1 - integer value for inches
.text
InchesToFt:
	# Push the stack record
	# Use additional 8 bytes to save r4 and r5
	SUB sp, sp, #12
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]

	# Store original input value in preserved register
	MOV r4, r0

	# Divide by immediate value
	MOV r1, #12
	BL __aeabi_idiv

	# Calculate the quotient multiple
	MUL r5, r0, r1

	# Subtract the quotient multiple for a remainder
	SUB r1, r4, r5

	# Pop the stack record
	LDR r5, [sp, #8]
	LDR r4, [sp, #4]
	LDR lr, [sp, #0]
	ADD sp, sp, #12
	MOV pc, lr

.data
# End InchesToFt

