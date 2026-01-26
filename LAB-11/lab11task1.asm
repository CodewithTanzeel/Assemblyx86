# Program 1: Display the 5th element (index 4) of an array of 10 integers
# Fixed for compatibility with all MARS/SPIM versions

.data
    arr: .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    msg: .asciiz "The 5th element (index 4) is: "

.text
.globl main

main:
    # Load base address of array into $t0
    la $t0, arr

    # Load arr[4] into $t1 (offset = 4 * 4 = 16)
    lw $t1, 16($t0)

    # Print message
    li $v0, 4
    la $a0, msg
    syscall

    # Print the value (move from $t1 to $a0)
    li $v0, 1
    move $a0, $t1
    syscall

    # Print newline
    li $v0, 4
    la $a0, "\n"
    syscall

    # Exit
    li $v0, 10
    syscall