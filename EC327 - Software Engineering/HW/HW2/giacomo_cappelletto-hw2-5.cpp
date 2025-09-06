#include "hw2_structs.h"
#include "hw2_problem5.h"
#include <cmath>
#include <sstream>
#include <iomanip>

std::string describeOverlap(Rectangle rectangleOne, Rectangle rectangleTwo)
{
    if (rectangleOne.lowerLeft.x > rectangleTwo.upperRight.x || 
        rectangleTwo.lowerLeft.x > rectangleOne.upperRight.x || 
        rectangleOne.lowerLeft.y > rectangleTwo.upperRight.y || 
        rectangleTwo.lowerLeft.y > rectangleOne.upperRight.y)
    {
        double xDist = rectangleOne.lowerLeft.x - rectangleTwo.lowerLeft.x;
        double yDist = rectangleOne.lowerLeft.y - rectangleTwo.lowerLeft.y;
        double dist = std::sqrt(xDist * xDist + yDist * yDist);
        
        std::ostringstream oss;
        oss << std::fixed << std::setprecision(2) << dist;
        
        return "Rectangles do not overlap.  Distance between lower corners is: " + oss.str() + ".";

    }
    return "Rectangles overlap.";
}