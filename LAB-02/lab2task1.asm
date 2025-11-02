.data
message: .asciiz "Hello,From StewieDev"   

.text
.globl main

main:
    li $v0, 4          
    la $a0, message    
    syscall            

    li $v0, 10         
    syscall