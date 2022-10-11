.data       #Declare memory and constants
    cells:  .space 2000
    input: .space 2000
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
    
    
    sw		$a0, cells($s0)
    add		$s0, $s0, 4		# $s0 = $s0 + 4

    lb		$s1, 0($a0)		
    beq		$s1, '=', equals

    jal		get_int			# jump to sum and save position to $ra
    j		return_here				# jump to retun_here
    
    
return_here:

    
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
    move    $s7, $ra
    add     $a0, $a0, 1
    jal		get_equal_num				# jump to get_equal_num and save position to $ra
    mul     $t7, $t7, 4
    lw		$s2, cells($t7)
    
    
    sub     $s3, $s0, 4

    sw      $s2, cells($s3)
    move    $a0, $s2
    jal		add_equal_num				# jump to add_equal_num and save position to $ra
    
    add     $t4, $t4, $t6
    li      $t6, 0
    li      $t7,0
    #li      $v0, 4
    #syscall
    
    j		return_here				# jump to return_here
    
    
    



get_equal_num:
    lb		$s1, 0($a0)
    beq		$s1, '\n', jump_equal
    sub     $s1, $s1, 48
    mul     $t7, $t7, 10
    add     $t7, $t7, $s1
    add     $a0, $a0, 1
    j		get_equal_num			

jump_equal:
    jr		$ra					# jump to $ra
    

add_equal_num:
    lb		$s1, 0($s2)
    beq		$s1, '\n', jump_equal	# if $s1 == '\n' then jump equal
    sub     $s1, $s1, 48
    mul     $t6, $t6, 10
    add     $t6, $t6, $s1
    add     $s2, $s2, 1
    j		add_equal_num
    



exit:
    li		$v0, 4		# $v0 = 4
    la      $a0, val
    syscall

    jal     print_all

    move    $a0, $t4
    li      $v0, 1
    syscall

    li		$v0, 10
    syscall
    
    

print_all:
    beq		$s5, $s0, print_jump_to_exit	# if $s5 == $s0 then print_jump_to_exit
    li      $v0, 4
    lw		$a0, cells($s5)		#
    syscall
    add     $s5, $s5, 4
    j		print_all				# jump to print_all
     
    


print_jump_to_exit:
    jr		$ra					# jump to $ra
    