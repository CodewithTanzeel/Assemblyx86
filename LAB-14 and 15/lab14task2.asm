# Simple Command-Line Calculator in MIPS
# Supports:
#   Binary ops: +, -, *, /, %
#   Unary ops: inv (1/x), sq (x^2)
# Input: operator symbol, then 1 or 2 integers based on op

.data
    prompt_op:     .asciiz "Enter operator (+, -, *, /, %, inv, sq): "
    prompt_a:      .asciiz "Enter first number: "
    prompt_b:      .asciiz "Enter second number: "
    result_msg:    .asciiz "Result: "
    newline:       .asciiz "\n"
    error_msg:     .asciiz "Error or unsupported operation!\n"
    div_zero:      .asciiz "Error: Division by zero!\n"
    inv_note:      .asciiz "Note: Inverse uses integer division (1/x). Only ±1 give non-zero.\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt_op
    syscall

    # Read a single character (operator)
    li $v0, 12        # read character
    syscall
    move $t0, $v0     # $t0 = operator char

    # Consume the newline after char input
    li $v0, 12
    syscall           # read next char (should be newline)
    # (We ignore it; just to clear buffer)

    # Check if unary or binary
    # Unary: 'i' (for "inv"), 's' (for "sq")
    # Binary: '+', '-', '*', '/', '%'

    # Compare for unary ops
    li $t1, 'i'
    beq $t0, $t1, do_inv
    li $t1, 's'
    beq $t0, $t1, do_sq

    # If not unary, assume binary — get two numbers
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 5
    syscall
    move $t1, $v0      # $t1 = a

    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 5
    syscall
    move $t2, $v0      # $t2 = b

    # Dispatch binary operations
    li $t3, '+'
    beq $t0, $t3, op_add
    li $t3, '-'
    beq $t0, $t3, op_sub
    li $t3, '*'
    beq $t0, $t3, op_mul
    li $t3, '/'
    beq $t0, $t3, op_div
    li $t3, '%'
    beq $t0, $t3, op_percent

    # Unsupported op
    j print_error

# === Binary Operations ===
op_add:
    add $t4, $t1, $t2
    j print_result

op_sub:
    sub $t4, $t1, $t2
    j print_result

op_mul:
    mul $t4, $t1, $t2
    j print_result

op_div:
    beq $t2, $zero, error_div_zero
    div $t1, $t2
    mflo $t4
    j print_result

op_percent:
    # Compute (a * b) / 100
    mul $t5, $t1, $t2
    li $t6, 100
    div $t5, $t6
    mflo $t4
    j print_result

# === Unary Operations ===
do_inv:
    li $v0, 4
    la $a0, inv_note
    syscall

    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 5
    syscall
    move $t1, $v0      # $t1 = x

    beq $t1, $zero, error_div_zero
    li $t5, 1
    div $t5, $t1
    mflo $t4
    j print_result

do_sq:
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 5
    syscall
    move $t1, $v0      # $t1 = x

    mul $t4, $t1, $t1
    j print_result

# === Error Handlers ===
error_div_zero:
    li $v0, 4
    la $a0, div_zero
    syscall
    j exit

print_error:
    li $v0, 4
    la $a0, error_msg
    syscall
    j exit

# === Print Result ===
print_result:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall