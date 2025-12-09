.data
prompt: .asciiz "Enter an integer: "
msbMsg: .asciiz "\nMSB (bit 31) = "
lsbMsg: .asciiz "\nLSB (bit 0)  = "

        .text
        .globl main

main:
        la   $a0, prompt
        li   $v0, 4
        syscall

        li   $v0, 5        
        syscall
        move $t0, $v0      
       
        li   $t1, 0x80000000   
        and  $t2, $t0, $t1    
        srl  $t2, $t2, 31      
        
        li   $t3, 0x00000001   
        and  $t4, $t0, $t3     
        
        la   $a0, msbMsg
        li   $v0, 4
        syscall

        move $a0, $t2          
        li   $v0, 1
        syscall
       
        la   $a0, lsbMsg
        li   $v0, 4
        syscall

        move $a0, $t4          
        li   $v0, 1
        syscall

       
        li   $v0, 10
        syscall
