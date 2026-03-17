.data
    prompt1: .asciiz "Please input x: "  # 定义提示输入x的字符串，标签prompt1
    prompt2: .asciiz "Please input y: "  # 定义提示输入y的字符串，标签prompt2
    rs_string: .asciiz "The result of (x - 2y - 40) is: "  # 定义结果说明字符串

.text           # 伪指令，标记代码段开始，存储CPU要执行的指令
.globl main     # 伪指令，声明main为全局标签，作为程序的入口（MIPS规定必须有main入口）
main:           # 程序入口标签，所有指令从这里开始执行
    # prompt for input（提示输入x）
    la $a0, prompt1  # 将prompt1字符串的地址加载到寄存器$a0
    li $v0, 4        # 将立即数4加载到$v0（4是MIPS“打印字符串”的系统调用号）
    syscall          # 触发系统调用：执行$v0=4对应的操作（打印$a0指向的字符串）

    li $v0, 5        # 将立即数5加载到$v0（5是MIPS“读取整数”的系统调用号）
    syscall          # 触发系统调用：等待用户输入整数，输入值会自动存入$v0

    add $s0, $v0, $zero  # 将$v0中的输入值（x）保存到寄存器$s0

    la $a0, prompt2  # 将prompt2字符串的地址加载到$a0
    li $v0, 4        # $v0=4（打印字符串）
    syscall          # 打印“Please input y: ”

    li $v0, 5        # $v0=5（读取整数）
    syscall          # 等待用户输入y，输入值存入$v0

    add $s1, $v0, $zero  # 将y保存到寄存器$s1

    la $a0, rs_string  # 将结果说明字符串的地址加载到$a0
    li $v0, 4          # $v0=4（打印字符串）
    syscall            # 打印“The result of (x - 2y - 40) is: ”

    # calculation（计算逻辑）
    sll $s1, $s1, 1    # 将$s1（y）左移1位 → 等价于 y × 2（2y）
    sub $s0, $s0, $s1  # $s0 = $s0 - $s1 → x - 2y
    addi $a0, $s0, -40 # $a0 = (x - 2y) + (-40) → x - 2y - 40
    li $v0, 1          # $v0=1 是“打印整数”的系统调用号
    syscall

    # exit（退出程序）
    li $v0, 10       # $v0=10（退出程序的系统调用号）
    syscall          # 触发系统调用：正常退出程序，释放资源