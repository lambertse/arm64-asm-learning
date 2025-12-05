.global _start
.align 4

.data
    instr:  .asciz  "This is our Test String that we will convert.\n"
    outstr: .fill   255, 1, 0

.text
_start:
    // Save frame pointer and link register
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Load addresses
    adrp x4, instr@PAGE
    add x4, x4, instr@PAGEOFF
    adrp x3, outstr@PAGE
    add x3, x3, outstr@PAGEOFF
    
    // Save the start address of outstr for printing later
    mov x7, x3
    
loop:
    ldrb w5, [x4], #1           // Load byte and increment x4
    
    // Check if character is between 'a' and 'z'
    cmp w5, #'a'
    b.lt not_lower              // If less than 'a', skip conversion
    cmp w5, #'z'
    b.gt not_lower              // If greater than 'z', skip conversion
    
    // Convert lowercase to uppercase
    sub w5, w5, #('a' - 'A')
    
not_lower:
    strb w5, [x3], #1           // Store byte and increment x3
    cmp w5, #0                  // Check for null terminator
    b.ne loop
    
    // Calculate string length (x3 now points past the null terminator)
    sub x2, x3, x7              // x2 = end address - start address
    sub x2, x2, #1              // Don't count the null terminator
    
    // Print the string using write syscall
    mov x0, #1                  // File descriptor 1 (stdout)
    mov x1, x7                  // Pointer to outstr
    mov x16, #4                 // macOS write system call
    svc #0x80
    
    // Exit the program
    mov x0, #0                  // Return code 0
    mov x16, #1                 // macOS exit system call
    svc #0x80
