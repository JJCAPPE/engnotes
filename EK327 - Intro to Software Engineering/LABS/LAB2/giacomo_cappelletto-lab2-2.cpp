#include "lab2_problem2.h"
#include <string>
//#include <iostream>

using namespace std;

int digitSums(int number)
{
    int sum = 0;
    if (number > -10 && number < 10)
    {
        if (number < 0)
        {
            sum += (-number);
        }
        else
        {
            sum += number;
        }
    }
    else
    {
        string numStr = to_string(abs(number));
        for (int i = 0; i < numStr.length(); i++)
        {
            sum += (numStr[i] - '0');
        }
        sum += (numStr[numStr.length() - 2] - '0');
        sum += (numStr[1] - '0');
    }
    return sum;
}
/* 
int main()
{
    int n;
    cout << "Enter the value of n: ";
    cin >> n;

    int result = digitSums(n);
    cout << result << endl;

    return 0;
}
 */