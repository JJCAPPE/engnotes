#include "lab2_problem1.h"
//#include <iostream>

std::string diagonalStars(int n)
{
    if (n <= 0)
    {
        return "Not Supported";
    }
    else
    {
        std::string result = "";
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (i == j || i == n - j - 1)
                {
                    result += "-";
                }
                else
                {
                    result += " ";
                }  
            }
            result += "\n";
        }
        return result; 
    }
}

/* 
int main()
{
    int n;
    std::cout << "Enter the value of n: ";
    std::cin >> n;

    std::string result = diagonalStars(n);
    std::cout << result << std::endl;

    return 0;
}
 */