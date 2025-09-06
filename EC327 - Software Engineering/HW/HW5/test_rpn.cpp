#include "PolishNotation.h"
#include <gtest/gtest.h>

class RPNTest : public ::testing::Test
{
protected:
    RPNCalculator<std::string> calc;
};

// Basic operations
TEST_F(RPNTest, BasicOperations)
{
    EXPECT_EQ(calc.evaluate("3 4 +"), 7);
    EXPECT_EQ(calc.evaluate("3 4 -"), -1);
    EXPECT_EQ(calc.evaluate("3 4 *"), 12);
    EXPECT_EQ(calc.evaluate("12 3 /"), 4);
}

// Complex expressions
TEST_F(RPNTest, ComplexExpressions)
{
    EXPECT_EQ(calc.evaluate("3 4 + 5 *"), 35);
    EXPECT_EQ(calc.evaluate("15 7 1 1 + - / 3 * 2 1 1 + + -"), 5);
}

// Error cases
TEST_F(RPNTest, ErrorCases)
{
    EXPECT_THROW(calc.evaluate("3 0 /"), std::invalid_argument);   // Division by zero
    EXPECT_THROW(calc.evaluate("3 +"), std::invalid_argument);     // Not enough operands
    EXPECT_THROW(calc.evaluate("3 4 5 +"), std::invalid_argument); // Too many operands
    EXPECT_THROW(calc.evaluate("3 4 &"), std::invalid_argument);   // Invalid operator
    EXPECT_THROW(calc.evaluate(""), std::invalid_argument);        // Empty expression
}

// Negative numbers
TEST_F(RPNTest, NegativeNumbers)
{
    EXPECT_EQ(calc.evaluate("-3 4 +"), 1);
    EXPECT_EQ(calc.evaluate("3 -4 +"), -1);
    EXPECT_EQ(calc.evaluate("-3 -4 *"), 12);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}