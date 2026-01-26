# Factorial Calculator in MIPS using Recursive Procedure (FIXED)
.data
    prompt:     .asciiz "Enter a non-negative integer: "
    result_str: .asciiz "Factorial = "
    newline:    .asciiz "\n"
    error_msg:  .asciiz "Error: Input must be >= 0\n"

.text
.globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $a0, $v0      # argument for factorial

    # Validate input >= 0
    blt $a0, $zero, input_error

    # Call factorial(n) → result in $v0
    jal factorial

    # ⚠️ SAVE RESULT BEFORE USING SYSCALLS!
    move $t0, $v0      # store result in $t0

    # Print "Factorial = "
    li $v0, 4
    la $a0, result_str
    syscall

    # Print result (now in $t0)
    li $v0, 1
    move $a0, $t0      # ✅ correct: use saved result
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    j exit

input_error:
    li $v0, 4
    la $a0, error_msg
    syscall

exit:
    li $v0, 10
    syscall

# --------------------------------------------------
# factorial(n)
# Input: $a0 = n
# Output: $v0 = n!
# --------------------------------------------------
factorial:
    # Base case: if n == 0 or n == 1, return 1
    beq $a0, $zero, base_case
    li $t1, 1
    beq $a0, $t1, base_case

    # Recursive case: n * factorial(n - 1)

    # Save $ra and $a0 on stack
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)

    # Call factorial(n - 1)
    addi $a0, $a0, -1
    jal factorial        # result in $v0

    # Restore n and $ra
    lw   $a0, 0($sp)    # n
    lw   $ra, 4($sp)
    addi $sp, $sp, 8

    # Multiply n * factorial(n-1)
    mul  $v0, $a0, $v0  # result in $v0

    jr $ra

base_case:
    li $v0, 1
    jr $ra