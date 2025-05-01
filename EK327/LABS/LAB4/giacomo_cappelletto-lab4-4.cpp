#include "lab4_problem4.h"
#include <algorithm>

Person::Person(string name){
    this->name = name;
}


void Person::befriend(Person &thePerson){
    this->friends.push_back(&thePerson);
}

void Person::unfriend(Person &thePerson){
    for (auto person = friends.begin(); person != friends.end(); person++)
    {
        if (*person == &thePerson){
            friends.erase(person);
            break;
        }
    }
}

int Person::getFriendCount(){
    return static_cast<int>(friends.size());
}

string Person::getFriends(){
    string allFriends = "";
    for (auto person = friends.begin(); person != friends.end(); person++){
        if (!allFriends.empty()) {
            allFriends += ", ";
        }
        allFriends += (*person)->name;
    }
    return allFriends;
}

string Person::getFriendsOfFriends() {
    string allFriendsOfFriends = "";
    vector<Person *> seen;
    for (auto person : friends) {
        for (auto friendOfFriend : person->friends) {
            if (find(seen.begin(), seen.end(), friendOfFriend) == seen.end()) {
                seen.push_back(friendOfFriend);
                if (!allFriendsOfFriends.empty())
                    allFriendsOfFriends += ", ";
                allFriendsOfFriends += friendOfFriend->name;
            }
        }
    }
    return allFriendsOfFriends;
}