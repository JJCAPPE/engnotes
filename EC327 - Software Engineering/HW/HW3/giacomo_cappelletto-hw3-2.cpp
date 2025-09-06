#include <stdio.h>
#include <stdlib.h>
#include "hw3_problem2.h"

int stringLenght(const char *string)
{
    int lenght = 0;
    while (string[lenght] != '\0')
    {
        lenght++;
    }
    return lenght;
}


ReverseResult reverseOdd(const char **inputStrings, int inputStringsLength)
{
    ReverseResult result;
    result.reversedStrings = (char **)malloc(inputStringsLength * sizeof(char *));
    result.success = true;
    for (int currentStringPos = 0; currentStringPos < inputStringsLength; currentStringPos++)
    {
        const char *originalString = inputStrings[currentStringPos];
        int currentStringLenght = stringLenght(originalString);
        if (currentStringLenght % 2 == 0)
        {
            result.success = false;
            for (int j = 0; j < currentStringPos; j++)
            {
                free(result.reversedStrings[j]);
            }
            free(result.reversedStrings);
            result.reversedStrings = NULL;
            return result;
        }
        char *currentString = (char *)malloc(currentStringLenght + 1);
        for (int i = 0; i < currentStringLenght; i++)
        {
            currentString[i] = originalString[i];
        }
        currentString[currentStringLenght] = '\0';
        for (int currentChar = 0; currentChar < currentStringLenght / 2; currentChar++)
        {
            char temp = currentString[currentChar];
            currentString[currentChar] = currentString[currentStringLenght - currentChar - 1];
            currentString[currentStringLenght - currentChar - 1] = temp;
        }
        result.reversedStrings[currentStringPos] = currentString;
    }
    return result;
}
