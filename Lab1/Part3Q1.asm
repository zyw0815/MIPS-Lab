.data
    uint: .word 45, 1026

.text
.globl main
main:
    la $t0, uint

    lw $s0, 0($t0)
    lw $s1, 4($t0)

    li $v0, 1
    add $a0, $s0, $zero
    syscall

    li $v0, 11
    li $a0, '\n'
    syscall

    li $v0, 1
    add $a0, $s1, $zero
    syscall

    li $v0, 10
    syscall