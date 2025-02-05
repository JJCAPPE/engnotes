#include <iostream>
#include <string>
#include "name_interaction.h" //include header file

int main() {
    std::string name = readNameFromSdtin("What is your name? "); //passing prompt to function as per header
    std::cout << "Hello, " << name << "!" << std::endl;
    return 0;
}