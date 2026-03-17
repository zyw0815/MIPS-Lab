.data
    prompt1: .asciiz "Please input the first integer: "
    prompt2: .asciiz "Please input the second integer: "
    prompt3: .asciiz "Please input the third integer: "
    result: .asciiz "The minimum integer is: "

.text
.globl main
main:
    #prompt for input x
    la $a0, prompt1
    li $v0, 4
    syscall

    #user input x
    li $v0, 5
    syscall

    #store x
    move $s0, $v0

    #prompt for input y
    la $a0, prompt2
    li $v0, 4
    syscall

    #user input y
    li $v0, 5
    syscall

    #store y
    move $s1, $v0

    #prompt for input z
    la $a0, prompt3
    li $v0, 4
    syscall

    #user input z
    li $v0, 5
    syscall

    #store z
    move $s2, $v0

    #initiate m with x
    move $s3, $s0

ycompare:
    slt $t0, $s1, $s3
    bne $t0, $zero, ymin
    j zcompare

ymin:
    move $s3, $s1

zcompare:
    slt $t0, $s2, $s3
    bne $t0, $zero, zmin
    j end

zmin:
    move $s3, $s2

end:
    #print the result
    la $a0, result
    li $v0, 4
    syscall

    move $a0, $s3
    li $v0, 1
    syscall

    #end
    li $v0, 10
    syscall