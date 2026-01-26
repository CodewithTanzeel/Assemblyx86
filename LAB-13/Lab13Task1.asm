# MIPS Program: Read 12 integers from user, sort in ascending order, display result

.data
    arr:      .space 48          # 12 * 4 = 48 bytes for integer array
    len:      .word 12
    prompt:   .asciiz "Enter integer "
    colon:    .asciiz ": "
    space:    .asciiz " "
    newline:  .asciiz "\n"
    msg1:     .asciiz "Original array: "
    msg2:     .asciiz "Sorted array (ascending): "

.text
.globl main

main:
    la $s0, arr          # $s0 = base address of array
    li $s1, 12           # $s1 = n = 12

    # ---------- Input Phase ----------
    li $t0, 0            # i = 0
input_loop:
    bge $t0, $s1, done_input

    # Print "Enter integer i: "
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, colon
    syscall

    # Read integer
    li $v0, 5
    syscall
    sll $t1, $t0, 2      # offset = i * 4
    add $t2, $s0, $t1
    sw $v0, 0($t2)       # store input in arr[i]

    addi $t0, $t0, 1
    j input_loop

done_input:
    # ---------- Optional: Print original array ----------
    li $v0, 4
    la $a0, msg1
    syscall
    jal print_array

    # ---------- Sort Phase (Bubble Sort - Ascending) ----------
    li $t0, 0            # i = 0 (outer loop)
outer:
    bge $t0, $s1, done_sort

    li $t1, 0            # j = 0 (inner loop)
inner:
    # Compute bound: n - i - 1
    sub $t3, $s1, $t0
    sub $t3, $t3, 1
    bge $t1, $t3, end_inner

    # Load arr[j] and arr[j+1]
    sll $t4, $t1, 2
    add $t5, $s0, $t4
    lw $t6, 0($t5)       # arr[j]
    lw $t7, 4($t5)       # arr[j+1]

    # For ascending: if arr[j] > arr[j+1], swap
    ble $t6, $t7, no_swap

    # Swap
    sw $t7, 0($t5)
    sw $t6, 4($t5)

no_swap:
    addi $t1, $t1, 1
    j inner

end_inner:
    addi $t0, $t0, 1
    j outer

done_sort:
    # ---------- Output Phase ----------
    li $v0, 4
    la $a0, msg2
    syscall
    jal print_array

    # Exit
    li $v0, 10
    syscall

# --------------------------------------------------
# Procedure: print_array
# Prints all 12 elements of array at $s0
# --------------------------------------------------
print_array:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)     # save return address

    li $t0, 0
print_loop:
    bge $t0, $s1, print_done

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $a0, 0($t2)

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j print_loop

print_done:
    li $v0, 4
    la $a0, newline
    syscall

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra