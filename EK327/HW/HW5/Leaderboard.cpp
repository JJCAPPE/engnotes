#include "Leaderboard.h"

void Leaderboard::addOrUpdatePlayer(const std::string &username, int score)
{
    if (playerScores.count(username))
    {
        int oldScore = playerScores[username];
        scoreMap[oldScore].erase(username);
        if (scoreMap[oldScore].empty())
        {
            scoreMap.erase(oldScore);
        }
    }
    playerScores[username] = score;
    scoreMap[score].insert(username);
}

void Leaderboard::removePlayer(const std::string &username)
{
    if (playerScores.count(username))
    {
        int score = playerScores[username];
        scoreMap[score].erase(username);
        if (scoreMap[score].empty())
        {
            scoreMap.erase(score);
        }
        playerScores.erase(username);
    }
}

std::vector<std::pair<std::string, int>> Leaderboard::getTopN(int N) const
{
    if (N <= 0)
    {
        throw std::invalid_argument("N must be positive");
    }
    std::vector<std::pair<std::string, int>> result;
    for (const auto &[score, players] : scoreMap)
    {
        for (const auto &player : players)
        {
            result.emplace_back(player, score);
            if (result.size() == N)
                return result;
        }
    }
    return result;
}
