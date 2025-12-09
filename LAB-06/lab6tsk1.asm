.data
msg_in:  .asciiz "Enter a number: "
msg_out: .asciiz "Result after clearing MSB: "

.text
main:
    
    li $v0, 4
    la $a0, msg_in
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0      
    
    li $t1, 0x7FFFFFFF  
    and $t0, $t0, $t1  

    
    li $v0, 4
    la $a0, msg_out
    syscall

    
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10
    syscall
