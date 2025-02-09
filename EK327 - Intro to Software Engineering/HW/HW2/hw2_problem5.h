#ifndef HW2_PROBLEM5_H
#define HW2_PROBLEM5_H
#include "hw2_structs.h"
/**
* This function determines if any part, including edges, of two rectangles
overlap.
*
* If the rectangles do overlap, this function indicates that.
* If the rectangles do not overlap, this function returns the distance between
their lower-left corners.
*
* @param rectangleOne one of the two rectangles defined by its lower-left and
upper-right corners.
* @param rectangleTwo the other rectangle defined by its lower-left and
upper-right corners.
* @return "Rectangles overlap." if the rectangles overlap. Otherwise, return
* "Rectangles do not overlap. Distance between lower corners is: NN.NN."
where the distance includes up to 2
* digits after the decimal point.
*/
std::string describeOverlap(Rectangle rectangleOne, Rectangle rectangleTwo);
#endif // HW2_PROBLEM5_H