#include <iostream>

/*
WHEN TO MANAGE MEMORY?
    - Stack is dynamically allocated and cleared so no need in functions
    - When memory is on heap (env variables)
    -  When size or lifetime of memory cannot be determinaed at compile time (eg linked list)

COMMANDS

malloc is the request to allocate memory
    - NULL if memory is full

free deallocates

realloc resizes previously allocated memory (eg growing array)
*/

int *roundUp(float number)
{
    int *roundedUp = (int *)malloc(sizeof(int)); // allocates memory on heap, retunrs a pointer, so when it is returned as a pointer you are given the actual adress
    *roundedUp = (int)number + 1;
    return roundedUp;
}
// issue is we need to free that just allocated memory
// if you dont, its a memory leak
int mainn()
{
    float input = 5.3;
    int *roundedResult = roundUp(input);
    std::cout << "rounded up: " << *roundedResult << std::endl;
    free(roundedResult); // memory is freed and can be used for something else
    return 0;
}

// Example of realloc

int *resizeArray(int *array, int currentSize)
{
    printf("\nResizing at %d. Array before resize:\n", currentSize);
    for (int i = 0; i < currentSize; i++)
    {
        printf("%d ", array[i]);
    }
    int *newArray = (int *)realloc(array, currentSize * 2 * sizeof(int)); // finds space on heap, copies values to it, frees old part and returns pointer to first of new
    //due to array decay, realloc doesnt know by itslef what the size of the old array is, but allocating it with malloc leaves there the size so that realloc can be used without worrying about it
    //can only use realloc on something that was initialised with malloc
    printf("\narray after resize:\n");
    for (int i = 0; i < currentSize * 2; i++)
    {
        printf("%d ", newArray[i]);
    }
    return newArray;
}
int main()
{
    int arraySize = 4;
    int *numbers = (int *)malloc(arraySize * sizeof(int));
    for (int i = 0; i < 100; i++)
    {
        if (i >= arraySize)
        {
            numbers = resizeArray(numbers, arraySize);
            arraySize = arraySize * 2;
        }
        numbers[i] = i;
    }
    free(numbers);
    numbers = NULL; //prevents dangling pointer
}