#include "lab2_problem4.h"
#include <cstdlib>

//#include <iostream>

using namespace std;

GreatestCommonFactorResult identifyGCF(int input[5])
{
    bool allZero = true;
    int max = 0;
    int commonFactors = 0;
    int greatestCommonFactor = 0;

    for (int i = 0; i < 5; ++i)
    {
        int num = abs(input[i]);

        if (num > max)
            max = num;

        if (num != 0)
            allZero = false;
    }

    if (allZero)
    {
        GreatestCommonFactorResult res;
        res.greatestCommonFactor = 0;
        res.numberOfCommonFactors = 0;
        return res;
    }
    else
    {
        for (int i = 1; i <= max; ++i)
        {
            bool isCF = true;
            for (int j = 0; j < 5; ++j)
            {
                if (abs(input[j]) % i != 0)
                {
                    isCF = false;
                    break;
                }
            }
            if (isCF)
            {
                commonFactors++;
                greatestCommonFactor = i;
            }
        }

        GreatestCommonFactorResult res;
        res.greatestCommonFactor = greatestCommonFactor;
        res.numberOfCommonFactors = commonFactors;
        return res;
    }
}
/* 
int main()
{
    int input[5] = { 14, 42, -56, 98, -28 };
    GreatestCommonFactorResult result = identifyGCF(input);
    cout << "Greatest common factor: " << result.greatestCommonFactor << endl;
    cout << "Number of common factors: " << result.numberOfCommonFactors << endl;
    return 0;
} */