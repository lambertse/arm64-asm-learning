.global _start 
.align 4


.data
    test_data:
        .word 0x11111111  // Offset 0
        .word 0x22222222  // Offset 4
        .word 0x33333333  // Offset 8
        .word 0x44444444  // Offset 12
.text
_start:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
	adrp	x1, test_data@PAGE
	add	x1, x1, test_data@PAGEOFF   

    ldr x3, [x1, #8]
    ldur    x2, [x1, #8]      
    
    // Return
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret



