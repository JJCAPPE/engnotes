#ifndef LAB4_PROBLEM4_H
#define LAB4_PROBLEM4_H


#include <string>
#include <vector>


using namespace std;


/**
* This class represents a person with the following properties:
* - It has a constructor that creates a person with a given name
*      (as a string) and no friends.
* - It has member functions matching the signatures below.
*
* @example
* Person person1 = Person("Jim");
* Person person2 = Person("Jane");
* Person person3 = Person("Bob");
*
* person1.befriend(person2);
* person1.befriend(person3);
* person2.befriend(person1);
*
* person1.getFriendCount() - returns 2 (friends)
* person2.getFriendCount() - returns 1 (friend)
* person3.getFriendCount() - returns 0
*
* person1.getFriends() - returns "Jane, Bob"
* person2.getFriends() - returns "Jim"
*
* person1.getFriendsOfFriends() - returns "Jim"
* person2.getFriendsOfFriends() - returns "Jane, Bob"
*
*/
class Person {


    private:
      string name;
      vector<Person*> friends;

    public:
       Person(string name);
  
       /**
        * Adds thePerson as a friend of this person.
        * @param thePerson person to add as a friend.
        */
       void befriend(Person& thePerson);
  
       /**
        * Removes thePerson as a friend of this person.  If the
        * person was not a friend, then this does nothing.
        * @param thePerson The person to remove.
        */
       void unfriend(Person& thePerson);
  
       /**
     * @return The number of friends this person has.
     */
       int getFriendCount();
  
       /**
        * @return A comma-separated list of the names of all friends
        *    of this person, in any order.
        */
       string getFriends();
  
       /**
        *
        * @return A comma separated list of the names of all friends
        *     of the friends of this person, in any order.
        */
       string getFriendsOfFriends();
  
   };


#endif //LAB4_PROBLEM4_H