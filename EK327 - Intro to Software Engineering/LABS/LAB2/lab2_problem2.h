#ifndef LAB2_PROBLEM2_H
#define LAB2_PROBLEM2_H
/**
* @return the sum of the following three things:
* 1) sum of all the digits in the number
* 2) the second to last digit of the number (0 if the number only has 1 digit)
* 3) the second digit of the number (0 of the numer only has 1 digit)
*
* The method should work for positive and negative numbers.
*
* Examples:
* digitSums(178) returns 30 because:
* 1) 1 + 7 + 8 = 16
* 2) second to last digit is 7
* 3) second digit is 7
*
* digitSums(-9834) returns 35 because:
* 1) 9 + 8 + 3 + 4 = 24
* 2) second to last digit is 3
* 3) second digit is 8
*
* digitSums(8) returns 8 because:
* 1) single digit is 8 and there is no second to last or second digit
*/
int digitSums(int number);

#endif //LAB2_PROBLEM2_H