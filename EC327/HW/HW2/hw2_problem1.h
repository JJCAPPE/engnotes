#ifndef HW2_PROBLEM1_H
#define HW2_PROBLEM1_H
#include "hw2_structs.h"
/**
* Given a rectangle, return a new rectangle that represents the translation of
the original one by
* xTranslation along the x-axis and yTranslation along the y-axis.
*
* @param rectangle original rectangle
* @param xTranslation translation along the x-axis
* @param yTranslation translation along the y-axis
* @return a new rectangle representing the translation of the original one.
*/
Rectangle translate(Rectangle rectangle, int xTranslation, int yTranslation);
#endif // HW2_PROBLEM1_H