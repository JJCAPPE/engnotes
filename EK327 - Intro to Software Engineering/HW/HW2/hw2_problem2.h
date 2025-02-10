#ifndef HW2_PROBLEM2_H
#define HW2_PROBLEM2_H
/**
* Given a rectangle, modify it by scaling it around its bottom left corner.
That is, that corner should remain
* unchanged, however the top right corner should be adjusted to reflect a
scaling of its horizontal and vertical
* size by the passed in factors. The upper right coordinates should be
returned to integer form by truncating the
* scaled result.
*
* @param rectangle original rectangle
* @param xScale horizontal scaling factor
* @param yScale vertical scaling factor
*/
void scale(Rectangle *rectangle, double xScale, double yScale);
#endif // HW2_PROBLEM2_H