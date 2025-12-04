// Fixed assembly - print loop
.global _start

.data
startprint:     .ascii  "Print it\n"
buffer:         .space  4           // Buffer for digit conversion
space:        .ascii  " "

.text
_start: 
    mov     X0, #1              // 1 = StdOut
    adrp    X1, startprint@PAGE
    add     X1, X1, startprint@PAGEOFF
    mov     X2, #9              // length of our string
    mov     X16, #4             // macOS write system call
    svc     #0x80               // Call macOS to output the string
    mov     W2, #0              // Start at 0

loop: 
    // Body of the loop
    cmp     W2, #9              // Compare 
    bge     exit_loop
    add     W2, W2, #1          // i = i + 1
    
    // Print w2 
    mov     W20, W2             // Save W2 to W20
    add     W0, W20, #48        // Convert to ASCII
    adrp    X1, buffer@PAGE
    add     X1, X1, buffer@PAGEOFF
    strb    W0, [X1]            // Store byte
    
    mov     X0, #1              // stdout
    mov     X2, #1              // length = 1
    mov     X16, #4             // write syscall
    svc     #0x80
    
    // Print " " 
    mov     X0, #1
    adrp    X1, space@PAGE
    add     X1, X1, space@PAGEOFF
    mov     X2, #1
    mov     X16, #4
    svc     #0x80
    
    mov     W2, W20             // Restore register W2
    b       loop 
exit_loop:

// Setup the parameters to exit the program
    mov     X0, #0              // Exit code 0
    mov     X16, #1             // exit syscall
    svc     #0x80               // Call macOS kernel to terminate
