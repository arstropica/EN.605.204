# Filename: conversionsMain.s
# Author: Akin Williams
# Date: 23/10/2022
# Purpose: Performs temperature and distance conversions.
#
# Functions defined:
#   - main
#
# Changes: 23/10/2022 - Initial release
.global main
.text
main:
    # Push the stack record
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for user temperature input and read integer value
    LDR r0, =promptc
    BL printf
    LDR r0, =format
    LDR r1, =tempc
    BL scanf

    # Prompt for user distance input and read integer value
    LDR r0, =prompti
    BL printf
    LDR r0, =format
    LDR r1, =inches
    BL scanf

    # Pass input value for temperature to CToF function
    LDR r0, =tempc
    LDR r0, [r0, #0]
    BL CToF

    # Store the return value in preserved register
    MOV r4, r0

    # Pass input value for inches to InchesToFt function
    LDR r0, =inches
    LDR r0, [r0, #0]
    BL InchesToFt

    # Store the return values in preserved registers
    MOV r5, r0
    MOV r6, r1

    # Print the temperature result
    LDR r0, =outputc
    LDR r1, =tempc
    LDR r1, [r1, #0]
    MOV r2, r4
    BL printf

    # Print the distance result
    LDR r0, =outputi
    LDR r1, =inches
    LDR r1, [r1, #0]
    MOV r2, r5
    MOV r3, r6
    BL printf

    # Pop the stack record
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    tempc:      .word   0
    inches:     .word   0
    promptc:    .asciz "\nEnter temperature (in Celsius): "
    prompti:    .asciz "\nEnter distance in inches: "
    outputc:    .asciz "\n%d°C is %d°F degree(s) in Fahrenheit.\n"
    outputi:    .asciz "\n%d'' in. is %d\' feet and %d\" inches.\n"
    format:     .asciz "%d"
# End kph

