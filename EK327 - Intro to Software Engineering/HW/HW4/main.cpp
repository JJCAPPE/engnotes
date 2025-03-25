#include "Quaternion.h"
#include <gtest/gtest.h>
#include <sstream>
#include <string>

// Tests for the "divides" method in GaussianInteger

// Test 1: Simple exact divisibility.
// 2 divides 4: (2, 0) should divide (4, 0)
TEST(GaussianDivisonTests, DividesMethod_ExactDivisibility) {
    GaussianInteger divisor(2, 0);
    GaussianInteger dividend(4, 0);
    EXPECT_TRUE(divisor.divides(dividend));
}

// Test 2: Not divisible case.
// 2 does not divide 1+1i since the quotient is not a Gaussian integer.
TEST(GaussianDivisonTests, DividesMethod_NotDivisible) {
    GaussianInteger divisor(2, 0);
    GaussianInteger operand(1, 1);
    EXPECT_FALSE(divisor.divides(operand));
}

// Test 3: Divisor is zero.
// A zero divisor (norm==0) should always return false.
TEST(GaussianDivisonTests, DividesMethod_ZeroDivisor) {
    GaussianInteger zeroDivisor(0, 0);
    GaussianInteger operand(3, 4);
    EXPECT_FALSE(zeroDivisor.divides(operand));
}

// Test 4: Divisibility using known multiplication relationship.
// Let a be an arbitrary Gaussian integer and q another arbitrary Gaussian integer,
// then b = a * q. In that case, a should divide b.
TEST(GaussianDivisonTests, DividesMethod_ProductRelation) {
    GaussianInteger a(3, 4);
    GaussianInteger q(2, -5);
    // Compute b = a * q (using the multiply method via base class pointer)
    ComplexNumber* productBase = a.multiply(q);
    auto b = dynamic_cast<GaussianInteger*>(productBase);
    ASSERT_NE(b, nullptr);
    EXPECT_TRUE(a.divides(*b));
    delete b;
}

// Test 5: Divisibility with negative components.
// Construct divisor a and choose b such that b = a * q for a Gaussian q (with negative parts).
TEST(GaussianDivisonTests, DividesMethod_NegativeComponents) {
    GaussianInteger a(1, -1);   // divisor
    GaussianInteger q(4, 3);    // chosen multiplier
    ComplexNumber* productBase = a.multiply(q);
    auto b = dynamic_cast<GaussianInteger*>(productBase);
    ASSERT_NE(b, nullptr);
    // Since b is constructed as a * q, a divides b.
    EXPECT_TRUE(a.divides(*b));
    // Also, check that if we modify b by adding an extra 1, divisibility is broken.
    GaussianInteger bModified(b->getReal() + 1, b->getImag());
    EXPECT_FALSE(a.divides(bModified));
    delete b;
}

TEST(GaussianIntegerTests, DefaultConstructor) {
    GaussianInteger gi;
    EXPECT_EQ(gi.getReal(), 0);
    EXPECT_EQ(gi.getImag(), 0);
} 
TEST(GaussianIntegerTests, ParameterizedConstructor) {
    GaussianInteger gi(3, -4);
    EXPECT_EQ(gi.getReal(), 3);
    EXPECT_EQ(gi.getImag(), -4);
}

TEST(GaussianIntegerTests, CopyConstructor) {
    GaussianInteger gi1(5, 6);
    GaussianInteger gi2(gi1);
    EXPECT_EQ(gi2.getReal(), gi1.getReal());
    EXPECT_EQ(gi2.getImag(), gi1.getImag());
}

TEST(GaussianIntegerTests, AddMethod) {
    GaussianInteger gi1(1, 2);
    GaussianInteger gi2(3, 4);
    ComplexNumber* resultBase = gi1.add(gi2);
    auto result = dynamic_cast<GaussianInteger*>(resultBase);
    ASSERT_NE(result, nullptr);
    EXPECT_EQ(result->getReal(), 1 + 3);
    EXPECT_EQ(result->getImag(), 2 + 4);
    delete result;
}

