.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =minutes
    BL scanf
    
    
    LDR r4, =minutes
    LDR r4, [r4]
    MOV r0, r4
    MOV r1, #60
    BL __aeabi_idiv
    MOV r5, r0

    MOV r6, #60
    MUL r0, r5, r6
    SUB r4, r4, r0

    LDR r0, =output
    MOV r1, r5
    MOV r2, r4
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
minutes: .word 0
hours:  .word 0
prompt: .asciz "\nEnter a number of minutes: "
output: .asciz "\nThat is %d hours and %d minutes"
format: .asciz "%d"
