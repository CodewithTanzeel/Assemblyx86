.data
prompt: .asciiz "\n Please input a value for N = "
result: .asciiz " The sum of all positive even integers <= N is "
bye:    .asciiz "\n **** God Bless You ****"
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    blez $v0, end       
    move $t1, $v0     
    li $t0, 0          
loop:
    andi $t2, $t1, 1    
    bne $t2, $zero, skip_add 
    add $t0, $t0, $t1   
skip_add:
    addi $t1, $t1, -1  
    bgtz $t1, loop      
   
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

end:
    
    li $v0, 4
    la $a0, bye
    syscall

    li $v0, 10
    syscall
