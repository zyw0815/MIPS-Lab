.data
    prompt: .asciiz "Result of non_leaf(g=10, h=20, i=15, j=5) = "

.text
.globl main
main:
    li $a0, 10    # g = 10
    li $a1, 20    # h = 20
    li $a2, 15    # i = 15
    li $a3, 5     # j = 5

    #run the non_leaf
    jal non_leaf
    #store the result in $s0
    move $s0, $v0

    #print the prompt
    la $a0, prompt
    li $v0, 4
    syscall

    #print the result
    move $a0, $s0
    li $v0, 1
    syscall

    #end
    li $v0, 10
    syscall
    
non_leaf:
    #make 12 bytes space on stack
    addi $sp, $sp, -12
    sw $ra, 8($sp)

    add $t0, $a0, $a1
    add $t1, $a2, $a3

    #pass the parameters to leaf
    move $a0, $t0
    move $a1, $t1

    jal leaf

    #store the return result to f
    move $v0, $v0

    lw $ra, 8($sp)

    #restore the stack
    addi $sp, $sp, 12
    
    jr $ra

leaf:
    sub $v0, $a0, $a1
    jr $ra