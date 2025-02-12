#include <iostream>

/*
Memory is used in c is in one of 3 places, that are divided from total memory allocated

Call Stack
- memory allocated for local variables in function calls
- implicitly managed (allocated and freed) by compiled code and computer
- intended to be fast and dynamic
    - Consistes of frames that are pushed onto the stack and popped off
    - Memory allocated within a frame is safe until popped
    - Each frame stores
        - function call arguments
        - function local variables
        - program address to return to once the function call is complete

Heap
- explicitly managed by programmer
- retained until explicitly freed
- Biggest block of memory

Data Segment
- global and static variables

*/

// EXAMPLE OF CALL STACK

int square(int n)
{
    int result = n * n; // frame 3, with n = a = 3, is popped off the stack when return is done, and go back to frame 2
    return result;
}
int add(int a, int b)
{
    int result = a + b;
    return result;
}
int sumOfSquares(int x, int y, int z)
{
    int x2 = square(x);    // return from frame 3 is added to frame 2
    int y2 = square(y);    // frame 4, another frame is pushed onto the stack and popped off once returned, add y2 to frame 2
    int z2 = square(z);    // same for frame 5, back to frame 2 with x,y,z,x2,y2,z2
    int sum = add(x2, y2); // frame 6, takes a=x2, b=y2, returns to frame 2
    sum = add(sum, z2);    // frame 7, same thing
    return sum;            // back to frame 2, return result to frame 1 and popped
}
int exampleCallStack()
{
    int a = 3, b = 4, c = 5;            // first frame (main) with a,b,c. This memory will be safe for the whole running of the program
    int result = sumOfSquares(a, b, c); // frame 2 with x,y,z
    std::cout << result << std::endl;
    return 0;
}

// in a recursive function, the call stack is used to store the state of the function call, so a frame would be created for every call of the recursive function until the base case is reached

// Stack overflow is when there are so many frames that the stack is full, and the program will crash

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Take the example of MOV R1 [0x27] or MOV R1 [R2], the second one in memory indirection and [R2] is a pointer

int pointers()
{
    int counter = 10;
    int *counterPointer = &counter; // pointer to address of counter
    std::cout << "counter: " << counter << std::endl;
    std::cout << "counterPointer: " << counterPointer << std::endl;          // counterPointer: 0x16d85edec (example of address of pointer)
    std::cout << "value at counterPointer:" << *counterPointer << std::endl; //* gives value at address
}

// enable passing values to functions without duplication of variable (pass by reference instead of passs by value)
// by default c++ works with pass by value
// enables linked list
// dynamic memory allocation
// pointers always take up then same amount of memory (per os) so might be less than the actual value stored

int counterChange()
{
    int counter = 10;
    int *counterPointer = &counter;
    *counterPointer = 15;                                                    // changing the value at the address, so effectively int counter changes
    std::cout << "counter: " << counter << std::endl;                        // 15
    std::cout << "value at counterPointer:" << *counterPointer << std::endl; // 15
}

int variableChange() // same output as counterChange
{
    int counter = 10;
    int *counterPointer = &counter;
    counter = 15;
    std::cout << "counter: " << counter << std::endl;
    std::cout << "value at counterPointer:" << *counterPointer << std::endl;
}

int bothChange()
{
    int counter = 10;
    int maxValue = 50;
    int *counterPointer = &counter;
    *counterPointer = *counterPointer + 1;                                   // increase counter by 1
    counterPointer = &maxValue;                                              // counterpointer now points to maxValue
    maxValue = maxValue + 1;                                                 // increase maxValue by 1
    std::cout << "counter: " << counter << std::endl;                        // 11
    std::cout << "value at counterPointer:" << *counterPointer << std::endl; // 51
}

// Example of pass by reference
// would ideally use instead of making a copy of large data structures

void increment(int *count)
{
    *count += 1;
}

int incrementMain()
{
    int counter = 10;
    increment(&counter);
    std::cout << "counter: " << counter << std::endl;
    return 0;
}

// example of issue with pass by reference

int *roundUp(float number)
{
    int roundedUp = (int)number + 1;
    return &roundedUp; //returns a pointer to the call stack, once it return though, it will be deleted
}

//would be fine if roundup was void and modified input direclty 
int mainRoundUp()
{
    float input = 5.3;
    int *roundedResult = roundUp(input);
    std::cout << "rounded up: " << *roundedResult << std::endl; //this will print random memory locations
}
