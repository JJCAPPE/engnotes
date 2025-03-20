#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {

   vector<int> v = {1, 2, 3, 4, 5}; //Can initialize vector with values

   for (int i = 0; i < v.size(); i++) { //.size() gives the length of the vector
       cout << v[i] << " "; //Can index in using [] brackets
   }
   cout << endl;

   vector<string> v2; //Initialize a vector without values
   v2.push_back("Hello"); //.push_back add the values to the back of the list
   v2.push_back("World");
   v2.push_back("!");
   v2.push_back("Goodbye");

   //remove the last element
   v2.erase(v2.begin() + 3); //.erase removes a values from the list

   for (int i = 0; i < v2.size(); i++) {
       cout << v2[i] << " ";
   }
   cout << endl;
   return 0;
}