#include "hw2_problem2.h"
#include "hw2_structs.h"
#include <cmath>

bool scale(Rectangle *rectangle, double xScale, double yScale)
{
    if (xScale <= 0 || yScale <= 0)
    {
        return false;
    }
    int currentWidth  = rectangle->upperRight.x - rectangle->lowerLeft.x;
    int currentHeight = rectangle->upperRight.y - rectangle->lowerLeft.y;
    int newWidth  = static_cast<int>(std::trunc(currentWidth * xScale));
    int newHeight = static_cast<int>(std::trunc(currentHeight * yScale));
    if (newWidth <= 0 || newHeight <= 0)
    {
        return false;
    }
    rectangle->upperRight.x = rectangle->lowerLeft.x + newWidth;
    rectangle->upperRight.y = rectangle->lowerLeft.y + newHeight;
    return true;
}