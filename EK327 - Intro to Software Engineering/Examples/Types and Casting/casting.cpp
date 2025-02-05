#include <stdio.h>
#include <bitset>
#include <iostream>


int main()
{
    int a = 5;
    int b = 2;
    int c = a / b;
    printf("c is %d \n", c);
    //print c is 2 becasue it truncated back to an int (since there are not varaibles which hold the decimal)

    float d = 8 / 3;
    printf("d is %f \n", d);
    //print d is 2.000000 becasue it truncated  to an int since this / is integer division, then cast to float

   float e = (float)a / b;
    printf("e is %f \n", e); 
    //print e is 2.500000 becasue it cast a to a float before dividing

    float f = 3.14159;

    int g = a;
    printf("g is %d \n", g);
    //print f is 3 becasue it truncated a to an int

    float h = int(f) / 2;
    printf("h is %f \n", h);
    //print h is 1.000000 becasue it cast f to an int before dividing, making it 3/2 = 1.5, truncated again to 1
    return 0;
}