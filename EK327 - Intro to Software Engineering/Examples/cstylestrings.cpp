#include <stdio.h>
#include <stdlib.h>
#include <iostream>

void printStringLength(char *string)
{
    int index = 0;
    while (string[index] != '\0')
    {
        index++;
    }
    printf("The length of the string is: %d\n", index);
}
int mainn()
{
    char *cstyle = "hello";
    printStringLength(cstyle);
    return 0;
}

// arrays of cstyle strings
// simply pointers to cstyle strings

int allocate()
{
    int totalStrings = 10;
    int charsInString[10];
    char **strings = (char **)malloc(totalStrings * sizeof(char *)); // pointers to pointers to cstyle strings
    strings[0] = (char *)malloc(20 * sizeof(char));
    std::cout << "Enter string up to 20 characters: ";
    std::cin.getline(strings[0], 20);
    printf("first string: %s\n", strings[0]);
    return 0;
}