.data   
A:  .word   9768                    # 被乗数 A
B:  .word   7456                    # 乗数 B
C:  .word   0                       # 結果 C

.text   
main:
    or      $t0,    $0,     $0      # i = 0
    or      $t1,    $0,     16      # n = 16
    or      $t2,    $0,     $0      # result = 0
    or      $t3,    $0,     1       # x1 = 1 (初期値)
    or      $t4,    $0,     $0      # x2 = 0
    or      $t5,    $0,     $0      # flag = 0
    lw      $t6,    A               # load A
    lw      $t7,    B               # load B

loop:
    beq     $t0,    $t1,    loopend # if i == n goto loopend
    and     $t4,    $t7,    $t3     # x2 = B & x1
    slti    $t5,    $t4,    1       # if x2 == 0 ? 1 : 0
    beq     $t5,    $0,     addC    # if flag == 0 goto addC

left:
    add     $t6,    $t6,    $t6     # A = A + A (shift 1bit left)
    add     $t3,    $t3,    $t3     # x1 = x1 + x1 (shift 1bit left)
    addi    $t0,    $t0,    1       # i++
    j       loop                    # goback loop

addC:
    add     $t2,    $t2,    $t6     # C = C + A
    j       left

loopend:
    sw      $t2,    C

exit:    j       exit