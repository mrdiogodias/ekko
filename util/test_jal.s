/* For gdb: file /home/diogo/Desktop/test_led/assembly/test_jal.elf */

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
    nop
    jal x1, branch1

branch2:
    beq x0, x0, branch2 /* Unreachable */

branch3:
    addi x3, x0, 1
    addi x3, x0, 2

branch1:
    addi x3, x0, 3
    jalr x2, x1, 4
    addi x3, x0, 4
    addi x3, x0, 5
    addi x3, x0, 6

    nop
    nop
    nop
    nop
    nop
    nop