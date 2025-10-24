.text
.globl main

main:
	li $v0 , 12
	syscall 
	
	
	move $a0 ,$v0
	li $v0, 11
	syscall
	
	li $v0,10
	syscall
	
	