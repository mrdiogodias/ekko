/* For gdb: file /home/diogo/Desktop/test_led/assembly/test_jmps.elf */

/* Vector table */
.org 0x00
.rept 31
    nop
.endr
    jal x0, boot

/* Reset */
.org 0x80
    jal x0, boot

/* Init Registers */
boot:
    mv  x1, x0
    mv  x2, x1
    mv  x3, x1
    mv  x4, x1
    mv  x5, x1
    mv  x6, x1
    mv  x7, x1
    mv  x8, x1
    mv  x9, x1
    mv x10, x1
    mv x11, x1
    mv x12, x1
    mv x13, x1
    mv x14, x1
    mv x15, x1
    mv x16, x1
    mv x17, x1
    mv x18, x1
    mv x19, x1
    mv x20, x1
    mv x21, x1
    mv x22, x1
    mv x23, x1
    mv x24, x1
    mv x25, x1
    mv x26, x1
    mv x27, x1
    mv x28, x1
    mv x29, x1
    mv x30, x1
    mv x31, x1

main:
    nop
    nop
    nop
    nop

    addi x15, x0, 1000    /* X15 = 1000 */

    /* Test BEQ */
    beq x0, x0, branch1
    nop

lbl0:
    beq x0, x15, should_not_branch1
    nop
    beq x0, x0, lbl1

branch1:
    beq x0, x0, lbl0
    nop

should_not_branch1:
    nop

    /* Test BNE */
lbl1:
    bne x0, x0, should_not_branch1
    nop
    bne x0, x15, lbl2
    nop
    beq x0, x0, lbl1

should_not_branch2:
    nop

lbl2:
    /* Test BLT Positive */
    addi x1, x0, 1200
    addi x2, x0, 1400
    blt  x2, x1, should_not_branch2
    blt  x1, x2, lbl3
    beq  x0, x0, lbl2

should_not_branch3:
    nop

lbl3:
    /* Test BLT Negative */
    addi x1, x0, -1400
    addi x2, x0, -1200
    blt  x2, x1, should_not_branch3
    blt  x1, x2, lbl4
    beq  x0, x0, lbl3

should_not_branch4:
    nop

lbl4:
    /* Test BGE Positive */
    addi x1, x0, 1200
    addi x2, x0, 1400
    bge  x1, x2, should_not_branch4
    bge  x2, x1, lbl5
    beq  x0, x0, lbl4

lbl5:
    /* Test BGE Equal */
    addi x1, x0, 1200
    addi x2, x0, 1200
    bge  x2, x1, lbl6
    beq  x0, x0, lbl5

lbl6:
    /* Test BGE Negative */
    addi x1, x0, -1400
    addi x2, x0, -1200
    bge  x1, x2, should_not_branch4
    bge  x2, x1, lbl7
    beq  x0, x0, lbl6

should_not_branch5:
    nop

lbl7:
    /* Test BLTU */
    addi x1, x0, 1200
    addi x2, x0, 1400
    bltu x2, x1, should_not_branch5
    bltu x1, x2, lbl8
    beq  x0, x0, lbl7


should_not_branch6:
    nop

lbl8:
    /* Test BGEU */
    addi x1, x0, 1200
    addi x2, x0, 1400
    bgeu x1, x2, should_not_branch6
    bgeu x2, x1, lbl9
    beq  x0, x0, lbl8

lbl9:
    nop
    nop
    nop
    nop
    nop
