# Lab Task 2: Find max value and its index in array of 7 integers (Version A)

.data
    arr:        .space 28           # 7 integers × 4 bytes
    msg_in:     .asciiz "Enter integer "
    colon:      .asciiz ": "
    msg_max:    .asciiz "Maximum value = "
    msg_idx:    .asciiz "\nIndex = "
    newline:    .asciiz "\n"

.text
.globl main

main:
    la $t0, arr          # $t0 = array base
    li $t1, 0            # loop counter i

input_loop:
    beq $t1, 7, done_input

    # Prompt
    li $v0, 4
    la $a0, msg_in
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, colon
    syscall

    # Read and store
    li $v0, 5
    syscall
    sll $t2, $t1, 2
    add $t3, $t0, $t2
    sw $v0, 0($t3)

    addi $t1, $t1, 1
    j input_loop

done_input:
    # Initialize max = arr[0], index = 0
    lw $t4, 0($t0)       # max value
    li $t5, 0            # max index

    li $t1, 1            # start from i=1
find_max:
    beq $t1, 7, print_result

    sll $t2, $t1, 2
    add $t3, $t0, $t2
    lw $t6, 0($t3)       # arr[i]

    bgt $t6, $t4, update_max
    j skip

update_max:
    move $t4, $t6        # update max
    move $t5, $t1        # update index

skip:
    addi $t1, $t1, 1
    j find_max

print_result:
    li $v0, 4
    la $a0, msg_max
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, msg_idx
    syscall
    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall