.data
    st1: .asciiz "Enter value of n : \n"
    st2: .asciiz "Fibonacci Sequence is :\n"
    st3: .asciiz " "
    Arr: .space 100
.text
    li $v0,4		
    la $a0,st1
    syscall
    
    li $v0,5
    syscall
    
    move $t0,$v0
    mul $t0,$t0,4
    
    addi $t1,$0,0
    addi $s0,$0,0
    addi $s1,$0,1
    
    sw $s0,Arr($t1)
    addi $t1,$t1,4
    
    sw $s1,Arr($t1)
    addi $t1,$t1,4
    
    li $v0,4
    la $a0,st2
    syscall
    while:
         bgt $t1,$t0,exit
         add $s2,$s1,$s0
         sw $s2,Arr($t1)
         addi $t1,$t1,4
         move $s0,$s1
         move $s1,$s2
         j while
    exit: 
    
    add $t1,$0,$0
    
    for:
        beq $t1,$t0,exit1
        lw $t2,Arr($t1)
        li $v0,1
        move $a0,$t2
        syscall
        addi $t1,$t1,4
        li $v0,4
        la $a0,st3
        syscall
        j for
    exit1:
     
    li $v0,10
    syscall
    
    