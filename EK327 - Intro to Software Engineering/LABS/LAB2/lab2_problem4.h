#ifndef LAB2_PROBLEM4_H
#define LAB2_PROBLEM4_H
/**
* Helper struct to represent a compound response from the
* identifyGCF function, containing the greatest common
* factor as well as the total number of factors.
*/
struct GreatestCommonFactorResult {
int greatestCommonFactor;
int numberOfCommonFactors;
};
/**
* identifyGCF returns the greatest common factor as
* well as the total number of common factors for
* five input integers.
*
* A common factor is an integer that evenly divides
* all five numbers without leaving a remainder.
*
* The greatest common factor is the largest common
* factor that the five input integers share.
*
* Negative numbers should be treated the same as their
* positive counterparts.
*
* Any number divides zero, so if zero is present
* in the input it does not eliminate any potential
* common factors. However, if all input numbers are zero
* the response should be {0, 0}.
*
* Some examples:
* identifyGCF({ 24, 96, 64, 240, 800 }) returns {8,4}
* identifyGCF({ 14, 42, -56, 98, -28 }) returns {14,4}
* identifyGCF({ 14, 0, -26, 13, 39 }) returns {1,1}
*/
GreatestCommonFactorResult identifyGCF(int input[5]);
#endif //LAB2_PROBLEM4_H