#ifndef COMPLEXNUMBER_H
#define COMPLEXNUMBER_H
#include <iostream>
#include <cstdlib>

/**
 * @class Abstract ComplexNumber 
 * @brief Represents a complex number with integer components for the real and imaginary parts.
 */
class ComplexNumber
{
protected:
    int real;
    int imag;

public:
    /**
     * @brief Constructs a ComplexNumber with the given real and imaginary parts.
     * @param r The integer real part.
     * @param i The integer imaginary part.
     */
    ComplexNumber(int r, int i) : real(r), imag(i) {}

    /**
     * @brief Returns the integer real part of this complex number.
     * @return The real part as an integer.
     */
    int getReal() const { return real; }

    /**
     * @brief Returns the integer imaginary part of this complex number.
     * @return The imaginary part as an integer.
     */
    int getImag() const { return imag; }

    /**
     * @brief Adds the given complex number to this complex number.
     *
     * Creates and returns a new ComplexNumber that is the sum of this complex number and the provided one.
     *
     * @param other The complex number to add.
     * @return Pointer to a new ComplexNumber representing the sum. Caller is responsible for managing the memory.
     */
    virtual ComplexNumber *add(const ComplexNumber &other) = 0;

    /**
     * @brief Multiplies this complex number with the given complex number.
     *
     * Creates and returns a new ComplexNumber that is the product of this complex number and the provided one.
     *
     * @param other The complex number to multiply with.
     * @return Pointer to a new ComplexNumber representing the product. Caller is responsible for managing the memory.
     */
    virtual ComplexNumber *multiply(const ComplexNumber &other) = 0;

    /**
     * @brief Computes the conjugate of this complex number.
     *
     * Creates and returns a new ComplexNumber that is the conjugate of this one
     * (the imaginary part is multiplied by -1).
     *
     * @return Pointer to a new ComplexNumber representing the conjugate. Caller is responsible for managing the memory.
     */
    virtual ComplexNumber *conjugate() = 0;

    /**
     * @brief Prints this complex number to the standard output.
     *
     * The complex number is printed in the format "a + bi" or "a - bi".
     */
    void print()
    {
        std::cout << real << (imag >= 0 ? " + " : " - ") << std::abs(imag) << "i" << std::endl;
    }
};
#endif