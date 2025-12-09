.data
msg_in:   .asciiz "Input: "
msg_m0:   .asciiz "\nMask0: "
msg_m1:   .asasciiz "\nMask1: "
msg_out:  .asciiz "\nOutput (Diagram 1b): "

.text
main:
    li $t0, 0xAAAAAAAA      
    li $t1, 0x0F0F0F0F   
    li $t2, 0x00FF00FF      

    
    or  $t3, $t0, $t1        
    nor $t4, $t0, $zero      
    and $t5, $t4, $t2        
    or  $t6, $t3, $t5       


    li $v0, 4
    la $a0, msg_in
    syscall

    li $v0, 34              
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, msg_m0
    syscall

    li $v0, 34
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, msg_m1
    syscall

    li $v0, 34
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, msg_out
    syscall

    li $v0, 34
    move $a0, $t6
    syscall

    li $v0, 10
    syscall
