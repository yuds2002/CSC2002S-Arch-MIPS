.data       #Declare memory and constants
    cells:  .space 1024
    input: .space 1024
    prompt:  .asciiz "Enter n and formulae:\n"
    num_words: .word 5
    val:    .asciiz "The values are:\n"
.text       #Code section
.globl      main

main:
    #prompt
    la      $a0, prompt
    li      $v0, 4
    syscall

    la		$a0, num_words
    li      $v0, 5
    syscall

    move    $t0, $v0 
    #t0 = number of cells

    li      $k0,0   #k0 = counter in while
    li      $s0, 0  #s0 = 4k0
    la		$t1, input
    

    #printing var
    li      $t9,0

    j		while				# jump to while

while:
    beq     $k0, $t0, get_sum
    li      $v0, 5
    syscall
    
    sw		$v0, cells($s0)
    add		$s0, $s0, 4		# $s0 = $s0 + 4
    
    add     $t1, $t1, 4     # t1 = address of inputs

    add		$k0, $k0, 1		# $t0 = $t0 + 1
    j		while				# jump to while


get_sum:
    beq     $t9, $s0, exit
    lw      $t2, cells($t9)
    add     $t7, $t7, $t2
    add     $t9, $t9, 4
    j		get_sum				# jump to print_sum
    



exit:
    li      $v0, 1
    move    $a0, $t7
    syscall


    li		$v0, 10
    syscall
    
    

    