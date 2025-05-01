#include <cstdio>
#include <iostream>
#include <string>

//issue is something like 1/3 does not converge, allocating loads of memory for not high accuracy
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
        while (fracPart > 0 && count < (32-intStr.length()))
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

//example of the loss of precision due to float use
//float uses different precision system
//(-1)^sign * 2^(exponent - bias) * (1 + mantissa)
//(1 bit for sign, 8 bits for exponent, 23 bits for mantissa)
/* 
For example, consider the decimal number 12.5. Its binary representation as a float would be:
Sign: Positive, so sign = 0
Binary form: 1100.1
Normalized form: 1.1001 x 2^3
Exponent: 3 + bias (127) = 130, which is 10000010 in binary.
Mantissa: 1001 (with trailing zeros to fill 23 bits)
Therefore, the complete binary representation would be:
0 10000010 10010000000000000000000
 */
void showFloatLossiness()
{
    double a = 0.1;
    double b = 0.2;
    double c = a + b;
    double d = c - b;
    printf("a: %.20f\n", a);
    printf("b: %.20f\n", b);
    printf("c: %.20f\n", c);
    printf("d: %.20f\n", d);
    printf("a == d: %s\n", a == d ? "true" : "false");
}

int main()
{
    showFloatLossiness();
    return 0;
    double num;
    printf("Enter a number: ");
    if (scanf("%lf", &num) != 1) {
        printf("Invalid input!\n");
        return 1;
    }
    std::string result = convertToBinaryFraction(num);
    printf("%s\n", result.c_str());
}
