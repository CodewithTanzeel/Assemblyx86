.data
msg1: .asciiz "\nEnter 3 integers for 1st addition:\n"
msg2: .asciiz "\nEnter 3 integers for 2nd addition:\n"
msg3: .asciiz "\nThe sum of 1st addition is: "
msg4: .asciiz "\nThe sum of 2nd addition is: "

.text
.globl main

main:
    
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 5
    syscall
    move $t2, $v0

    
    addu $t3, $t0, $t1
    addu $t3, $t3, $t2

   
    la $a0, msg2
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t4, $v0

    li $v0, 5
    syscall
    move $t5, $v0

    li $v0, 5
    syscall
    move $t6, $v0

    
    addu $t7, $t4, $t5
    addu $t7, $t7, $t6

    
    la $a0, msg3
    li $v0, 4
    syscall

    move $a0, $t3
    li $v0, 1
    syscall

    la $a0, msg4
    li $v0, 4
    syscall

    move $a0, $t7
    li $v0, 1
    syscall

    # Exit
    li $v0, 10
    syscall
