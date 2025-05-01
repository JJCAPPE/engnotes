#include "ComplexNumber.h"

class GaussianInteger : public ComplexNumber
{
public:
    GaussianInteger();
    GaussianInteger(const int real, const int imag);
    GaussianInteger(const GaussianInteger &other);

    ComplexNumber *add(const ComplexNumber &other) override;
    ComplexNumber *multiply(const ComplexNumber &other) override;
    ComplexNumber *conjugate() override;
    /**
     * @return the norm of this object. If this object is a + bi, then the norm is a^2 + b^2.
     * @example
     * GaussianInteger onePlusI(1, 1);
     * onePlusI.norm() == 2, corresponding to the norm of 1 + i
     */
    int norm();
    /**
     * @param other The GaussianInteger by which to divide this object
     * @return true if and only if this object divides by [other]
     * (or, in other words, other is a factor of this object)
     * @example 1
     * GaussianInteger four(4, 0);
     * GaussianInteger two(2, 0);
     * four.divides(two) is true, because 2*2=4
     *
     * @example 2
     * GaussianInteger two(2, 0); // i.e., 2 + 0i
     * GaussianInteger onePlusI(1, 1); // i.e., 1 + i
     * two.divides(onePlusI) is true because (1 + i) * (1 - i) == 2
     *
     * @example 3
     * GaussianInteger two(2, 0); // i.e., 2 + 0i
     * GaussianInteger twoPlusI(2, 1); // i.e., 2 + i
     * two.divides(twoPlusI) is false because 2 does not divide 2 + i
     */
    bool divides(const GaussianInteger &other);

    /**
     * @param other The GaussianInteger to add to this object
     * @return this object added to [other].
     * Does not modify this object.
     *
     * @example
     * GaussianInteger one(1, 0);
     * GaussianInteger i(0, 1);
     * (one + i) produces the Gaussian Integer 1 + i
     */
    GaussianInteger operator+(const GaussianInteger &other) const;
    /**
     * @param other The GaussianInteger to multiply to this object
     * @return this object multiplied by [other]
     * Does not modify this object.
     *
     * @example
     * GaussianInteger one(1, 0);
     * GaussianInteger i(0, 1);
     * (one * i) produces the Gaussian Integer i (1 * i)
     */
    GaussianInteger operator*(const GaussianInteger &other) const;
    /**
     *
     * @param other The Gaussian integer to which this should be compared
     * @return true if and only if this object is equal to [other]
     * Does not modify this object.
     * @example
     * GaussianInteger one(1, 0);
     * GaussianInteger i(0, 1);
     * one == one is true, but one == i is false
     */
    bool operator==(const GaussianInteger &other) const;
    /**
     * @param os A reference to the ostream object
     * @param other The GaussianInteger being printed
     * @return The reference to the ostream object to allow for cout chaining
     * friend function
     *
     * @example
     * GaussianInteger two(2, 0);
     * std::cout << two << std::endl;
     * produces 2 + 0i
     */
    friend std::ostream &operator<<(std::ostream &os, const GaussianInteger &other);
};