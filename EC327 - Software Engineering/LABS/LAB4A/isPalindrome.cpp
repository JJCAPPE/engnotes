#include <gtest/gtest.h>
#include <string>
#include <iostream>

bool isPalindrome(std::string str){
    int n = str.length();
    for (int i = 0; i < n/2; i++){
        if (str[i] != str[n-i-1]){
            return false;
        }
    }
    return true;
}

TEST(PalindromeTest, EmptyString) {
    EXPECT_EQ(isPalindrome(""), true);
}

TEST(PalindromeTest, SingleCharacter) {
    EXPECT_EQ(isPalindrome("a"), true);
}

TEST(PalindromeTest, EvenFalse) {
    EXPECT_EQ(isPalindrome("as"), false);
}

TEST(PalindromeTest, EvenTrue) {
    EXPECT_EQ(isPalindrome("haah"), true);
}

TEST(PalindromeTest, OddFalse) {
    EXPECT_EQ(isPalindrome("asd"), false);
}

TEST(PalindromeTest, OddTrue) {
    EXPECT_EQ(isPalindrome("asdsa"), true);
}

int main(int argc, char* argv[]) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}