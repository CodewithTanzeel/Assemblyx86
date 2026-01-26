# Fixed: Sum 4 integers and check if sum is even or odd

.data
    prompt:     .asciiz "Enter an integer: "
    sum_msg:    .asciiz "Sum = "
    even_msg:   .asciiz "Even\n"
    odd_msg:    .asciiz "The sum of integers is odd\n"
    newline:    .asciiz "\n"      # ← MUST be in .data

.text
.globl main

main:
    li $t0, 0          # sum = 0
    li $t1, 4          # counter = 4

input_loop:
    beq $t1, $zero, compute_done

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    add $t0, $t0, $v0

    subi $t1, $t1, 1
    j input_loop

compute_done:
    li $v0, 4
    la $a0, sum_msg
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    # Use label 'newline', NOT "\n"
    li $v0, 4
    la $a0, newline
    syscall

    andi $t2, $t0, 1
    beq $t2, $zero, print_even

    li $v0, 4
    la $a0, odd_msg
    syscall
    j exit

print_even:
    li $v0, 4
    la $a0, even_msg
    syscall

exit:
    li $v0, 10
    syscall