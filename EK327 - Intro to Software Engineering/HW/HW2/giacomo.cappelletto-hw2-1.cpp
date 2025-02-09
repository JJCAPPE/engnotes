//#include <stdio.h> 
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

/* int main(){
    Point lowerLeft = createPoint(0, 0);
    Point upperRight = createPoint(2, 2);
    Rectangle rectangle = createRectangle(lowerLeft, upperRight);
    Rectangle translatedRectangle = translate(rectangle, 1, 1);
    printf("Translated rectangle: %s\n", describeRectangle(translatedRectangle).c_str());
    return 0;
} */