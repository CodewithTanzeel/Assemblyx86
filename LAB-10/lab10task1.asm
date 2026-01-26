# Prime Number Checker in MIPS
# Input: integer N
# Output: "Prime" if N is prime, "Not Prime" otherwise

.data
    prompt:     .asciiz "Enter a positive integer: "
    prime_msg:  .asciiz "Prime\n"
    not_prime:  .asciiz "Not Prime\n"

.text
.globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = n

    # Handle numbers <= 1 → not prime
    ble $t0, 1, print_not_prime

    # Handle 2 → prime
    li $t1, 2
    beq $t0, $t1, print_prime

    # Check if even → not prime (except 2, already handled)
    andi $t2, $t0, 1
    beq $t2, $zero, print_not_prime

    # Now check odd divisors from 3 to sqrt(n)
    li $t1, 3          # divisor i = 3
loop:
    # Compute i * i
    mul $t2, $t1, $t1
    bgt $t2, $t0, print_prime   # if i*i > n, then prime

    # Check if n % i == 0
    div $t0, $t1
    mfhi $t3           # remainder = n % i
    beq $t3, $zero, print_not_prime

    # i += 2 (only check odd divisors)
    addi $t1, $t1, 2
    j loop

print_prime:
    li $v0, 4
    la $a0, prime_msg
    syscall
    j exit

print_not_prime:
    li $v0, 4
    la $a0, not_prime
    syscall

exit:
    li $v0, 10
    syscall