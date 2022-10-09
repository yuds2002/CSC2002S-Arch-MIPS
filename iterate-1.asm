.data       #Declare memory and constants
str:   .asciiz "abcdefghi"
.text       #Code section
.globl      main

#Iteration

main:
    li      $s1, 0

loop:
    lb      $t0, str($s1)       #Note the format: label(offset)
    addi	$s1, $s1, 1
    beq     $t0, 'h', exit
    
    j		loop
    
exit:
    li		$v0, 10
    syscall

#===== OR =======
#    la      $s0, str
#loop:
#    lb      $t0, $s0
#    addi	 $s0, $s0, 1
#    beq     $t0, 'h', exit
#    
#    j		loop
