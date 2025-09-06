#ifndef HW2_PROBLEM2_H
#define HW2_PROBLEM2_H
#include "hw2_structs.h"
/**
* Given a rectangle, modify it by scaling it around its bottom left corner.
* That is, that corner should remain unchanged, however the top right corner
* should be adjusted to reflect a scaling of the rectangle's horizontal and
* vertical sides by the passed in factors. Scaling by factor of one,
* indicates that there is no change to that side. The upper right
* coordinates should be returned to integer form by truncating the scaled
* result.
*
* Scaling factors of zero or smaller should be rejected - the function
* should return false and the rectangle left unchanged.
*
* If the scaling results in an illegal rectangle - the bottom left corner is
* no longer the bottom left corner, the function should leave the rectangle
* unchanged and return false.
*
* If the scaling result is legal, the function
* should return true. A rectangle where both corners are the same point is
* considered illegal. A rectangle where the length of either side is zero
* is also illegal.
*
* For example, given a rectangle with bottom left corner of (-3,8)
* and upper right corner of (2, 20), an xScale of 4 and
* yScale of 0.4, this function should modify the rectangle to have
* bottom left corner at (-3, 8) and upper right corner at (17, 12)
* and return.
*
* However, given a rectangle with bottom left corner of (-3,8)
* and upper right corner of (2, 20), an xScale of 0.01 and
* yScale of 0.01, this function should false and not modify the
* rectangle because its two corners would now both be (-3, 8).
*
* If the passed in rectangle is illegal, i.e. it is current left corner
* is not really the left corner, the behavior is undefined.
*
* @param rectangle original rectangle
* @param xScale horizontal scaling factor
* @param yScale vertical scaling factor
* @return true if the rectangle has been modified
*/
bool scale(Rectangle *rectangle, double xScale, double yScale);
#endif //HW2_PROBLEM2_H