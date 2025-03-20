#include "lab4_problem1.h"
#include <fstream>
#include <string>
#include <iostream>
#include <cctype>


int *alphabetCounter(string filename){
    int *counter = (int*) malloc(26 * sizeof(int));
    ifstream file(filename);
    char ch;
    while(file.get(ch)){
        if (ch >= 'a' && ch <= 'z') {
            counter[ch - 'a']++;
        }
         else if (ch >= 'A' && ch <= 'Z') {
            counter[ch - 'A']++;
        }
    }
    return counter;
}
