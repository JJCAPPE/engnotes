#include "lab2_problem3.h"
#include <string>
//#include <iostream>

using namespace std;

std::string allSubstringsWithoutChar(CharArrayWithSize input, char excludeChar)
{
    string result = "";
    for (int i = 1; i <= input.size; i++)
    {
        for (int j = 0; j < input.size - i; j++)
        {
            string temp = string(input.charArray).substr(j, i);
            if (temp.find(excludeChar) == string::npos)
            {
                result += temp + "\n";
            }
        }
    }
    return result;
}

/* 
int main()
{
    CharArrayWithSize input = {10, "strawberry"};
    char excludeChar = 'r';
    cout << allSubstringsWithoutChar(input, excludeChar) << endl;
    return 0;
}
 */