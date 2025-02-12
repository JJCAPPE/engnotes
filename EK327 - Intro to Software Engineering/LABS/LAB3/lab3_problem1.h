#ifndef LAB3_PROBLEM1_H
#define LAB3_PROBLEM1_H
/**
 * @param arr An array of [size] integers
 * @param size The number of integers stored in array [arr]
 * @return The sum of the following for [arr]:
 * * Every element at even index or zero index
 * * Every even element.
 * * The product of the first and last element.
 *
 * @example 1
 * int test[] = {1,2,3};
 * labTwo_pZero(test,3) returns 9 as the sum of:
 * * 1+3 (elements at even index)
 * * 2 (even elements)
 * * 3 (first*last element)
 *
 * @example 2
 * int test2[] = {1,2,3,4};
 * labTwo_pZero(test,4) returns 14 as the sum of:
 * * 1+3 (elements at even index)
 * * 2+4 (even elements)
 * * 4 (first*last element)
 */
int sumElements(int *arr, int size);
#endif // LAB3_PROBLEM1_H