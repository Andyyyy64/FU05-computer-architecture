    .data
EIGHT:  .word 8
A:      .word 0
    .text
main:    lw $t0, EIGHT
         sw $t0, A
exit:   beq $0, $0, exit
