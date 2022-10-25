# Filename: libConversions.s
# Author: Akin Williams
# Date: 23/10/2022
# Purpose: Conversion Function Library
#
# Functions defined:
# 	- miles2kilometer
# 	- kph
#
# Changes: 23/10/2022 - Initial release
.global miles2kilometer
.global kph

# Function: miles2kilometer
# Purpose: Convert an integer distance from miles to kilometers.
#
# Input:	r0 - integer distance in miles
#
# Output:   r0 - integer distance in kilometers
.text
miles2kilometer:
	# Push the stack record
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# Multiply by immediate value first due to floor division by __aeabi_idiv
	# Rounding errors can be avoided with: ((tempc * 161 * 10) + 5) / 100
	MOV r1, #161
	MUL r0, r0, r1

	# Divide by immediate value
	MOV r1, #100
	BL __aeabi_idiv

	# Pop the stack record
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
# End miles2kilometer

# Function: kph
# Purpose: Calculate speed in km/h from distance in miles and hours.
#
# Input:	r0 - integer time in hours
#			r1 - integer distance in miles
#
# Output:   r0 - integer speed in kilometers/hour
.text
kph:
	# Push the stack record
	# Save preserved register to stack
	SUB sp, sp, #8
	STR lr, [sp, #0]
	STR r4, [sp, #4]

	# Store input value for hours in preserved register
	MOV r4, r0

	# Pass input value for miles to miles2kilometer
	MOV r0, r1
	BL miles2kilometer

	# Divide kilometers by hours
	MOV r1, r4
	BL __aeabi_idiv

	# Restore preserved register from stack
	# Pop the stack record
	LDR r4, [sp, #4]
	LDR lr, [sp, #0]
	ADD sp, sp, #8
	MOV pc, lr

.data
# End kph

