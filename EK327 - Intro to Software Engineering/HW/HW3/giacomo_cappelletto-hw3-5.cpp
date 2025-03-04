#include "hw3_problem5.h"
#include <stdlib.h>
#include <stdio.h>
/*
25 -> 10 10 5
10 -> 5 5
5 -> 1 1 1 1 1


Process
div 25 -> if greater than 0, append that many 25's to first array
mod 25 -> remainder
    is remainder >= 10?
        same process with 10
    is remainder >= 5?
        same with 5
    is remainder < 5
        ones
Can do this recursively
*/


#define NUM_COINS 4
Coin availableCoins[NUM_COINS] = {PENNY, NICKEL, DIME, QUARTER};

void findCombinations(int amount, int start, Coin *current, int currentSize, CoinArrays *result) {
    if (amount == 0) {
        Coin *combo = (Coin*)malloc(currentSize * sizeof(Coin));
        for (int i = 0; i < currentSize; i++) {
            combo[i] = current[i];
        }
        result->arrays = (CoinArray*)realloc(result->arrays, (result->size + 1) * sizeof(struct CoinArray));
        result->arrays[result->size].coins = combo;
        result->arrays[result->size].size = currentSize;
        result->size++;
        return;
    }
    for (int i = start; i < NUM_COINS; i++) {
        if (availableCoins[i] > amount)
            break; // Since coins are in ascending order, no coin will fit.
        current[currentSize] = availableCoins[i];
        findCombinations(amount - availableCoins[i], i, current, currentSize + 1, result);
    }
}


CoinArrays possibleChangeAmounts(int totalCents) {
    CoinArrays result;
    result.arrays = NULL;
    result.size = 0;
    Coin tempCombination[totalCents];  
    findCombinations(totalCents, 0, tempCombination, 0, &result);
    qsort(result.arrays, result.size, sizeof(struct CoinArray), compareCoinArrays);
    return result;
}
