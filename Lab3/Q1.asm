.data
    int: .word 45, -130

.text
.globl main
main:
    #store the int
    la $t0, int
    lw $s0, 0($t0)
    lw $s1, 4($t0)

    #print the int
    move $a0, $s0
    li $v0, 1
    syscall

    li $a0, '\n'
    li $v0, 11
    syscall

    move $a0, $s1
    li $v0, 1
    syscall

    #end
    li $v0, 10
    syscall