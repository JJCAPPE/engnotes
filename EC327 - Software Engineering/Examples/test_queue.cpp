#include <iostream>
#include "queue.h"

int main()
{
    Queue<int> q;

    // Print initial state.
    std::cout << "Queue is empty? " << (q.isEmpty() ? "Yes" : "No") << std::endl;

    int a = 10, b = 20, c = 30;

    // Enqueue elements.
    q.enqueue(&a);
    q.enqueue(&b);
    q.enqueue(&c);

    std::cout << "Queue is empty after enqueuing? " << (q.isEmpty() ? "Yes" : "No") << std::endl;

    // Check next element.
    int front = q.next();
    std::cout << "Next element (front of queue): " << front << std::endl;

    // Test contains().
    std::cout << "Queue contains 20? " << (q.contains(&b) ? "Yes" : "No") << std::endl;

    // Dequeue one element and then test next().
    q.dequeue();
    int newFront = q.next();
    std::cout << "Next element after one dequeue: " << newFront << std::endl;

    return 0;
}
