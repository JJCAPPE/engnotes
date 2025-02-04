#ifndef LAB2_PROBLEM1_H
#define LAB2_PROBLEM1_H
#include <string>

/**
* Parameter n represents the length of the sides of a square. * goal of this function is to construct a string that puts
* the '
-
' character along both diagonals of that square. * diagonalStars(5) should return a string that when printed
* with std::cout << diagonalStars(5) << std::endl; looks like:
* - -
* - -
* -
* - -
* - - -
*
* when called with the number 4, the string should look like:
* - -
* --
* --
* - -
*
The
For example,
* when printed.
*
* There should NOT be a trailing newline at the very end.
*
* If the function is called with 0 or a negative number, it should
* return the string "Not Supported"
.
*/
std::string diagonalStars(int n);
#endif //LAB2_PROBLEM1_H