#include "hw2_structs.h"
#include "hw2_problem4.h"
/* #include <cstdio>
#include <iostream> */
#include <string>

std::string convertToBinaryFraction(double num)
{
    // Check input bounds.
    if (num < 0)
    {
        return "Negative numbers not supported!";
    }
    if (num > 4294967295.0)
    {
        return "Input number too large!";
    }
    
    unsigned int intPart = static_cast<unsigned int>(num);
    double fracPart = num - intPart;
    
    std::string intStr;
    if (intPart == 0)
    {
        intStr = "0";
    }
    else
    {
        while (intPart > 0)
        {
            intStr = std::to_string(intPart % 2) + intStr;
            intPart /= 2;
        }
    }
    
    std::string fracStr = ".";
    if (fracPart > 0)
    {
        int count = 0;
        while (fracPart > 0 && count < 16)
        {
            fracPart *= 2;
            if (fracPart >= 1)
            {
                fracStr += "1";
                fracPart -= 1;
            }
            else
            {
                fracStr += "0";
            }
            count++;
        }
    }
    else
    {
        fracStr += "0";
    }
    
    return intStr + fracStr;
}

/* int main()
{
    double num;
    printf("Enter a number: ");
    if (scanf("%lf", &num) != 1) {
        printf("Invalid input!\n");
        return 1;
    }
    std::string result = convertToBinaryFraction(num);
    printf("%s\n", result.c_str());
    return 0;
} */