TEST(GaussianIntegerTests, MultiplyMethod) {
    GaussianInteger gi1(1, 2);
    GaussianInteger gi2(3, 4);
    ComplexNumber* resultBase = gi1.multiply(gi2);
    auto result = dynamic_cast<GaussianInteger*>(resultBase);
    ASSERT_NE(result, nullptr);
    // (1+2i) * (3+4i) = (1*3 - 2*4) + (1*4 + 2*3)i
    EXPECT_EQ(result->getReal(), 1 * 3 - 2 * 4);
    EXPECT_EQ(result->getImag(), 1 * 4 + 2 * 3);
    delete result;
}


TEST(GaussianIntegerTests, OperatorPlus) {
    GaussianInteger gi1(1, 2);
    GaussianInteger gi2(3, 4);
    GaussianInteger sum = gi1 + gi2;
    EXPECT_EQ(sum.getReal(), 1 + 3);
    EXPECT_EQ(sum.getImag(), 2 + 4);
}

TEST(GaussianIntegerTests, OperatorMultiply) {
    GaussianInteger gi1(1, 2);
    GaussianInteger gi2(3, 4);
    GaussianInteger product = gi1 * gi2;
    EXPECT_EQ(product.getReal(), 1 * 3 - 2 * 4);
    EXPECT_EQ(product.getImag(), 1 * 4 + 2 * 3);
}

TEST(GaussianIntegerTests, OperatorEquality) {
    GaussianInteger gi1(1, 2);
    GaussianInteger gi2(1, 2);
    GaussianInteger gi3(2, 3);
    EXPECT_TRUE(gi1 == gi2);
    EXPECT_FALSE(gi1 == gi3);
}

TEST(GaussianIntegerTests, OperatorStreamOutput) {
    GaussianInteger gi(2, -3);
    std::ostringstream oss;
    oss << gi;
    std::string output = oss.str();
    // Check for substrings indicating correct output (e.g., "2", "-3i")
    EXPECT_NE(output.find("2"), std::string::npos);
    EXPECT_NE(output.find("3i"), std::string::npos);
}


TEST(GaussianIntegerTests, ConjugateMethod) {
    GaussianInteger gi(3, 4);
    ComplexNumber* conjBase = gi.conjugate();
    auto conj = dynamic_cast<GaussianInteger*>(conjBase);
    ASSERT_NE(conj, nullptr);
    // Conjugate of a+bi is a-bi
    EXPECT_EQ(conj->getReal(), 3);
    EXPECT_EQ(conj->getImag(), -4);
    delete conj;
}

TEST(GaussianIntegerTests, NormMethod) {
    GaussianInteger gi(3, 4);
    // norm = a^2 + b^2  => 3^2 + 4^2 = 9 + 16 = 25
    EXPECT_EQ(gi.norm(), 25);
}

TEST(GaussianIntegerTests, DividesMethod) {
    // Example 1: 2 divides 4 since 4 = 2 * 2
    GaussianInteger giDivisor(2, 0);
    GaussianInteger giDividend(4, 0);
    EXPECT_TRUE(giDivisor.divides(giDividend));
    
    // Example 2: 2 does not divide (1 + i)
    GaussianInteger giOperand(1, 1);
    EXPECT_FALSE(giDivisor.divides(giOperand));
}

TEST(QuaternionTests, DefaultConstructor) {
    Quaternion q;
    EXPECT_EQ(q.getReal(), 0);
    EXPECT_EQ(q.getImag(), 0);
    EXPECT_EQ(q.getJ(), 0);
    EXPECT_EQ(q.getK(), 0);
}

TEST(QuaternionTests, ParameterizedConstructor) {
    Quaternion q(3, 4, 5, 6);
    EXPECT_EQ(q.getReal(), 3);
    EXPECT_EQ(q.getImag(), 4);
    EXPECT_EQ(q.getJ(), 5);
    EXPECT_EQ(q.getK(), 6);
}

