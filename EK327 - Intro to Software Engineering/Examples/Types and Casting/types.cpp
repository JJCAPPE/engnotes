#include <stdio.h>

/* 
Type safety:
    how strictly types can interact with each other
    weakly typed langauges are more flexible but can lead to bugs
    strongly typed languages are more strict but can prevent bugs
        dont support operations between different types
        is more perfomrant as the low level implementation is optimised
        C++ is strongly typed
Type checking:
    process of verifying and enforcing constraints of types
    static type checking: done at compile time
        C++ is statically type checked
    dynamic type checking: done at runtime
*/

int main() {
    unsigned int aa = 0x12345678;
    printf("Size of x is %zu bytes \n", sizeof(aa));

    int x = 2;
    double y = 3.5;
    double result = x + y; //converts 2 to double and adds - Lenient Type Safety
    printf("Result is %f \n", result);

    int a = -1;
    unsigned int b = 1; //unsigned int is always positive
    if (a < b) { //a is converted to unsigned int, and therefore they are seen as the same
        printf("a is less than b \n");
    } else {
        printf("a is not less than b \n");
    }

    bool c = x < y; //can compare int and double
    printf(c ? "true" : "false");

    return 0;
}

