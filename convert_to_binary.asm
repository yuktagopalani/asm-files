.data
str : .space 30
rev : .space 30
NULL : .byte '\0'

  .text					#text section
   li $v0,5				#input a integer
   syscall
   move $t0,$v0				#moving the value of that integer into register named $t0
  
    la $t1,str				#loading the address of string into $t1
    move $t2,$t1			#moving the value of t1 into 
    addi $t4,$0,2			#$t4=2
    addi $t5,$0,0			#$t5=0
    addi $s0,$0,0			#$s0=0	
    li $t8,'0'				#assigning $t8=0
    while :				#while loop begins
    bnez $t0,add			#if $t0 is not equal to 0 call add
    j end				#jump at end
    add:				
    div $t0,$t4				#$t0/$t4
    mfhi $t3								
    mflo $t0
    add $t3,$t3,$t8			#add $t3=$t3+$t8
    sb $t3,0($t2)			#saving the value of $t3 in array 
    addi $t2,$t2,1			#$t2=$t2+1
    addi $t5,$t5,1			#$t5=$t5+1
    addi $s0,$s0,1			#$s0=$s0+1
    j while				#jump to while
   
    end:				#
    la $t3,rev
    move $t4,$t3
    addi $t5,$0,0
    insert:
    bgt $t5,$s0,final
    addi $t2,$t2,-1
    lb $t7,0($t2)
    sb $t7,0($t4)
    addi $t4,$t4,1
    addi $t5,$t5,1
     j insert
     
    
     
   
    final:
    addi $t6,$0,0
    sb $t6,0($t4)
    move $a0,$t3
    li $v0,4
    syscall
    li $v0,10						
    syscall

