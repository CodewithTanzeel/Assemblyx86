.data
result: .asciiz "The product of all odd integers <= 50 is "
bye:    .asciiz "\n**** Have a good day ****"
.text
.globl main
main:
    li $t0, 1     
    li $t1, 50    
loop:
    andi $t2, $t1, 1    
    beq $t2, $zero, skip_mul  

   
    mul $t0, $t0, $t1

skip_mul:
    addi $t1, $t1, -1  
    bgtz $t1, loop      
  
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, bye
    syscall


    li $v0, 10
    syscall
