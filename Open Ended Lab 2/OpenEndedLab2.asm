# ---------------------------------------------------------------
#  Tiny Sensor Monitor – Open Ended Lab 02 (Corrected)
#  Compatible with MARS / QtSPIM
# ---------------------------------------------------------------

.data
N:      .word   5          # number of sensors
NORM:   .word   50         # >= NORM → normal
CRIT:   .word   80         # >= CRIT → critical

msg0:   .asciiz "\n=== Sensor Monitor ===\n"
msgM:   .asciiz "\nMenu: 1-Read 2-Tot/Avg 3-Cls 4-Flg 5-Sort 6-Srch 0-Exit\n> "
msgR:   .asciiz "Reading #"
msgT:   .asciiz "\nTotal = "
msgA:   .asciiz "\nAvg   = "
msgN:   .asciiz " NML"
msgC:   .asciiz " CRT"
msgF:   .asciiz "\nFlags:\n"
msgNF:  .asciiz " not found\n"
nl:     .asciiz "\n"

sensor: .space 80          # 20 integers * 4 bytes
flag:   .space 20          # 1 byte per sensor

.text
.globl main

# ---------------- MAIN ----------------
main:
        addi $sp,$sp,-8
        sw   $ra,4($sp)
        sw   $fp,0($sp)
        move $fp,$sp

        li $v0,4
        la $a0,msg0
        syscall

menu:
        li $v0,4
        la $a0,msgM
        syscall

        li $v0,5
        syscall
        move $t0,$v0

        beqz $t0,exit
        beq  $t0,1,read
        beq  $t0,2,total
        beq  $t0,3,class
        beq  $t0,4,showflg
        beq  $t0,5,sort
        beq  $t0,6,search
        j    menu

# ---------------- 1. READ ----------------
read:
        lw   $t1,N
        la   $t2,sensor
        la   $t3,flag
        li   $t0,0

rloop:
        bge  $t0,$t1,rdone

        li $v0,4
        la $a0,msgR
        syscall

        li $v0,1
        move $a0,$t0
        syscall

        li $v0,5
        syscall
        sw $v0,0($t2)

        sb $zero,0($t3)

        addi $t2,$t2,4
        addi $t3,$t3,1
        addi $t0,$t0,1
        j rloop

rdone:
        j menu

# ---------------- 2. TOTAL / AVG ----------------
total:
        lw   $t1,N
        la   $t2,sensor
        li   $s0,0
        li   $t0,0

tloop:
        bge  $t0,$t1,tdone
        lw   $t3,0($t2)
        add  $s0,$s0,$t3
        addi $t2,$t2,4
        addi $t0,$t0,1
        j tloop

tdone:
        li $v0,4
        la $a0,msgT
        syscall

        li $v0,1
        move $a0,$s0
        syscall

        li $v0,4
        la $a0,msgA
        syscall

        lw $t4,N
        div $s0,$t4
        mflo $t5

        li $v0,1
        move $a0,$t5
        syscall

        li $v0,4
        la $a0,nl
        syscall

        j menu

# ---------------- 3. CLASSIFY ----------------
class:
        lw   $t1,N
        la   $t2,sensor
        la   $t3,flag
        lw   $t4,NORM
        lw   $t5,CRIT
        li   $t0,0

cloop:
        bge  $t0,$t1,cdone
        lw   $t6,0($t2)
        li   $t7,0

        bge  $t6,$t4,setN
        j chkC

setN:
        ori  $t7,$t7,1

chkC:
        bge  $t6,$t5,setC
        j store

setC:
        ori  $t7,$t7,2

store:
        sb   $t7,0($t3)

        li $v0,4
        la $a0,msgR
        syscall

        li $v0,1
        move $a0,$t0
        syscall

        beqz $t7,next

        andi $t8,$t7,2
        bnez $t8,printC

        li $v0,4
        la $a0,msgN
        syscall
        j next

printC:
        li $v0,4
        la $a0,msgC
        syscall

next:
        li $v0,4
        la $a0,nl
        syscall

        addi $t2,$t2,4
        addi $t3,$t3,1
        addi $t0,$t0,1
        j cloop

cdone:
        j menu

# ---------------- 4. SHOW FLAGS ----------------
showflg:
        li $v0,4
        la $a0,msgF
        syscall

        la $t2,flag
        lw $t1,N
        li $t0,0

flglp:
        bge $t0,$t1,flgdone
        lb  $t3,0($t2)

        li $v0,34       # print hex
        move $a0,$t3
        syscall

        li $v0,4
        la $a0,nl
        syscall

        addi $t2,$t2,1
        addi $t0,$t0,1
        j flglp

flgdone:
        j menu

# ---------------- 5. BUBBLE SORT ----------------
sort:
        lw $t9,N
        la $t2,sensor
        li $t0,0              # i

outer:
        bge $t0,$t9,sorted
        li $t1,0              # j

inner:
        sub $t3,$t9,$t0
        addi $t3,$t3,-1
        bge $t1,$t3,nexti

        mul $t4,$t1,4
        add $t5,$t2,$t4

        lw $t6,0($t5)
        lw $t7,4($t5)

        ble $t6,$t7,skip
        sw  $t7,0($t5)
        sw  $t6,4($t5)

skip:
        addi $t1,$t1,1
        j inner

nexti:
        addi $t0,$t0,1
        j outer

sorted:
        li $v0,4
        la $a0,nl
        syscall
        j menu

# ---------------- 6. SEARCH ----------------
search:
        li $v0,5
        syscall
        move $t0,$v0

        la $t2,sensor
        lw $t1,N
        li $t3,0

srchl:
        bge $t3,$t1,notf
        lw  $t4,0($t2)
        beq $t4,$t0,found
        addi $t2,$t2,4
        addi $t3,$t3,1
        j srchl

found:
        li $v0,4
        la $a0,msgR
        syscall

        li $v0,1
        move $a0,$t3
        syscall

        li $v0,4
        la $a0,nl
        syscall
        j menu

notf:
        li $v0,4
        la $a0,msgNF
        syscall
        j menu

# ---------------- EXIT ----------------
exit:
        move $sp,$fp
        lw   $ra,4($sp)
        lw   $fp,0($sp)
        addi $sp,$sp,8
        li   $v0,10
        syscall
