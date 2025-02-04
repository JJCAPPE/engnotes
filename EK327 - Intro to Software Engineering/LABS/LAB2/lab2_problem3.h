#ifndef LAB2_PROBLEM3_H
#define LAB2_PROBLEM3_H
#include <string>
/**
* Helper struct to pass along an array of characters representing a
* string as well as their size.
*/
struct CharArrayWithSize {
int size;
const char* charArray;
};
/**
* This function should return a string representation of substrings of
* all lengths of the string represented by input.charArray.
*
* The substrings should be separated by the newline character \n.
*
* The substrings should be ordered first by length (shorters strings first),
* and then by their appearance in the input string (leftmost first).
*
* Substrings that contain the excludeChar character at any location,
* should be excluded from the resulting string. Note that the exclusion should
* happen after the substring has been computed not before (this will be obvious
* from the examples below).
*
* Identical substrings should be repeated. For example, in the string "hello",
* both single character substrings, 'l', should be included.
*
* The last substring should also have a trailing newline character.
*
* For example, if called with ({5, "hello"}, 'a'), the function should return:
* "h\ne\nl\nl\no\nhe\nel\nll\nlo\nhel\nell\nllo\nhell\nello\nhello\n", which when
* printed should look like:
*
* h
* e
* l
* l
* o
* he
* el
* ll
* lo
* hel
* ell
* llo
* hell
* ello
* hello
*
* And if called with ( {8, "computer"}, 'p' ) the function should return:
*
* c
* o
* m
* u
* t
* e
* r
* co
* om
* ut
* te
* er
* com
* ute
* ter
* uter
*
* When called with an input that should return no substrings at all, the function
* should return an empty string, "".
*
* Note that the return type of the function is std::string, a C++ style string,
* while the input is an
* array of characters (equivalent to char*), which is a C-style string. We will do
* a lot more with
* C-style strings later, but for this problem please be aware of the following
things:
*
* 1) you can access C-style strings like you would any other array
* 2) You can concatenate a C-style string to a C++ string with cString +=
* cStyleString;
* 3) For above to work as expected, the cStyleString should have a null character,
* '\0', as its last character. So, when building the C-style string, allocate one
* extra space
* in the array and set the last element to '\0'.
*/
std::string allSubstringsWithoutChar(CharArrayWithSize input, char excludeChar);

#endif // LAB2_PROBLEM3_H