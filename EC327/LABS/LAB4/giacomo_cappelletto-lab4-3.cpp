#include "lab4_problem3.h"
#include <iostream>

Student::Student(string name, int score){
    this->name = name;
    if (score != -1)
    {
        this->quizScores.push_back(score);
    }
}

void Student::addQuizScore(int score){
    quizScores.push_back(score);
}
double Student::getAverageScore(){
    int scoreCount = quizScores.size();
    if (scoreCount == 0)
        return 0;
    double averageScore = 0.0;
    for (int i = 0; i < scoreCount; i++)
    {
        averageScore += quizScores[i];
    }
    averageScore = averageScore / scoreCount;
    return averageScore;
}
