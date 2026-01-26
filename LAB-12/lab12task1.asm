# Lab Task 1: Read 5 integers into array, then search for a value.
# If found, print index; else, print "not found".

.data
    arr:        .space 20           # 5 * 4 = 20 bytes
    prompt_num: .asciiz "Enter integer "
    colon:      .asciiz ": "
    prompt_srch:.asciiz "Enter number to search: "
    found_msg:  .asciiz "Number found at index "
    not_found:  .asciiz "Number not found.\n"
    newline:    .asciiz "\n"

.text
.globl main

main:
    la $s0, arr          # base address of array
    li $s1, 5            # array size

    # --- Input 5 integers ---
    li $t0, 0            # i = 0
input_loop:
    bge $t0, $s1, done_input

    # Prompt: "Enter integer i: "
    li $v0, 4
    la $a0, prompt_num
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, colon
    syscall

    li $v0, 5
    syscall
    sll $t1, $t0, 2
    add $t2, $s0, $t1
    sw $v0, 0($t2)

    addi $t0, $t0, 1
    j input_loop

done_input:
    # --- Input search key ---
    li $v0, 4
    la $a0, prompt_srch
    syscall

    li $v0, 5
    syscall
    move $s2, $v0        # $s2 = key to search

    # --- Linear search ---
    li $t0, 0            # index = 0
search_loop:
    bge $t0, $s1, not_found_label

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)
    beq $t3, $s2, found

    addi $t0, $t0, 1
    j search_loop

not_found_label:
    li $v0, 4
    la $a0, not_found
    syscall
    j exit

found:
    li $v0, 4
    la $a0, found_msg
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall