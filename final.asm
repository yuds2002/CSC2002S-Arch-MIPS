.data
correct_number:     .asciiz     "1234+5678+9012+3456"

.text
main:
    la   $t0, correct_number    # $t0 = address of correct_number
    move $t2, $zero             # $t2 = Sum = 0

while:
    lb   $t1, ($t0)             # $t1 = load the current byte

    move $a0, $t1
    li   $v0, 1
    syscall


    beqz $t1, endwhile          # did we reach end of string?
    beq  $t1, '+', continue     # if not, is current char space?
    sub  $t1, $t1, '0'          # if not, convert the digit char to its numeric value
    add  $t2, $t2, $t1          # sum += numeric_value

continue:
    addi $t0, $t0, 1            # correct_number++ (increment pointer)
    j while                     # and loop

endwhile:
    li   $v0, 1                 # $v0 = 1 to print integer in $a0
    move $a0, $t2               # move Sum to $a0
    syscall                     # and print it


li $v0, 10                  # exit program
syscall