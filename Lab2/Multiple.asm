.data
    prompt1: .asciiz "Please input the first integer: "
    prompt2: .asciiz "Please input the second integer: "
    result1: .asciiz "One number is a multiple of the other.\n"
    result2: .asciiz "Neither number is a multiple of the other.\n"
    errormessage: .asciiz "Error: Cannot divide by zero!\n"

.text
.globl main
main:
    #input x
    la $a0, prompt1
    li $v0, 4
    syscall

    #user input x
    li $v0, 5
    syscall

    #store x
    move $s0, $v0

    #input y
    la $a0, prompt2
    li $v0, 4
    syscall

    #user input y
    li $v0, 5
    syscall

    #store y
    move $s1, $v0

    #x = 0
    beq $s0, $zero, check_y
    beq $s1, $zero, check_x
    j noerror

check_y:
    #x = 0, y = 0
    beq $s1, $zero, error

    #x = 0, y != 0
    j result_true

check_x:
    #x != 0, y = 0
    j result_true

error:
    #print error message
    la $a0, errormessage
    li $v0, 4
    syscall
    j end

noerror:
    #x is a multiple of y
    div $s0, $s1
    mfhi $t0
    beq $t0, $zero, result_true

    #y is a multiple of x
    div $s1, $s0
    mfhi $t0
    beq $t0, $zero, result_true

    #jump to result_false
    j result_false

result_true:
    #print result1
    la $a0, result1
    li $v0, 4
    syscall
    j end

result_false:
    #print result2
    la $a0, result2
    li $v0, 4
    syscall
    j end

end:
    li $v0, 10
    syscall