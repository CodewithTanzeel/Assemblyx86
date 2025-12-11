.data
msg_day1:      .asciiz "Enter usage for Day 1 (minutes): "
msg_day2:      .asciiz "Enter usage for Day 2 (minutes): "
msg_day3:      .asciiz "Enter usage for Day 3 (minutes): "
msg_invalid:   .asciiz "Invalid (<= 0). Enter again.\n"
msg_total:     .asciiz "\nTotal usage (minutes): "
msg_avg:       .asciiz "\nAverage usage (minutes): "
msg_safe:      .asciiz "\nResult: SAFE\n"
msg_excess:    .asciiz "\nResult: EXCESSIVE\n"
msg_flag:      .asciiz "Pass flag value: "

.text
.globl main
main:
    # read valid usage for day 1
read_d1:
    li   $v0, 4
    la   $a0, msg_day1
    syscall

    li   $v0, 5          # read_int
    syscall
    move $t0, $v0        # day1 in t0

    blez $t0, invalid1   # if <= 0, ask again
    j    ok1
invalid1:
    li   $v0, 4
    la   $a0, msg_invalid
    syscall
    j    read_d1
ok1:

    # read valid usage for day 2
read_d2:
    li   $v0, 4
    la   $a0, msg_day2
    syscall

    li   $v0, 5
    syscall
    move $t1, $v0        # day2 in t1

    blez $t1, invalid2
    j    ok2
invalid2:
    li   $v0, 4
    la   $a0, msg_invalid
    syscall
    j    read_d2
ok2:

    # read valid usage for day 3
read_d3:
    li   $v0, 4
    la   $a0, msg_day3
    syscall

    li   $v0, 5
    syscall
    move $t2, $v0        # day3 in t2

    blez $t2, invalid3
    j    ok3
invalid3:
    li   $v0, 4
    la   $a0, msg_invalid
    syscall
    j    read_d3
ok3:

    # total = t0 + t1 + t2
    add  $t3, $t0, $t1
    add  $t3, $t3, $t2       # t3 = total

    # print total
    li   $v0, 4
    la   $a0, msg_total
    syscall

    li   $v0, 1
    move $a0, $t3
    syscall

    # average = total / 3
    li   $t4, 3
    div  $t3, $t4            # total / 3
    mflo $t5                 # t5 = average

    # print average
    li   $v0, 4
    la   $a0, msg_avg
    syscall

    li   $v0, 1
    move $a0, $t5
    syscall

    # threshold = 120 minutes
    li   $t6, 120

    # pass_flag initially 0
    li   $t7, 0              # bit0 = 1 means SAFE

    # if average <= 120 -> SAFE
    ble  $t5, $t6, is_safe
    j    is_excess

is_safe:
    # set bit0 using OR (pass_flag |= 1)
    ori  $t7, $t7, 1

    li   $v0, 4
    la   $a0, msg_safe
    syscall
    j    show_flag

is_excess:
    li   $v0, 4
    la   $a0, msg_excess
    syscall

show_flag:
    li   $v0, 4
    la   $a0, msg_flag
    syscall

    li   $v0, 1
    move $a0, $t7
    syscall

    # exit
    li   $v0, 10
    syscall
