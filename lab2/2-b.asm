.text 
main:
    #main
    li $t0, 30                      #a  
    li $t1, 210                     #b  

    move $a0, $t0                   #put a in a0
    move $a1, $t1                   #put b in a1

    addi $sp, $sp, -8               #add 2 spots on the stack
    sw $a0, 0($sp)                  #put a0 on the stack
    sw $a1, 4($sp)                  #put a1 on the stack

    jal distance                    #store $ra and jump to distance

    addi $sp, $sp, 8                #give the stack back

    add $s0, $v0, $zero             #set $s0 as return value from distance

    j exit                          #exit

distance:
    #distance   
    add $t0, $zero, $zero            #reinitialize t0 to 0

    lw $t2, 0($sp)                   #pull a out of stack and put it in t2
    lw $t3, 4($sp)                   #pull b out of stack and put it in t3

    slt $t0, $t2, $t3                #if a < b - store value in t0
    bne $t0, $zero, swap             #swap if b > a
    sub $v0, $t2, $t3                #return the value
    jr $ra                           #jump back to the ra address

swap:
    #swap a and b
    lw $t0, 0($sp)                  #pull a off stack and put in t0
    lw $t1, 4($sp)                  #pull a off stack and put in t1

    sw $t1, 0($sp)                  #store b in first spot on stack
    sw $t0, 4($sp)                  #store a in second spot on stack

    j distance                      #jump back to distance now that a and b are swapped

exit:
    li $v0 10                       #exit
    syscall
