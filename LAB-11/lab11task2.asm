# lab11task2.asm - Safe version (no procedure, no jr $ra)

.data
    arr:      .space 40
    msg:      .asciiz "Array initialized to 18:\n"
    space:    .asciiz " "
    newline:  .asciiz "\n"

.text
.globl main

main:
    # Initialize all 10 elements to 18
    la $t0, arr
    li $t1, 0          # index
    li $t2, 18         # value

init_loop:
    beq $t1, 10, print_start
    sll $t3, $t1, 2
    add $t4, $t0, $t3
    sw $t2, 0($t4)
    addi $t1, $t1, 1
    j init_loop

print_start:
    # Print message
    li $v0, 4
    la $a0, msg
    syscall

    # Print array
    la $t0, arr
    li $t1, 0

print_loop:
    beq $t1, 10, exit
    sll $t2, $t1, 2
    add $t3, $t0, $t2
    lw $a0, 0($t3)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall
    addi $t1, $t1, 1
    j print_loop

exit:
    li $v0, 4
    la $a0, newline
    syscall

    # CRITICAL: Use exit syscall — NOT jr $ra!
    li $v0, 10
    syscall