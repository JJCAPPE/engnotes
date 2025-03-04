#include "lab3_problem1.h"

int sumElements(int *arr, int size)
{
    if (size <= 0) return 0; 
    int sum = 0;

    for (int i = 0; i < size; i++)
    {
        if (i % 2 == 0 || i == 0)
        {
            sum += arr[i];
        }
        if (arr[i] % 2 == 0)
        {
            sum += arr[i];
        }
    }
    
    sum += arr[0] * arr[size - 1];

    return sum;
}
