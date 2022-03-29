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
    /* x1 = &pointer */
    lui x1, %hi(pointer)
    addi x1, x1, %lo(pointer)

    /* write */
    addi x12, x0, 5
    sb x12, 0(x1) /* pointer[0] = 0x00000010 */

    /* read */
    lw x15, 0(x1) /* x15 = data */
    nop



.section .data
.org 0x200
pointer:
    .word 0x00000000 /* data2[0] => data2 + 0 */
    .word 0x00000000 /* data2[1] => data2 + 4 */
    .word 0x00000000 /* data2[2] => data2 + 8 */
    .word 0x00000000 /* data2[3] => data2 + 12 */