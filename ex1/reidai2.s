    .data
A:
    .word 123
    .word 234
    .word 345
    .word 456
ADDRESS_A:
    .word 20480 #decimal for  0x5000
S:
    .word 0
    .text
main:
    or $t0, $0, $0          #initialize $t0 to 0
    lw $t1, ADDRESS_A       #load the address of A into $t1

    lw $t2, 0($t1)          #t2 = A[0]
    add $t0,$t0,$t2         #t0 = t0 + t2

    lw $t2, 4($t1)          #t3 = A[1]
    add $t0,$t0,$t3

    lw $t2, 8($t1)          #t4 = A[2]
    add $t0,$t0,$t4

    lw $t2, 12($t1)         #t5 = A[3]

    sw $t0, S               #store the sum in S

exit:    beq $0, $0, exit
