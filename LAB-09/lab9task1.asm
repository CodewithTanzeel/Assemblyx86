# Program: 
#   - Read integer from user
#   - Compare with 10
#   - Compute left shift (<< 4) and right shift (>> 4)
#   - Display results

.data
    prompt:        .asciiz "Enter an integer: "
    greater_msg:   .asciiz "The number is greater than 10.\n"
    less_msg:      .asciiz "The number is less than 10.\n"
    equal_msg:     .asciiz "The number is equal to 10.\n"
    left_shift_msg:.asciiz "Left shift by 4 bits: "
    right_shift_msg:.asciiz "Right shift by 4 bits: "
    newline:       .asciiz "\n"

.text
.globl main

main:
    # Prompt and read integer
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # $t0 = user input

    # --- Compare with 10 ---
    li $t1, 10
    bgt $t0, $t1, print_greater
    blt $t0, $t1, print_less
    j print_equal

print_greater:
    li $v0, 4
    la $a0, greater_msg
    syscall
    j shifts

print_less:
    li $v0, 4
    la $a0, less_msg
    syscall
    j shifts

print_equal:
    li $v0, 4
    la $a0, equal_msg
    syscall

shifts:
    # --- Left shift: input << 4 ---
    sll $t2, $t0, 4        # $t2 = input << 4

    li $v0, 4
    la $a0, left_shift_msg
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    # --- Right shift: input >> 4 (arithmetic) ---
    sra $t3, $t0, 4        # $t3 = input >> 4 (sign-extended)

    li $v0, 4
    la $a0, right_shift_msg
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall