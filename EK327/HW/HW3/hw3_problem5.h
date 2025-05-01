#ifndef HW3_PROBLEM5_H
#define HW3_PROBLEM5_H
#include <stdio.h>
/**
 * Enum representing all of the coins in circulation.
 */
typedef enum
{
    PENNY = 1,
    NICKEL = 5,
    DIME = 10,
    QUARTER = 25
} Coin;
/**
* Convenience for passing around an array of coins along with their
size.
*/
struct CoinArray
{
    Coin *coins;
    int size;
};
/**
 * Convenience for passing around multiple coin arrays along
 * with the number of total arrays.
 */
struct CoinArrays
{
    struct CoinArray *arrays;
    int size;
};
/**
 * Comparator for Coins so that we can use qsort to sort them
 * in ascending order.
 */
static int compareCoins(const void *a, const void *b)
{
    return *(Coin *)a - *(Coin *)b;
}
/**
 * Comparator for CoinArrays so that we can use qsort to sort
 * the in ascending order by number of Coins in the array.
 */
static int compareCoinArrays(const void *a, const void *b)
{
    return (*(struct CoinArray *)a).size - (*(struct CoinArray *)b).size;
}
/**
 * Utility for printing a collection of coin arrays.
 */
static void printCoinArrays(struct CoinArrays coinArrays)
{
    printf("Have %d arrays:\n", coinArrays.size);
    printf("\n");
    for (int i = 0; i < coinArrays.size; i++)
    {
        printf("Array of size %d:\n", coinArrays.arrays[i].size);
        for (int j = 0; j < coinArrays.arrays[i].size; j++)
        {
            printf("%d, ", coinArrays.arrays[i].coins[j]);
        }
        printf("\n");
    }
}
/**
* Identify all possible ways to use any number of Coins to
* combine to total the totalCents amount.
*
* totalCents is assumed to be a non-negative number.
*
* Requirements:
* 1) resulting combinations should be ordered in ascending order
* with respect to number of coins
* 2) the coins in each combination should be ordered in ascending order
*
* Examples:
*
* possibleChangeAmounts(7) should return the following CoinArrays:
* 1,1,5
* 1,1,1,1,1,1,1
*
* possibleChangeAmounts(12) should return the following CoinArrays:
* 1, 1, 10
* 1, 1, 5, 5
* 1, 1, 1, 1, 1, 1, 1, 5
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
*
* possibleChangeAounts(25) should return the following CoinArrays:
*
* 25
* 5, 10, 10
* 5, 5, 5, 10
* 5, 5, 5, 5, 5
* 1, 1, 1, 1, 1, 10, 10
* 1, 1, 1, 1, 1, 5, 5, 10
* 1, 1, 1, 1, 1, 5, 5, 5, 5
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 10
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5
* 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
*
*/
CoinArrays possibleChangeAmounts(int totalCents);
#endif // HW3_PROBLEM5_H