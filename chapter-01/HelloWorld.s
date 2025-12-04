//
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Linux function services
// X16 - macOS function number
//

.global _start // Provide program starting address

// Setup the parameters to print hello world
// and then call Linux to do it.
_start: mov     X0, #1          // 1 = StdOut
    adr   X1, helloworld       // string to print
    mov   X2, #27              // length of our string
    mov   X16, #4              // macOS write system call
    svc   #0x80                // Call Linux to output the string

// Setup the parameters to exit the program
// and then call macOS to do it.
    mov     X0, #0xAB000000 
    mov     X16, #1  
    svc     #0x80              // Call macOS kernel to terminate

.data:
helloworld:      .ascii  "Hello World! I am lambert\n"
