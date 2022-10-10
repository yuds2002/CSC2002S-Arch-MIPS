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
    la      $s7, cells

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
    beq     $k0, $t0, exit
    move    $a0, $t1
    li      $a1, 4
    li      $v0, 8
    syscall
    

    lb		$s1, 0($a0)		
    beq		$s1, '=', equals	
    
    jal		get_int			# jump to sum and save position to $ra
    
    

    sw		$a0, cells($s0)
    add		$s0, $s0, 4		# $s0 = $s0 + 4
    
    add     $t1, $t1, 4     # t1 = address of inputs

    add		$k0, $k0, 1		# $t0 = $t0 + 1
    j		while			# jump to while


get_int:
    lb		$s1, 0($a0)
    beq		$s1, '\n', sum	# if $s1 == '\n' then sum
    sub     $s1, $s1, 48
    mul     $t9, $t9, 10
    add     $t9, $t9, $s1
    add     $a0, $a0, 1
    j		get_int			# jump to get_int
    

sum:
    add     $t4, $t4, $t9
    li		$t9, 0		    # $t9 = 0 
    jr		$ra			    # jump to $ra
    

equals:
    add     $a0, $a0, 1
    jal		get_equal_num				# jump to get_equal_num and save position to $ra
    mul     $t7, $t7, 4
    j		exit			# jump to exit
    

get_equal_num:
    lb		$s1, 0($a0)
    beq		$s1, '\n', jump_equal
    sub     $s1, $s1, 48
    mul     $t9, $t9, 10
    add     $t9, $t9, $s1
    add     $a0, $a0, 1
    j		get_equal_num			

jump_equal:
    jr		$ra					# jump to $ra
    

exit:
    move 	$a0, $t4		# $a0 = $t4
    li      $v0, 1
    syscall
    

    li		$v0, 10
    syscall
    
    

    