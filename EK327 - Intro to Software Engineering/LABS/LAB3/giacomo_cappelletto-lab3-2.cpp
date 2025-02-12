#include <string>
#include "lab3_problem2.h"

char *reverseString(const char *str)
{
    if (str == nullptr)
    {
        return nullptr;
    }
    int lenght = std::strlen(str);
    char *reverse = new char[lenght + 1];
    for (int i = 0; i < lenght; i++)
    {
        reverse[i] = str[lenght - i - 1];
    }
    reverse[lenght] = '\0'; //null terminate
    return reverse;
}