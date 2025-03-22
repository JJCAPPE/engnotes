#include "lab4_problem2.h"
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <iomanip>
#include <iostream>

int fieldCounter(string filenameCSV){
    ifstream file;
    file.open(filenameCSV);

    int maxElements = 0;
    string line;

    while (getline(file, line))
    {
        stringstream ss(line);
        vector<string> elements;
        string element;
        while (ss.peek() != EOF){
            if(ss.peek() == '"'){
                ss >> quoted(element);
                if (ss.peek() == ','){
                    ss.ignore();
                }
            } else {
                getline(ss, element, ',');
            }
            elements.push_back(element);

        }
        int currentElements = static_cast<int>(elements.size());
        if (currentElements > maxElements){
            maxElements = currentElements;
        }
    }
    return maxElements;
}

int main(){
    string filenameCSV = "tast.csv";
    int maxElements = fieldCounter(filenameCSV);
    cout << "Max elements: " << maxElements << endl;
    return 0;
}
