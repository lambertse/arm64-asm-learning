HelloWorld: HelloWorld.o
	ld -o HelloWorld HelloWorld.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
HelloWorld.o: HelloWorld.s
	as -g -arch arm64 -o HelloWorld.o HelloWorld.s
