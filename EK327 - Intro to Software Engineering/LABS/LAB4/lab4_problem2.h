#ifndef LAB4_PROBLEM2_H
#define LAB4_PROBLEM2_H


#include <string>
using namespace std;
/**
* @param filenameCSV A file in CSV (comma-separated values) format,
*   in which each row is a line of fields, separated by commas,
*   following these rules:
*   - Fields may be enclosed in double quotes, or not.
*   - Fields *must* be enclosed in quotes if they contain a comma or
*     double-quote mark.
*   - Double-quotation marks inside quoted fields are doubled.
* @return The maximum number of fields in any line of the file.
*
* @example 1
* Suppose the file "example.csv" contains the following, single line:
* 1729, San Francisco, "Hello, World", "He asked: ""Quo vadis?"""
*
* Then fieldCounter("example.csv") should return 4, corresponding to the
* four fields:
* - 1729
* - San Francisco
* - Hello, World
* - He asked: ""Quo vadis?""
*
* @example 2
* Suppose the file "example2.csv" contains the following lines:
* a,b,c
* "a", "b", "c", "d"
* 1, 2
*
* Then fieldCounter(example2.csv") should return 4, corresponding to the
* line with the most fields ("a", "b", "c", "d").
*/
int fieldCounter(string filenameCSV);


#endif //LAB4_PROBLEM2_H