.data       #Declare memory and constants
   
    word: .word 1024
    list: .space 1024
    enter: .asciiz "Enter n, followed by n lines of text:\n"
    val: .asciiz "The values are:\n"
.text       #Code section
.globl      main

main:
    la		$a0, enter
    li	    $v0,4		
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0
    #li      $v0, 1
    #syscall
    add     $t0, $0, 0

    #sll     $t1, $a0, 2     # t1 = 4n 
    move    $t1, $a0


    li      $t0, 0
    li      $t9, 4
    la      $s2, word
    #sub     $t7, $t7, $t1
    #sub     $sp, $sp, $t1

    j		read_words				# jump to read_words
    
    
read_words:
   
    move    $a0, $s2
    li      $a1, 28
    li      $v0, 8
    syscall
   

   # li      $v0, 4
   # syscall


    sw      $a0, list($t9)
    #sw      $a0, $t0(list)
    addi 	$t0, $t0, 1
    add     $t9, $t9, 4
    addi    $s2,$s2,28
    beq     $t0, $t1, values_are
    j       read_words


#t1 = t0 = 4n

values_are:
    la		$a0, val
    li	    $v0,4		
    syscall
    j		print				# jump to print
    
print:
    sub     $t9, $t9, 4
    beq     $t0, $0, exit
    sub     $t0, $t0, 1
    
    lw      $t3, list($t9)
    move    $a0, $t3
    li      $v0, 4

    syscall
    
    j		print				# jump to print
    


exit:

    li		$v0, 10
    syscall
    
