# MIPS Program: Sort fixed array in descending order (Bubble Sort)
# Array: 3,8,9,2,7,6,4,1,5,10

.data
    arr:   .word 3, 8, 9, 2, 7, 6, 4, 1, 5, 10
    len:   .word 10
    space: .asciiz " "
    newline: .asciiz "\n"
    msg:   .asciiz "Sorted array (descending): "

.text
.globl main

main:
    # Load array base address and length
    la $s0, arr          # $s0 = base address of array
    lw $s1, len          # $s1 = n = 10

    # Bubble Sort (Descending)
    # Outer loop: i from 0 to n-2
    li $t0, 0            # i = 0
outer_loop:
    bge $t0, $s1, print_result   # if i >= n, done sorting

    # Inner loop: j from 0 to n - i - 2
    li $t1, 0            # j = 0
inner_loop:
    # Compute bound: n - i - 1
    sub $t2, $s1, $t0    # t2 = n - i
    sub $t2, $t2, 1      # t2 = n - i - 1
    bge $t1, $t2, end_inner      # if j >= n-i-1, break inner

    # Load arr[j] and arr[j+1]
    sll $t3, $t1, 2      # t3 = j * 4 (offset)
    add $t4, $s0, $t3    # address of arr[j]
    lw $t5, 0($t4)       # t5 = arr[j]
    lw $t6, 4($t4)       # t6 = arr[j+1]

    # Compare for descending: if arr[j] < arr[j+1], swap
    bge $t5, $t6, no_swap

    # Swap arr[j] and arr[j+1]
    sw $t6, 0($t4)
    sw $t5, 4($t4)

no_swap:
    addi $t1, $t1, 1     # j++
    j inner_loop

end_inner:
    addi $t0, $t0, 1     # i++
    j outer_loop

print_result:
    # Print message
    li $v0, 4
    la $a0, msg
    syscall

    # Print sorted array
    li $t0, 0            # index = 0
print_loop:
    bge $t0, $s1, exit   # if index >= n, done

    # Load arr[index]
    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $a0, 0($t2)

    # Print number
    li $v0, 1
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j print_loop

exit:
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall