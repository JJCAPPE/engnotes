#ifndef LAB4_PROBLEM1_H
#define LAB4_PROBLEM1_H


#include <string>
using namespace std;


/**
* Reads in the contents of a file, and return the (case-insensitive)
* English-letter frequencies within the file.
* @param filename The name of the file to read.
* @return A new array (allocated on the *heap*) whose i-th entry contains
*    the number of times the i-th letter of the English alphabet appears
*    within the file, either as a capital or lower-case letter.
*
* @example
* If the file "example.txt" contains the following text:
* The quick brown fox jumped over the lazy dog.
*
* Then alphabetCounter("example.txt") will return a 26-integer
* array with, among others, the following values:
* - Its 0th entry will be 1 - because the letter 'a' appears just once in the file.
* - Its 3rd entry will be 2 - there are two 'd' 's in the file.
* - It's 14th entry will be 4 - there are four 'o' 's in the file
*/
int *alphabetCounter(string filename);


#endif //LAB4_PROBLEM1_H