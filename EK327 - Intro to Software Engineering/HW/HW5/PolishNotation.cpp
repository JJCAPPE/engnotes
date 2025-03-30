#include "PolishNotation.h"
#include <vector>
#include <string>
template <typename InputType>
int RPNCalculator<InputType>::evaluate(const InputType &expression)
{
    while(!stack.empty()){
        stack.pop();
    }
    std::vector<std::string> tokens;
    if constexpr (std::is_same_v<InputType, std::string>)
    {
        tokens = tokenize(expression);
    }
    else
    {
        tokens = expression;
    }
    if (tokens.empty()) {
        throw std::invalid_argument("Empty expression");
    }
    std::unordered_map<std::string, std::function<int(int, int)>> operations = {
        {"+", std::plus<int>()},
        {"-", std::minus<int>()},
        {"*", std::multiplies<int>()},
        {"/", [](int a, int b) {
            if (b == 0) throw std::invalid_argument("Division by zero");
            return a / b;
        }}
    };

    for (const auto &token : tokens)
    {
        if (isdigit(token[0]) || (token.size() > 1 && isdigit(token[1]))) {
            stack.push(std::stoi(token));
        }
        else {
            if (stack.size() < 2) {
                throw std::invalid_argument("Not enough operands");
            }
            int b = stack.top();
            stack.pop();
            int a = stack.top();
            stack.pop();

            auto op = operations.find(token);
            if (op != operations.end()) {
                stack.push(op->second(a, b));
            } else {
                throw std::invalid_argument("Invalid operator: " + token);
            }
        }
    }
    if (stack.size() != 1) {
        throw std::invalid_argument("Invalid expression: too many operands");
    }
    int result = stack.top();
    stack.pop();
    return result;
}
template <typename InputType>
std::vector<std::string> RPNCalculator<InputType>::tokenize(const std::string &expr)
{
    std::vector<std::string> tokens;
    std::string token;
    for (char ch : expr)
    {
        if (ch == ' ')
        {
            if (!token.empty())
            {
                tokens.push_back(token);
                token.clear();
            }
        }
        else
        {
            token += ch;
        }
    }
    if (!token.empty())
    {
        tokens.push_back(token);
    }
    return tokens;
}
// Explicit template instantiations
template class RPNCalculator<std::string>;
template class RPNCalculator<std::vector<std::string>>;