TEST(QuaternionTests, CopyConstructor) {
    Quaternion q1(1, -2, 3, -4);
    Quaternion q2(q1);
    EXPECT_EQ(q2.getReal(), q1.getReal());
    EXPECT_EQ(q2.getImag(), q1.getImag());
    EXPECT_EQ(q2.getJ(), q1.getJ());
    EXPECT_EQ(q2.getK(), q1.getK());
}

TEST(QuaternionTests, AddMethod) {
    Quaternion q1(1, 2, 3, 4);
    Quaternion q2(5, 6, 7, 8);
    // Call add using the base class interface; result should be a new Quaternion.
    ComplexNumber* resultBase = q1.add(q2);
    Quaternion* result = dynamic_cast<Quaternion*>(resultBase);
    ASSERT_NE(result, nullptr);
    EXPECT_EQ(result->getReal(), 1 + 5);
    EXPECT_EQ(result->getImag(), 2 + 6);
    EXPECT_EQ(result->getJ(), 3 + 7);
    EXPECT_EQ(result->getK(), 4 + 8);
    delete result;
}

TEST(QuaternionTests, MultiplyMethod) {
    // Test quaternion multiplication using known formulas:
    // Let q1 = 1+2i+3j+4k, q2 = 5+6i+7j+8k.
    Quaternion q1(1, 2, 3, 4);
    Quaternion q2(5, 6, 7, 8);
    // Expected product (using the quaternion multiplication formula):
    //  real: 1*5 - 2*6 - 3*7 - 4*8
    //  i:    1*6 + 2*5 + 3*8 - 4*7
    //  j:    1*7 - 2*8 + 3*5 + 4*6
    //  k:    1*8 + 2*7 - 3*6 + 4*5
    int expectedReal = 1*5 - 2*6 - 3*7 - 4*8;
    int expectedImag = 1*6 + 2*5 + 3*8 - 4*7;
    int expectedJ    = 1*7 - 2*8 + 3*5 + 4*6;
    int expectedK    = 1*8 + 2*7 - 3*6 + 4*5;
    
    ComplexNumber* prodBase = q1.multiply(q2);
    Quaternion* prod = dynamic_cast<Quaternion*>(prodBase);
    ASSERT_NE(prod, nullptr);
    EXPECT_EQ(prod->getReal(), expectedReal);
    EXPECT_EQ(prod->getImag(), expectedImag);
    EXPECT_EQ(prod->getJ(), expectedJ);
    EXPECT_EQ(prod->getK(), expectedK);
    delete prod;
}

TEST(QuaternionTests, ConjugateMethod) {
    Quaternion q(3, -4, 5, -6);
    // The conjugate should flip the signs of the imaginary components (i, j, k) only.
    ComplexNumber* conjBase = q.conjugate();
    Quaternion* conj = dynamic_cast<Quaternion*>(conjBase);
    ASSERT_NE(conj, nullptr);
    EXPECT_EQ(conj->getReal(), 3);        // Real part remains unchanged.
    EXPECT_EQ(conj->getImag(), 4);        // Imaginary i part flips sign.
    EXPECT_EQ(conj->getJ(), -5);          // j part flips sign.
    EXPECT_EQ(conj->getK(), 6);           // k part flips sign.
    delete conj;
}

TEST(QuaternionTests, OperatorStreamOutput) {
    Quaternion q(1, -2, 3, -4);
    std::ostringstream oss;
    oss << q;
    std::string output = oss.str();
    // Depending on your implementation, output may be "1 - 2i + 3j - 4k" or similar.
    // We'll check for the presence of key substrings.
    EXPECT_NE(output.find("1"), std::string::npos);
    EXPECT_NE(output.find("2i"), std::string::npos);
    EXPECT_NE(output.find("3j"), std::string::npos);
    EXPECT_NE(output.find("4k"), std::string::npos);
}

TEST(QuaternionTests, EqualityOperator) {
    Quaternion q1(1, 2, 3, 4);
    Quaternion q2(1, 2, 3, 4);
    Quaternion q3(1, -2, 3, 4);
    EXPECT_TRUE(q1 == q2);
    EXPECT_FALSE(q1 == q3);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}