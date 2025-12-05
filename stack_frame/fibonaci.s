.global _main
.align 4

.text
fibo:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    stp x19, x20, [sp, #16]
   
    mov x19, #0
    mov x20, #1
    mov w2, #0
    
loop:
    cmp w2, w0
    b.ge exit_loop
    add w2, w2, #1
    
    add x21, x19, x20
    mov x19, x20
    mov x20, x21
    b loop

exit_loop: 
    mov x0, x20
    
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #32
    ret

_main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x0, #10
    bl fibo
    
    // DON'T save to any register, use x0 and x1 directly
    mov x1, x0                     // x1 = result from fibo
    adrp x0, format_str@PAGE       // x0 = format string
    add x0, x0, format_str@PAGEOFF
    
    mov x8, #0 
    bl _printf
    
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret

.section __DATA,__data
format_str:
    .asciz "Fibonacci(10) = %ld\n"
