//#include <stdio.h> 
#include "hw2_problem2.h"
#include "hw2_structs.h"

void scale(Rectangle *rectangle, double xScale, double yScale)
{
    rectangle->upperRight.x *= xScale;
    rectangle->upperRight.y *= yScale;
}
/* 
int main(){
    Point lowerLeft = createPoint(0, 0);
    Point upperRight = createPoint(10, 10);
    Rectangle rectangle = createRectangle(lowerLeft, upperRight);
    scale(&rectangle, 2.323, 2.2452);
    printf("%s", describeRectangle(rectangle).c_str());
    return 0;
}
 */