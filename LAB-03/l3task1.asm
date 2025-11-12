.data
msg1: .asciiz "Enter first number: "
msg2: .asciiz "Enter second number: "
msg3: .asciiz "Enter third number: "
msg4: .asciiz "The sum is: "

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

    
    la $a0, msg3
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0   
    
    
    addu $t3, $t0, $t1
    addu $t3, $t3, $t2

    
    la $a0, msg4
    li $v0, 4
    syscall

    move $a0, $t3
    li $v0, 1
    syscall

   
    li $v0, 10
    syscall
