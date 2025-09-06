#include "name_interaction.h"
#include <iostream>

//implementation of function
//in this manner, the function can be worked on from one team and used by another thanks to agreed upon signature

std::string readNameFromSdtin(std::string prompt) {
    std::string name;
    std::cout << prompt;
    std::cin >> name;
    return name;
}