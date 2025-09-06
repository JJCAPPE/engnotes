#ifndef HW2_PROBLEM4_H
#define HW2_PROBLEM4_H
#include <string>
/**
* Converts a non-negative decimal, potentially fractional, number to binary.
The result should be a string of up to
* 32 bits, where
* * the period is not counted towards the 32 limit
* * the string should not have leading zeros to the left of the decimal point
* * the string should not have trailing zeros to the right of the decimal
point
* * whole numbers should not include a decimal point at all
* * bit should be used up to represent the whole number part first and
remaining bits can then be used to
* * represent the fractional part as accuratedly as possible.
* * numbers larger than the maximum integer that can be represented with 32
bits should return the string:
* "Input number too large!".
* * negative input numbers should return the string:
* "Negative numbers not supported!".
*
* @param num decimal number to convert to a binary fraction.
* @return a string with a maximum of 33 characters - 32 bits (1/0)
representing whole and fractional parts of a number
* separated by a "." chracter as appropriate.
*/
std::string convertToBinaryFraction(double num);
#endif // HW2_PROBLEM4_H