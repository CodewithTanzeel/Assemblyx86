# Fibonacci Sequence Generator in MIPS

.data
    prompt:     .asciiz "Enter the upper limit (N): "
    newline:    .asciiz "\n"
    space:      .asciiz " "

.text
.globl main

main:
    # Prompt for N
    li $v0, 4
    la $a0, prompt
    syscall

    # Read N
    li $v0, 5
    syscall
    move $s0, $v0          # $s0 = N (limit)

    # Handle edge case: N < 0
    blt $s0, $zero, exit

    # Initialize Fibonacci variables
    li $s1, 0              # F(0) = 0
    li $s2, 1              # F(1) = 1

    # Print first term if within limit
    bgt $s1, $s0, skip_first
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, space
    syscall
skip_first:

    # Check if second term (1) is within limit
    bgt $s2, $s0, done

    # Print second term
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, space
    syscall

loop:
    # Compute next Fibonacci: $s3 = $s1 + $s2
    add $s3, $s1, $s2

    # If next > N, break
    bgt $s3, $s0, done

    # Print next term
    li $v0, 1
    move $a0, $s3
    syscall
    li $v0, 4
    la $a0, space
    syscall

    # Update for next iteration
    move $s1, $s2
    move $s2, $s3

    j loop

done:
    # Print newline at end
    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall