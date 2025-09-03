#include <vector>
#include <algorithm>

template <typename T>
class Queue {
    private:
        std::vector<T> queue;
    public:
        void dequeue();
        void enqueue(const T* element);
        T next();
        bool isEmpty() const;
        bool contains(const T *element) const;
};

template <typename T>
inline bool Queue<T>::contains(const T *element) const
{
    auto it = std::find(queue.begin(), queue.end(), *element);
    return (it != queue.end());
}

template <typename T>
inline void Queue<T>::dequeue()
{
    queue.pop_back();
}

template <typename T>
inline void Queue<T>::enqueue(const T *element)
{
    queue.insert(queue.begin(), *element);
}

template <typename T>
inline T Queue<T>::next()
{
    return queue.back();
}

template <typename T>
inline bool Queue<T>::isEmpty() const
{
    return queue.empty();
}
