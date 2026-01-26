# Program: Display the 5th element (index 4) of an array of 10 integers
# Author: Lab Task
# Compatible with MARS / QtSpim

.data
    arr:      .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    msg:      .asciiz "The 5th element (index 4) is: "
    newline:  .asciiz "\n"

.text
.globl main

main:
    # Load base address of the array into $t0
    la $t0, arr

    # Load the 5th element (index 4) → offset = 4 * 4 = 16
    lw $t1, 16($t0)

    # Print message
    li $v0, 4
    la $a0, msg
    syscall

    # Print the value
    li $v0, 1
    move $a0, $t1
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall