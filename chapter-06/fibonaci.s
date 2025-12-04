.global _start
.align 4

.text

fibo:
    // Function prologue: save frame pointer and link register
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    stp x19, x20, [sp, #16]      // Save x19, x20
   
    mov x19, #0
    mov x20, #1

    mov w2, #0

loop:
    cmp w2, w0

    b.ge exit_loop
    add w2, w2, #1
   
    mov x27, x20
    adds x20, x19, x20
    mov x19, x27

    b loop


exit_loop: 

    mov x0, x27
        // Restore registers and return
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #32    
    ret         // Return to caller (jumps to address in x30)



_start:
    // Main program prologue
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x0, #10
    bl fibo

    // Exit the program
    mov x0, #0                    // Return code 0
    ldp x29, x30, [sp], #16      // Restore frame pointer and link register
    mov x16, #1                   // macOS exit system call
    svc #0x80
