.data
msg_in: .asciiz "Enter a number: "
msg_mul: .asciiz "\nResult after multiplying by 3: "
msg_even: .asciiz "\nThe number is EVEN\n"
msg_odd: .asciiz "\nThe number is ODD\n"

.text
.globl main

main:
    
    la $a0, msg_in
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      #
    #
    li $t1, 3
    mult $t0, $t1
    mflo $t2           

  
    la $a0, msg_mul
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    
    li $t3, 2
    div $t2, $t3
    mfhi $t4            
    beqz $t4, EVEN
    j ODD

EVEN:
    la $a0, msg_even
    li $v0, 4
    syscall
    j EXIT

ODD:
    la $a0, msg_odd
    li $v0, 4
    syscall

EXIT:
    li $v0, 10
    syscall
