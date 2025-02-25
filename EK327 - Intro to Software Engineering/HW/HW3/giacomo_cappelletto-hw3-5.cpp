#include "hw3_problem5.h"
#include <stdlib.h>

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

CoinArray returnComposition(int remainder, Coin divisor){
    CoinArray composition;
    int currentRemainder = remainder / divisor;
    if (currentRemainder > 0){
        
    }
}

CoinArrays possibleChangeAmounts(int totalCents){
    CoinArrays coinArrays;



    return coinArrays;
}

int main(){
    int result = 0 / 25;
    printf("%d\n", result);
    return 0;
}