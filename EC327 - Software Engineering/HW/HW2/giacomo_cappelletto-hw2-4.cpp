#include "hw2_structs.h"
#include "hw2_problem4.h"
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
    if (fracPart == 0)
    {
        return intStr;
    }
    else
    {
        
        if (fracPart > 0)
        {
            int count = 0;
            while (fracPart > 0 && count < (32 - intStr.length()) && count <= 17)
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
    }

    return intStr + fracStr;
}