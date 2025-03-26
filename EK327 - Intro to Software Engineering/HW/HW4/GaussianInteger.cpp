#include "GaussianInteger.h"

GaussianInteger::GaussianInteger() : ComplexNumber(0, 0){}
GaussianInteger::GaussianInteger(const int real, const int imag) : ComplexNumber(real, imag) {}
GaussianInteger::GaussianInteger(const GaussianInteger &other) : ComplexNumber(other.getReal(), other.getImag()) {}

ComplexNumber* GaussianInteger::add(const ComplexNumber &other) {
    return new GaussianInteger(
        (other.getReal() + this->getReal()), 
        (other.getImag() + this->getImag())
    );
}
ComplexNumber* GaussianInteger::multiply(const ComplexNumber &other) {
    int a = other.getReal();
    int b = other.getImag();
    int c = this->getReal();
    int d = this->getImag();
    return new GaussianInteger(
        a * c - b * d, a * d + b * c
    );
}
ComplexNumber* GaussianInteger::conjugate() {
    return new GaussianInteger(
        this->getReal(), 
        (-1)*this->getImag()
    );
}
int GaussianInteger::norm(){
    return (this->getReal() * this->getReal()) + (this->getImag() * this->getImag());
}

/**
 * TEST(DivisionTest, WildcardDivisionTest) {
    GaussianInteger* dividend = new GaussianInteger(-12, 72);
    GaussianInteger* divisor = new GaussianInteger(6, 1);
    bool result = dividend->divides(*divisor);

    EXPECT_TRUE(result);
}
 */
bool GaussianInteger::divides(const GaussianInteger &other) {
    GaussianInteger nonConstOther(other);
    int normThis = this->norm();
    if (normThis == 0) {
        return false; 
    }
    
    std::unique_ptr<ComplexNumber> conjThis(this->conjugate());
    
    std::unique_ptr<ComplexNumber> numerator(nonConstOther.multiply(*conjThis));
    
    int numReal = numerator->getReal();
    int numImag = numerator->getImag();
    
    return (numReal % normThis == 0 && numImag % normThis == 0);
}

GaussianInteger GaussianInteger::operator+(const GaussianInteger &other) const
{
    return GaussianInteger(
        this->getReal() + other.getReal(),
        this->getImag() + other.getImag()
    );
}

GaussianInteger GaussianInteger::operator*(const GaussianInteger &other) const
{
    return GaussianInteger(
        this->getReal() * other.getReal() - this->getImag() * other.getImag(),
        this->getReal() * other.getImag() + this->getImag() * other.getReal()
    );
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