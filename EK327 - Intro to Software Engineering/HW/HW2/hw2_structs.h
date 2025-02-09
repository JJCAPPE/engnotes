#ifndef HW2_STRUCTS_H
#define HW2_STRUCTS_H
#include <string>
/**
* Representation of a line in one dimension, defined by two points in one
dimensional space.
*/
struct Line
{
    int pointOne;
    int pointTwo;
};
/**
 * @param pointOne one end of a one dimensional line.
 * @param pointTwo the other end of a one dimensional line.
 * @return newly created Line.
 */
inline Line createLine(int pointOne, int pointTwo)
{
    Line line;
    line.pointOne = pointOne;
    line.pointTwo = pointTwo;
    return line;
}
/**
 * Representation of a single point in two dimensional Cartesian space.
 */
struct Point
{
    int x;
    int y;
    // Overload the == operator
    bool operator==(const Point &other) const
    {
        return x == other.x && y == other.y;
    }
};
/**
 * @param x x coordinate of a point
 * @param y y coordinate of a point
 * @return newly created point with the given coordinates.
 */
inline Point createPoint(int x, int y)
{
    Point point;
    point.x = x;
    point.y = y;
    return point;
}
inline std::string describePoint(Point point)
{
    return "(" + std::to_string(point.x) + ", " + std::to_string(point.y) + ")";
}
/**
* Representation of a rectangle as defined by its lower left corner and upper
right corner.
*/
struct Rectangle
{
    Point lowerLeft;
    Point upperRight;
    // Overload the == operator
    bool operator==(const Rectangle &other) const
    {
        return lowerLeft == other.lowerLeft && upperRight == other.upperRight;
    }
};
/**
* @param lowerLeft lower left corner of a rectangle
* @param upperRight upper right corner of a rectangle
* @return newly created rectangle as defined by its lower left and upper right
corners
*/
inline Rectangle createRectangle(Point lowerLeft, Point upperRight)
{
    Rectangle rectangle;
    rectangle.lowerLeft = lowerLeft;
    rectangle.upperRight = upperRight;
    return rectangle;
}
inline std::string describeRectangle(Rectangle rectangle)
{
    return "Rectangle bottom left coordinates: " +
           describePoint(rectangle.lowerLeft) +
           " and top right coordinates: " +
           describePoint(rectangle.upperRight);
}
#endif // HW2_STRUCTS_H
