#include "hw2_problem1.h"
#include "hw2_structs.h"

Rectangle translate(Rectangle rectangle, int xTranslation, int yTranslation){
    Point* points[] = {&rectangle.lowerLeft, &rectangle.upperRight};
    for (int i = 0; i < 2; ++i) {
        points[i]->x += xTranslation;
        points[i]->y += yTranslation;
    }
    return rectangle;
}
