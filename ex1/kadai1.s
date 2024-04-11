    .data
A:  .word 325
B:  .word 25
C:  .word 242
FF: .word 2042
S:  .word 0
    .text
main:
    lw $t0,A
    lw $t1,B
    lw $t2,C
    lw $t3,FF
    add $t4,$t0,$t1 #t4 = A + B
    sub $t5,$t4,$t2 #t5 = t4 - C
    or $t6,$t5,$t3 #t6 = t5 | FF
    sw $t6,S
exit:    beq, $0, $0, exit
    
