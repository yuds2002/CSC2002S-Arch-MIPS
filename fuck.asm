.data       #Declare memory and constants
    input:  .space  1024
    save:  .space   1024

    numbers:   .space 1024

    prompt: .asciiz "Enter a sum:\n"
    newline: .asciiz "\n"
    
.text       #Code section
.globl      main

main:
    la      $s0, input
    la      $s1, save
    la      $s3, numbers
    li		$t4, 4		# $t4 = 4
    li      $t5, -1
    li      $t9, 0
    li      $k1, 0
    
    li      $t0, 0
    la		$a0, prompt		
    li      $v0,  4
    syscall

    move    $a0, $s0
    li      $a1, 25
    li      $v0, 8
    syscall

    sw      $a0, save($t0)

    lw		$t1, 0($s1)		# 
    
    move 	$a0, $t1		# $a0 = $t1
    li      $v0, 4
    #syscall
    j		split				# jump to split
    
    

split:

    lb		$t2, 0($t1)		# 
    beq     $t2, '+', next_number
    beq     $t2, '\n', next_number

    #add     $t9, $t9, $t2
    sub     $t2, $t2, 48
   

    #print byte
    
    move 	$a0, $t2		# $a0 = $t2
    li      $v0, 1
    #syscall

    # jump to sum and save position to $ra
    
    #add digit it numbers array
    #sb		$t2, ($s3)		# 
    #add		$s3, $s3, 1		# $s3 = $s3 + 1
    #add     $t5, $t5, 1
    
    j       sum
    
    

    #increment byte counter
    #add     $t1, $t1, 1    


    #jal			print_line				# jump to print_line and save position to $ra
    


    j		split				# jump to exit

sum:

    move    $t6,$t1

    sub     $t6, $t6, 1
    lb		$t7, 0($t6)		# 

    add     $t1, $t1, 1
    beq     $t7, '+', dont_mul

    mul     $t9, $t9, 10
    add     $t9, $t9, $t2
    

    

    j		split				# jump to split

dont_mul:
    add     $t9, $t9, $t2
    j		split				# jump to split
    
    

next_number:

    #li		$t9, 0		# $t9 = 0
    

    #sub     $t5,$t4,$t5
    #add		$s3, $s3, $t5		# $s3 = $s3 + $t5
    #li      $t5,0


    #lw		$a0, -4($s3)
    #li      $v0, 1
    #syscall
    #li      $t5,0

    #increment byte counter



    add     $t1, $t1, 1
    
    move    $a0, $t9
    li      $v0, 1
    syscall

    add     $k1, $k1, $t9

    jal			print_line				# jump to print_line and save position to $ra


    li      $t9, 0

    beq     $t2, '\n', exit

    j		split				# jump to split
    

    
print_line:
    la		$a0, newline		# 
    li      $v0, 4
    syscall
    jr		$ra					# jump to $ra
    

exit:

    move $a0, $k1
    li  $v0, 1
    syscall

    li		$v0, 10
    syscall