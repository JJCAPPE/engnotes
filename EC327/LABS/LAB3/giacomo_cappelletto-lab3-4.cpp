#include <map>
int fibonacci(int n)
{
    static std::map<int, int> cache;
    if (cache.empty()) {
        cache[0] = 0;
        cache[1] = 1;
    }
    auto it = cache.find(n);
    if (it != cache.end()) {
        return it->second;
    }
    int result = fibonacci(n - 1) + fibonacci(n - 2);
    cache[n] = result;
    return result;
}