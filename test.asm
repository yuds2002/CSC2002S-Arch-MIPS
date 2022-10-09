.data       #Declare memory and constants
    enter: .asciiz "Enter n, followed by n lines of text:\n"
    n: .space 10
    words:  .space 50
.text       #Code section
.globl      main


main:
    la		$a0, enter
    li	    $v0,4		
    syscall

    j		read_num				


read_num:
    la		$a0, n		
    li      $v0, 8
    li      $a1, 5
    syscall

    li      $t0, 0
    lb      $t1, n($0)
    sub    $t1, $t1, 48

    j       read_words
   
read_words:
    mul     $t3, $t1, -4
    addi    $sp, $sp, -8
    sw      $



    la		$a0, words($t0)		
    li      $v0, 8
    li      $a1, 5
    syscall
    addi $t0, $t0, 1
    beq     $t0, $t1, print


print:
    li      $s0, 0

    lw		$a0, words($s0)		
    li      $v0, 8
    li      $a1, 5
    
    syscall
    beq     $s0, $t1, exit
    addi    $s0, 1

exit:

    li		$v0, 10
    syscall