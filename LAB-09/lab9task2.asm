# Program: 
#   - Read integer from user
#   - If even: left shift by 2 bits
#   - If odd:  right shift by 1 bit (arithmetic)
#   - Print the result

.data
    prompt:     .asciiz "Enter an integer: "
    result_msg: .asciiz "Result after shift: "
    newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $t0, $v0          # $t0 = input number

    # Check if even: (number & 1) == 0
    andi $t1, $t0, 1
    beq $t1, $zero, is_even

    # --- Odd case: arithmetic right shift by 1 ---
    sra $t2, $t0, 1       # $t2 = input >> 1
    j print_result

is_even:
    # --- Even case: left shift by 2 ---
    sll $t2, $t0, 2       # $t2 = input << 2

print_result:
    # Print message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print result
    li $v0, 1
    move $a0, $t2
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall