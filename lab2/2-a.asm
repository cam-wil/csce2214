.text 
main:
    #main
    li $t0, 30                      #a  
    li $t1, 210                     #b  

    move $a0, $t0                   #put a in a0
    move $a1, $t1                   #put b in a1

    jal distance                    #store $ra and jump to distance
    add $s0, $v0, $zero             #set $s0 as return value from distance
    
    j exit                          #exit

distance:
    #distance   
    add $t0, $zero, $zero            #reinitialize t0 to 0
    slt $t0, $a0, $a1                #if a < b - store value in t0
    bne $t0, $zero, swap             #swap if b > a
    sub $v0, $a0, $a1                #return the value
    jr $ra

swap:
    #swap a and b
    add $t7, $zero, $zero           #initialize temp value at $t7 to 0
    add $t7, $a0, $zero             #put a in temp
    add $a0, $a1, $zero             #put b in a
    add $a1, $t7, $zero             #put temp in b

    j distance

exit:
    li $v0 10                       #exit
    syscall
