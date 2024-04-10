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
    lw $t3,C
    lw $t4, FF
    lw $t5, S
    add $t0, $t0, $t1
    sub $t3, $t0, $t3
    or $t5, $t3, $t4
    sw $t5, S
exit:    beq, $0, $0, exit
    
