# ================================
# Program: Clear MSB of an Integer
# ================================

.data
prompt: .asciiz "Enter an integer: "
result: .asciiz "\nInteger with MSB cleared: "

        .text
        .globl main

main:

        la   $a0, prompt       
        li   $v0, 4
        syscall

        li   $v0, 5            
        syscall
        move $t0, $v0       

 
        li   $t1, 0x7FFFFFFF   
        and  $t2, $t0, $t1    

        
        la   $a0, result
        li   $v0, 4
        syscall

        move $a0, $t2         
        li   $v0, 1
        syscall

       
        li   $v0, 10
        syscall
