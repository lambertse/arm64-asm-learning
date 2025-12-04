.global _start
.align 4

.data
    instr:  .asciz  "This is our Test String that we will convert.\n"
    outstr: .fill   255, 1, 0

.text

// Function: convert_to_upper
// Parameters:
//   x0 = pointer to input string
//   x1 = pointer to output buffer
// Returns:
//   x0 = length of converted string (excluding null terminator)
// Modifies: x2, x3, x4
convert_to_upper:
    // Function prologue: save frame pointer and link register
    stp x29, x30, [sp, #-32]!   // Allocate 32 bytes and save FP, LR
    mov x29, sp                  // Set up frame pointer
    
    // Save callee-saved registers we'll use
    stp x19, x20, [sp, #16]      // Save x19, x20 in our stack frame
    
    // Use callee-saved registers for our work
    mov x19, x0                  // x19 = input pointer
    mov x20, x1                  // x20 = output pointer
    mov x21, x1                  // x21 = save start of output for length calc
    
convert_loop:
    ldrb w2, [x19], #1           // Load byte and increment input pointer
    
    // Check if character is between 'a' and 'z'
    cmp w2, #'a'
    b.lt not_lowercase           // If less than 'a', skip conversion
    cmp w2, #'z'
    b.gt not_lowercase           // If greater than 'z', skip conversion
    
    // Convert lowercase to uppercase
    sub w2, w2, #('a' - 'A')     // Subtract 32 to convert
    
not_lowercase:
    strb w2, [x20], #1           // Store byte and increment output pointer
    cmp w2, #0                   // Check for null terminator
    b.ne convert_loop            // Continue if not null
    
    // Calculate length
    sub x0, x20, x21             // Length = current pos - start pos
    sub x0, x0, #1               // Don't count null terminator
    
    // Function epilogue: restore registers and return
    ldp x19, x20, [sp, #16]      // Restore saved registers
    ldp x29, x30, [sp], #32      // Restore FP, LR and deallocate stack
    ret                           // Return to caller (jumps to address in x30)

_start:
    // Main program prologue
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Load addresses for function parameters
    adrp x0, instr@PAGE
    add x0, x0, instr@PAGEOFF    // x0 = pointer to input string
    
    adrp x1, outstr@PAGE
    add x1, x1, outstr@PAGEOFF   // x1 = pointer to output buffer
    
    // Save output address for printing later
    mov x19, x1
    
    // Call the conversion function
    bl convert_to_upper           // Branch with Link: saves return addr in x30
    
    // x0 now contains the string length
    mov x2, x0                    // x2 = length for write syscall
    
    // Print the string using write syscall
    mov x0, #1                    // File descriptor 1 (stdout)
    mov x1, x19                   // Pointer to outstr
    mov x16, #4                   // macOS write system call
    svc #0x80
    
    // Exit the program
    mov x0, #0                    // Return code 0
    ldp x29, x30, [sp], #16      // Restore frame pointer and link register
    mov x16, #1                   // macOS exit system call
    svc #0x80
