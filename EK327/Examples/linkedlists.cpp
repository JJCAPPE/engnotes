#include <iostream>

// Define a Node structure
struct Node {
    int data;
    Node* next;
    Node(int val) : data(val), next(nullptr) {}
};

// Function to append a new node at the end
void append(Node*& head, int newData) {
    Node* newNode = new Node(newData);
    if (!head) {
        head = newNode;
        return;
    }
    Node* last = head;
    while (last->next) {
        last = last->next;
    }
    last->next = newNode;
}

// Function to print the linked list
void printList(Node* node) {
    while (node) {
        std::cout << node->data << " ";
        node = node->next;
    }
    std::cout << std::endl;
}

int main() {
    Node* head = nullptr;
    append(head, 1);
    append(head, 2);
    append(head, 3);
    append(head, 4);
    printList(head);  // Output: 1 2 3 4

    return 0;
}

