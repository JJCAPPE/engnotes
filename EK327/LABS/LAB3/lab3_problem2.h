#ifndef LAB3_PROBLEM2_H
#define LAB3_PROBLEM2_H
/**
* Reverses the given null-terminated string.
*
* This function returns a new string which is the reverse of the input string.
* For example, if the input is "Hello, World!", the function should return
* "!dlroW ,olleH". If the input is NULL, the function should return NULL.
*
* The caller is responsible for freeing the returned string.
*
* @param str A pointer to the null-terminated string to be reversed.
* @return A pointer to a new, dynamically allocated string that is the reverse
* of the input string, or NULL if memory allocation fails or if str is NULL.
*/
char* reverseString(const char* str);
#endif //LAB3_PROBLEM2_H