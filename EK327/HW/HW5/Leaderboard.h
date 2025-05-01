#ifndef LEADERBOARD_H
#define LEADERBOARD_H
#include <string>
#include <vector>
#include <utility>
#include <map>
#include <functional>

class Leaderboard
{
private:
    // Use a custom comparator to sort by scores (ints) in descending order
    std::map<int, std::set<std::string>, std::greater<int>> scoreMap;
    std::unordered_map<std::string, int> playerScores;
public:
    /**Adds a new player or updates the score if the player 
     * already exists. If the player already exists, this function 
     * should properly update the player with the correct score. */ 
    void addOrUpdatePlayer(const std::string &username, int score);
    // Removes a player from the leaderboard
    void removePlayer(const std::string &username);
    // Returns the top N players sorted by highest score (descending order)
    std::vector<std::pair<std::string, int>> getTopN(int N) const;
};
#endif