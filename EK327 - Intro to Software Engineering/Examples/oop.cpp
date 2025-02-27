#include <string>
#include <iostream>

// Basic class declaration
class Point
{
private: // Access modifiers
    int x;
    int y;

public:
    Point(int x, int y); // constructor
    std::string toString() const;
};

class Rectangle
{
private:
    Point lowerLeft;
    Point upperRight;

public:
    Rectangle(Point lowerLeft, Point upperRight);
    bool scale(double xScale, double yScale);
    void translate(int xTranslation, int yTranslation);
    std::string toString() const;
};

Point::Point(int x, int y) : x(x), y(y) {} // equivalent to this:
/*
{
    this->x = x;
    this->y = y;
}
 */

std::string Point::toString() const
{
    return "Point(" + std::to_string(x) + ", " + std::to_string(y) + ")";
}

int main()
{
    Point demoPoint(3, 2); // demo point is the name of the object being initialised
    std::cout << demoPoint.toString() << std::endl;
    return 0;
}