#include "hw2_structs.h"
#include "hw2_problem5.h"

std::string describeOverlap(Rectangle rectangleOne, Rectangle rectangleTwo)
{
    if (rectangleOne.lowerLeft.x > rectangleTwo.upperRight.x || rectangleTwo.lowerLeft.x > rectangleOne.upperRight.x || rectangleOne.lowerLeft.y > rectangleTwo.upperRight.y || rectangleTwo.lowerLeft.y > rectangleOne.upperRight.y)
    {
        double xDist = rectangleTwo.lowerLeft.x - rectangleOne.upperRight.x;
        double yDist = rectangleTwo.lowerLeft.y - rectangleOne.upperRight.y;
        double dist = sqrt(xDist * xDist + yDist * yDist);
        return "Rectangles do not overlap. Distance between lower corners is: " + std::to_string(dist) + ".";
    }
    return "Rectangles overlap.";
}