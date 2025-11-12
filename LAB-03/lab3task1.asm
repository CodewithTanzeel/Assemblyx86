.data
msg1: .asciiz "Enter first number: "
msg2: .asciiz "Enter second number: "
menu: .asciiz "\nChoose operation:\n1. Addition\n2. Subtraction\n3. Multiplication\nEnter choice: "
res_msg: .asciiz "\nResult = "

.text
.globl main

main:
    la $a0, msg1
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t0, $v0        
    
    la $a0, msg2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t1, $v0        
    
    la $a0, menu
    li $v0, 4
    syscall

    
    li $v0, 5
    syscall
    move $t2, $v0       

    
    beq $t2, 1, ADDITION
    beq $t2, 2, SUBTRACTION
    beq $t2, 3, MULTIPLICATION
    j EXIT               # if invalid choice

ADDITION:
    addu $t3, $t0, $t1
    j PRINT_RESULT

SUBTRACTION:
    subu $t3, $t0, $t1
    j PRINT_RESULT

MULTIPLICATION:
    mult $t0, $t1
    mflo $t3
    j PRINT_RESULT

PRINT_RESULT:
    la $a0, res_msg
    li $v0, 4
    syscall

    move $a0, $t3
    li $v0, 1
    syscall
    j EXIT

EXIT:
    li $v0, 10
    syscall
