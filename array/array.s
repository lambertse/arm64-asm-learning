.global _start
.align 4

.data
    array: .word 10, 20, 30, 40, 50    // Define array with 5 elements
    array_size: .word 5                 // Store the size of the array

.text
_start:
    // Save frame pointer
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Load array address and size
    adrp x0, array@PAGE
    add x0, x0, array@PAGEOFF       // x0 = address of array
    
    adrp x1, array_size@PAGE
    add x1, x1, array_size@PAGEOFF
    ldr w1, [x1]                     // w1 = value of array_size (5)
    
    mov w2, #0                       // w2 = index counter (i = 0)

loop:
    cmp w2, w1                       // Compare index with array size
    b.ge end_loop                    // If i >= size, exit loop
    
    // Load array element at index w2
    ldr w3, [x0, w2, uxtw #2]        // w3 = array[i] (uxtw #2 multiplies by 4)
    
    // Here you can process w3 (current array element)
    // For example, you could add it to a sum, print it, etc.
    
    add w2, w2, #1                   // i++
    b loop                           // Continue loop

end_loop:
    // Restore frame pointer and return
    mov w0, #0                       // return 0
    ldp x29, x30, [sp], #16
    ret
