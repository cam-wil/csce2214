.data
    var1: .half 7, 18, 11, 3    #initialize var1 array
    var2: .half 12, 14, 7, 18   #initialize var2 array
    result: .half 0:4           #initialize empty result array
    minus: .asciiz "-"
    equals: .asciiz "="
    newline:   .asciiz	"\n"
.text

main:
    #do main stuff here
    add $t0, $zero, $zero       #intitalizes i or t0 to 0
    add $t1, $zero, $zero       #initializes conditional for bne
    add $t2, $zero, $zero       #initializes offset to 0
    j loop

loop:
    #load base addresses
    la      $s0,    var1             #stores current address of var1 array to $s0
    la      $s1,    var2             #stores current address of var2 array to $s1
    la      $s2,    result           #stores current address of result array in $s3

    #add offsets to base addresses
    add     $s0,    $s0,    $t2      #adds byte offset to $s0: var1
    add     $s1,    $s1,    $t2      #adds byte offset to $s1: var2
    add     $s2,    $s2,    $t2      #adds byte offset to $s2: result

    #load current values from var1[i] and var2[i]
    lh      $t3,    0($s0)           #current value of var1[i]
    lh      $t4,    0($s1)           #current value of var2[i]

    #do the math and store it in result[i]
    sub     $t5,    $t3, $t4         #subracts value in var1 from value in var2
    sh      $t5,     0($s2)          #stores value of t5 to current location in result array
    

    #do the loop stuff
    addi $t2, $t2, 2            #increments byte offset counter by one word
    addi $t0, $t0, 1            #adds 1 to t0, which is our variable i.
    slti $t1, $t0, 4            #sets $t1 high if t0 less than 4
    bne $t1, $zero, loop        #keep loop going if condition not met
    j quit
    
quit:
    li $v0, 10                  #set register to exit
    syscall                     #call to exit

    #s0 is address of var1
    #s1 is address of var2
    #s2 is address of result

    #t0 is loop counter
    #t1 is conditional for bne
    #t2 is byte offset incrementer
    #t3 is current value of var1
    #t4 is current value of var2
    #t5 is current difference of var1 - var2
