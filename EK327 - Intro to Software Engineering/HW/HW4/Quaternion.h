#ifndef QUATERNION_H
#define QUATERNION_H
#include "GaussianInteger.h"
class Quaternion : public GaussianInteger
{
private:
    int j;
    int k;

public:
    /**
     * Default constructor
     *
     * @return a quaternion with zeros as fields
     */
    Quaternion();
    /**
     * Parameterized constructor
     *
     * @param real real part of Quaternion
     * @param imag imaginary component of Quaternion i
     * @param j imaginary component of Quaternion j
     * @param k imaginary component of Quaternion k
     * @return newly created Quaternion with the given values.
     */
    Quaternion(const int real, const int imag, const int j, const int k);
    /**
     * Copy constructor
     *
     * @param other reference of quaternion to copy from
     * @return new Quaternion that is a copy of other
     */
    Quaternion(const Quaternion &other);
    /**
     * Parameterized constructor
     *
     * @param real real part of Quaternion
     * @param imag imaginary component of Quaternion i
     * @param j imaginary component of Quaternion j
     * @param k imaginary component of Quaternion k
     * @return newly created Quaternion with the given values.
     */
    /**
     * Adds the current quaternion with another quaternion.
     *
     * This method performs component-wise addition of two quaternions, adding
     * their real and imaginary parts separately.
     *
     * @param other The other quaternion to add to the current quaternion.
     * @return A new Quaternion that represents the sum of the two quaternions.
     * The result is a quaternion with the summed real and imaginary parts.
     * If the other object is not a Quaternion, an error message is printed,
     * and nullptr is returned.
     */
    ComplexNumber *add(const ComplexNumber &other) override;
    /**
     * Multiplies the current quaternion with another quaternion.
     *
     * This method performs quaternion multiplication based on the following formula:
     *
     * q1 * q2 = (w1 * w2 - x1 * x2 - y1 * y2 - z1 * z2) +
     * (w1 * x2 + x1 * w2 + y1 * z2 - z1 * y2)i +
     * (w1 * y2 - x1 * z2 + y1 * w2 + z1 * x2)j +
     * (w1 * z2 + x1 * y2 - y1 * x2 + z1 * w2)k
     *
     * @param other The other quaternion to multiply with the current quaternion.
     * @return A new Quaternion that represents the product of the two quaternions.
     * If the other object is not a Quaternion, an error message is printed,
     * and nullptr is returned.
     */
    ComplexNumber *multiply(const ComplexNumber &other) override;
    /**
    * Returns the conjugate of the current quaternion.
    *
    * The conjugate of a quaternion q = w + xi + yj + zk is defined as:
    *
    * q* = w - xi - yj - zk
    *
    * The real part remains unchanged and the signs of the imaginary components are
    flipped.
    *
    * @return A new Quaternion that represents the conjugate of the current quaternion.
    */
    ComplexNumber *conjugate() override;
    /**
     * Prints the current quaternion in the format:
     *
     * w + xi + yj + zk
     *
     * Example output for a quaternion q = 3 + 2i - 4j + 0k:
     * "3 + 2i - 4j + 0k"
     */
    friend std::ostream &operator<<(std::ostream &os, const Quaternion &other);
    // Getter methods for j and k
    int getJ() const { return j; }
    int getK() const { return k; }
};
#endif // QUATERNION_H
