    .data
N:      .word 9
ONE:    .word 1
S:      .word 0

    .text
main:
    or $t0, $0, $0          # i = 0
    lw $t1, n       
    lw $t2, ONE
    or $t3, $0, $0          # load result resiter
loop:
    beq $t0, $t1, loopend   # if i == n goto loopend
    add $t0, $t0, $t2       # i++
    add $t3, $t3, $t0       # s += i
    beq $0, $0, loop
loopend:
    sw $t3, S
exit:
    beq, $0, $0, exit
    
