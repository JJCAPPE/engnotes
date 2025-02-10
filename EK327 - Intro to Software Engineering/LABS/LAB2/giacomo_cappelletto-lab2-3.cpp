#include "lab2_problem3.h"
#include <string>
//#include <iostream>

using namespace std;

std::string allSubstringsWithoutChar(CharArrayWithSize input, char excludeChar) {
    string result = "";
    for (int length = 1; length <= input.size; ++length) {
        int maxStart = input.size - length;
        for (int start = 0; start <= maxStart; ++start) {
            string substring = string(input.charArray + start, length);
            if (substring.find(excludeChar) == string::npos) {
                result += substring + "\n";
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