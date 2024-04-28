.data   
A:  .word   7, 6, 5, 4, 3, 2, 1             # 整列する配列
N:  .word   7                               # 配列の要素数

.text   
main:
    or      $sp,        $0,         0x7fff  # スタックポインタの上位16ビットを0x7fffに設定
    ori     $sp,        $sp,        0xeffc  # スタックポインタの下位16ビットを0xeffcに設定

    or      $s0,        $0,         2       # $s0 = 2
    or      $s1,        $0,         0       # $s1 = 0
    or      $s2,        $0,         2       # $s2 = 2
    or      $s3,        $0,         4       # $s3 = 4

    la      $a0,        A                   # $a0 = 配列Aのアドレス
    lw      $a1,        N                   # $a1 = 配列の要素数
    jal     sort                            # sortサブルーチンを呼び出す

loop:
    j       loop                            # 無限ループ

sort:
    addi    $sp,        $sp,        -20     # スタックポインタを20バイト分移動
    sw      $ra,        16($sp)             # $raをスタックに退避
    sw      $s3,        12($sp)             # $s3をスタックに退避
    sw      $s2,        8($sp)              # $s2をスタックに退避
    sw      $s1,        4($sp)              # $s1をスタックに退避
    sw      $s0,        0($sp)              # $s0をスタックに退避

    or      $s2,        $a0,        $0      # $s2 = 配列のアドレス
    or      $s3,        $a1,        $0      # $s3 = 配列の要素数
    or      $s0,        $0,         $0      # $s0 = 0 (外側のループカウンタ)

for1tst:
    slt     $t0,        $s0,        $s3     # $t0 = ($s0 < $s3) ? 1 : 0
    beq     $t0,        $0,         exit1   # $t0 == 0ならexit1にジャンプ
    addi    $s1,        $s0,        -1      # $s1 = $s0 - 1 (内側のループカウンタ)

for2tst:
    slti    $t0,        $s1,        0       # $t0 = ($s1 < 0) ? 1 : 0
    beq     $t0,        $0,         cont    # $t0 == 0ならcontにジャンプ
    j       exit2                           # exit2にジャンプ

cont:
    or      $t1,        $s1,        $0      # $t1 = $s1
    add     $t1,        $t1,        $t1     # $t1 = $t1 * 2
    add     $t1,        $t1,        $t1     # $t1 = $t1 * 2 (合計で$t1 = $s1 * 4)
    add     $t2,        $s2,        $t1     # $t2 = 配列のアドレス + $t1 (要素のアドレス)
    lw      $t3,        0($t2)              # $t3 = 要素の値
    lw      $t4,        4($t2)              # $t4 = 次の要素の値
    slt     $t0,        $t4,        $t3     # $t0 = ($t4 < $t3) ? 1 : 0
    beq     $t0,        $0,         exit2   # $t0 == 0ならexit2にジャンプ

    or      $a0,        $s2,        $0      # $a0 = 配列のアドレス
    or      $a1,        $s1,        $0      # $a1 = インデックス
    jal     swap                            # swapサブルーチンを呼び出す
    addi    $s1,        $s1,        -1      # $s1 = $s1 - 1
    j       for2tst                         # for2tstにジャンプ

exit2:
    addi    $s0,        $s0,        1       # $s0 = $s0 + 1
    j       for1tst                         # for1tstにジャンプ

exit1:
    lw      $s0,        0($sp)              # $s0をスタックから復元
    lw      $s1,        4($sp)              # $s1をスタックから復元
    lw      $s2,        8($sp)              # $s2をスタックから復元
    lw      $s3,        12($sp)             # $s3をスタックから復元
    lw      $ra,        16($sp)             # $raをスタックから復元
    addi    $sp,        $sp,        20      # スタックポインタを20バイト分戻す
    jr      $ra                             # 呼び出し元に戻る

swap:
    add     $t1,        $a1,        $0      # $t1 = インデックス
    add     $t1,        $t1,        $t1     # $t1 = $t1 * 2
    add     $t1,        $t1,        $t1     # $t1 = $t1 * 2 (合計で$t1 = インデックス * 4)
    add     $t1,        $a0,        $t1     # $t1 = 配列のアドレス + $t1 (要素のアドレス)
    lw      $t0,        0($t1)              # $t0 = 要素の値
    lw      $t2,        4($t1)              # $t2 = 次の要素の値
    sw      $t2,        0($t1)              # 要素の値を次の要素の値で更新
    sw      $t0,        4($t1)              # 次の要素の値を元の要素の値で更新
    jr      $ra                             # 呼び出し元に戻る