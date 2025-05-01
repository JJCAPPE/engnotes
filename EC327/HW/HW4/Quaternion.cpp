#include "Quaternion.h"

Quaternion::Quaternion() : GaussianInteger(0, 0), j(0), k(0) {}
Quaternion::Quaternion(const int real, const int imag, const int j, const int k) : GaussianInteger(real, imag), j(j), k(k) {}
Quaternion::Quaternion(const Quaternion &other) : GaussianInteger(other.getReal(), other.getImag()), j(other.j), k(other.k) {}

ComplexNumber *Quaternion::add(const ComplexNumber &other)
{
    const Quaternion *castedQuat = dynamic_cast<const Quaternion*>(&other);
    if (!castedQuat){
        std::cout << "Error: Cannot add a Quaternion to a non-Quaternion" << std::endl;
        return nullptr;
    }
    return new Quaternion(
        (castedQuat->getReal() + this->getReal()),
        (castedQuat->getImag() + this->getImag()),
        (castedQuat->getJ() + this->getJ()),
        (castedQuat->getK() + this->getK())
    );
}

ComplexNumber *Quaternion::multiply(const ComplexNumber &other)
{
    const Quaternion *castQuat = dynamic_cast<const Quaternion *>(&other);
    if (!castQuat){
        std::cout << "Error: Cannot add a Quaternion to a non-Quaternion" << std::endl;
        return nullptr;
    }
    int w1 = this->getReal();
    int w2 = castQuat->getReal();
    int x1 = this->getImag();
    int x2 = castQuat->getImag();
    int y1 = this->getJ();
    int y2 = castQuat->getJ(); 
    int z1 = this->getK();
    int z2 = castQuat->getK();
    return new Quaternion(
        w1 * w2 - x1 * x2 - y1 * y2 - z1 * z2,
        w1 * x2 + x1 * w2 + y1 * z2 - z1 * y2,
        w1 * y2 - x1 * z2 + y1 * w2 + z1 * x2,
        w1 * z2 + x1 * y2 - y1 * x2 + z1 * w2 
    );
}

ComplexNumber *Quaternion::conjugate()
{
    return new Quaternion(
        this->getReal(),
        (-1) * this->getImag(),
        (-1) * this->getJ(),
        (-1) * this->getK()
    );
}

std::ostream &operator<<(std::ostream &os, const Quaternion &other)
{
    os << other.getReal() << (other.getImag() >= 0 ? " + " : " - ") << std::abs(other.getImag()) << "i" << (other.getJ() >= 0 ? " + " : " - ") << std::abs(other.getJ()) << "j" << (other.getK() >= 0 ? " + " : " - ") << std::abs(other.getK()) << "k";
    return os;
}
