.text
.globl main

main:                   # main program entry
    li   $v0, 5         # syscall: read integer
    syscall              # result stored in $v0

    move $a0, $v0       # move the read integer to $a0 (for printing)

    li   $v0, 1         # syscall: print integer
    syscall

    li   $v0, 10        #
    syscall
