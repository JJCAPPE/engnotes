#include "GaussianInteger.h"
#include <stdio.h>

GaussianInteger::GaussianInteger() : ComplexNumber(0, 0) {}
GaussianInteger::GaussianInteger(const int real, const int imag) : ComplexNumber(real, imag) {}
GaussianInteger::GaussianInteger(const GaussianInteger &other) : ComplexNumber(other.getReal(), other.getImag()) {}

ComplexNumber *GaussianInteger::add(const ComplexNumber &other)
{
    return new GaussianInteger(
        (other.getReal() + this->getReal()),
        (other.getImag() + this->getImag()));
}
ComplexNumber *GaussianInteger::multiply(const ComplexNumber &other)
{
    int a = other.getReal();
    int b = other.getImag();
    int c = this->getReal();
    int d = this->getImag();
    return new GaussianInteger(
        a * c - b * d, a * d + b * c);
}
ComplexNumber *GaussianInteger::conjugate()
{
    return new GaussianInteger(
        this->getReal(),
        (-1) * this->getImag());
}
int GaussianInteger::norm()
{
    return (this->getReal() * this->getReal()) + (this->getImag() * this->getImag());
}

bool GaussianInteger::divides(const GaussianInteger &other)
{
    // 'other' is the divisor: a + bi.
    int a = other.getReal();
    int b = other.getImag();
    int normDivisor = a * a + b * b;
    if (normDivisor == 0)
    {
        return false; // division by zero not allowed.
    }

    // 'this' is the dividend: c + di.
    int c = this->getReal();
    int d = this->getImag();

    // Compute (a*c + b*d) / (a^2+b^2) and (a*d - b*c) / (a^2+b^2)
    bool realQuotientInteger = ((a * c + b * d) % normDivisor == 0);
    bool imagQuotientInteger = ((a * d - b * c) % normDivisor == 0);

    return realQuotientInteger && imagQuotientInteger;
}

GaussianInteger GaussianInteger::operator+(const GaussianInteger &other) const
{
    return GaussianInteger(
        this->getReal() + other.getReal(),
        this->getImag() + other.getImag());
}

GaussianInteger GaussianInteger::operator*(const GaussianInteger &other) const
{
    return GaussianInteger(
        this->getReal() * other.getReal() - this->getImag() * other.getImag(),
        this->getReal() * other.getImag() + this->getImag() * other.getReal());
}

bool GaussianInteger::operator==(const GaussianInteger &other) const
{
    return this->getReal() == other.getReal() && this->getImag() == other.getImag();
}

std::ostream &operator<<(std::ostream &os, const GaussianInteger &other)
{
    os << other.getReal() << (other.getImag() >= 0 ? " + " : " - ") << std::abs(other.getImag()) << "i";
    return os;
}

/* int main()
{
    GaussianInteger *dividend = new GaussianInteger(-12, 72);
    GaussianInteger *divisor = new GaussianInteger(6, 1);
    bool result = dividend->divides(*divisor);
    printf("%s\n", (result == true) ? "true" : "false"); // should be true
    return 0;
} */