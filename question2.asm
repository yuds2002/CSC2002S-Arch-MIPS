.data       #Declare memory and constants
   
    input: .space   1024
    save:  .space   1024
    concat: .space 1024
    prompt: .asciiz "Enter a sum:\n"
    newline: .asciiz "\n"
.text       #Code section
.globl      main

main:
    la      $s0, input
    la      $s1, save
    
    
    la      $s2, concat
    lw		$s3, concat		# 
    

    li      $t9, 4
    li      $t0, 0
    la		$a0, prompt		
    li      $v0,  4
    syscall
    

    li		$s4, 0		# $s4,= 0
    li		$s5, 0		# $s5 = 0
    
    



    
    li		$t3,0    		   
    

    move    $a0, $s0
    li      $a1, 25
    li      $v0, 8
    syscall

    sw      $a0, save($t0)
    lw		$t1, 0($s1)
    j		print				# jump to print
    

print:
    move  $a0, $t1
    li     $v0, 4
    syscall


    j		loop				# jump to loop and save position to $ra
    
    
    
loop:

    
    lb      $t1, 0($s1)
    add     $s1,$s1, 1
    beq     $t1, '+', next_word

    sb		$t1, ($s2)	
    add     $s2, $s2, 1
    add     $t9, $t9, 1
    #move    $a0, $t1
    #li      $v0, 11
    #syscall




   
    beq     $t1, '\n', sum
    j		loop				# jump to loop

        
    
next_word:
    add     $t9, $t9, 4
    add     $s2, $s2, 4
    j		loop				# jump to loop
    

sum:
    
    sub		$t9, $t9, 4	    	# $s2 = $s2 - 4
    sub		$s2, $s2, 4
    beq     $t9, $0, exit
    
    lw		$s4, ($s2)		#
    

    move    $a0,$s4
    li      $v0, 1
    syscall
    jal			print_line				# jump to print_line and save position to $ra
    
    #sub     $s4, $s4, 0
    add     $s5, $s5, $s4
    j		sum				# jump to sum
    

print_line:
    la      $a0,newline
    li      $v0, 4
    syscall
    jr		$ra		# jump to $ra
    				
    
    



exit:
    move    $a0, $s5
    li      $v0, 1
    syscall

    li		$v0, 10
    syscall
    
