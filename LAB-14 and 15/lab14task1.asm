# MIPS Program: Switch-like Arithmetic Calculator
.data
    prompt_op:   .asciiz "Enter operation (1:+, 2:-, 3:*, 4:/): "
    prompt_a:    .asciiz "Enter first integer: "
    prompt_b:    .asciiz "Enter second integer: "
    result_msg:  .asciiz "Result: "
    invalid_msg: .asciiz "Invalid operation!\n"
    newline:     .asciiz "\n"

    # Jump table for switch cases
    jtable:      .word add_case, sub_case, mul_case, div_case

.text
.globl main

main:
    # Prompt for operation
    li $v0, 4
    la $a0, prompt_op
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # $t0 = operation code


    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 5
    syscall
    move $t1, $v0          # $t1 = a

 
    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 5
    syscall
    move $t2, $v0          # $t2 = b


    blt $t0, 1, invalid
    bgt $t0, 4, invalid

    # Compute index = (op - 1) * 4 (word offset)
    sub $t3, $t0, 1
    sll $t3, $t3, 2        # multiply by 4

    # Load base of jump table
    la $t4, jtable
    add $t4, $t4, $t3      # address of function pointer
    lw $t5, 0($t4)         # load target address
    jr $t5                 # jump to case

invalid:
    li $v0, 4
    la $a0, invalid_msg
    syscall
    j exit

add_case:
    add $t6, $t1, $t2
    j print_result

sub_case:
    sub $t6, $t1, $t2
    j print_result

mul_case:
    mul $t6, $t1, $t2
    j print_result

div_case:
    beq $t2, $zero, div_zero
    div $t1, $t2
    mflo $t6
    j print_result

div_zero:
    li $v0, 4
    la $a0, invalid_msg
    syscall
    j exit

print_result:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall