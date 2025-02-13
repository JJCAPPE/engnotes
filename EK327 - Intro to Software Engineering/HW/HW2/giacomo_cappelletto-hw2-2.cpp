#include "hw2_problem2.h"
#include "hw2_structs.h"

bool scale(Rectangle *rectangle, double xScale, double yScale)
{
    if (xScale <= 0 || yScale <= 0)
    {
        return false;
    }
    rectangle->upperRight.x *= xScale;
    rectangle->upperRight.y *= yScale;
    return true;
}
