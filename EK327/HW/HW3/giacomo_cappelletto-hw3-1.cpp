#include <stdio.h>
#include <stdlib.h>
#include "hw3_problem1.h"

int stringLenght(const char *string){
    int lenght = 0;
    while (string[lenght] != '\0'){
        lenght++;
    }
    return lenght;
}

char *concatenate(const char *first, const char *second)
{
    const int lenghtFirst = stringLenght(first);
    const int lenghtSecond = stringLenght(second);
    char *concatenated = (char *)malloc(lenghtFirst+lenghtSecond+1); //not forgetting null character
    int currentConcatChar = 0;
    int currentChar = 0;
    while (first[currentChar] != '\0'){
        concatenated[currentConcatChar] = first[currentChar];
        currentChar++;
        currentConcatChar++;
    }
    currentChar = 0;
    while (second[currentChar] != '\0'){
        concatenated[currentConcatChar] = second[currentChar];
        currentChar++;
        currentConcatChar++; 
    }
    concatenated[currentConcatChar] = '\0';
    return concatenated;
}
