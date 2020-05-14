.data
count: .word 8
numbers: .word 102 3 1 2 4 9 8 29


.text
lw $a0, count # set count arg
la $a1, numbers # load address of first points
jal sortInts



# count (int) of bytes in wordd
# address
printInts:
move $t0, $a0 # save count to t0 so a0 can be used in syscall
li $v0, 1 # set v0 1 for syscall
loop:
ble $t0, $zero, exit # check if count is 0
lw $a0, ($a1) # get word at current address based on count
syscall # stdout word
addi $a1, $a1, 4 # increment word address by 4 bytes
subi  $t0, $t0, 1 # decreament count by 1
j loop

# a0 length
# a1 address to first value
sortInts:
li $t7, 0 # swapped. 0 = true, 1 = false
swappedLoop:  
move $t6, $a0 # move count to t6 so it can be decremeanted
subi $t6, $t6, 1 # Decrement count by 1 since nTh byte is 4 * length - 1
bgtz $t7, printInts # if swapped is false go to print ints
li $t7, 1 # set swapped to false
loopCount:
beq $t6, $zero, swappedLoop # if count = 0, exit to while loop
subi $t5, $t6, 1 # t5 is t6- 1 to get length - 2 value
mul $t0, $t6, 4 # * 4 bytes to get distance from a1
mul $t1, $t5, 4 # * 4 bytes to get (distance from a1) - 1
add $t2, $t0, $a1 # add to a1 address to get actual address
add $t3, $t1, $a1 # value at t2 is now the count - 1 item of the list
lw $t4, ($t2) # load actual value at t2 address into t4
lw $t5, ($t3) # load actual value at t3 address into t5
blt $t4, $t5, swapPositions # branch if t2 is less than t3
# fall through
subi $t6, $t6, 1 # decreament count
j loopCount # return for loop

# t5 is the lesser value word
# t4 is the greate value word
# t3 the lesser value address
# t2 is the greater value address
swapPositions:
sw  $t5, ($t2) # load the word value of t5 into the address of t2
sw  $t4, ($t3) # load the word value of t4 into the address of t3
subi $t6, $t6, 1 # decreament count
li $t7, 0 # set swapped to true
j loopCount # return to 4 loop


exit:
li $v0, 10   # exit code
syscall