#ifndef HW3_PROBLEM3_H
#define HW3_PROBLEM3_H
#include <stddef.h>
#include <stdio.h>
/**
* A node in a linked-list storing integer values.
*/
struct Node {
int value;
struct Node* next;
};
/**
* Helper function for debugging current state of a linked-list
* pointed to by head.
*/
static void printList(struct Node* head) {
printf("Printing List:\n");
while (head != NULL) {
printf("%d -> ", head->value);
head = head->next;
}
printf("\n");
}
/**
* Inserts newValue into the appropriate location in the linked list
* pointed to by head.
*
* The assumption is that the input linked list is sorted in ascending
* order and the behavior of this function is undefined in the case
* that it is not.
*
* This function should behave as expected even if head is pointing to
* NULL - it should return a pointer to a linked list of one node
* with value of newValue.
*
* @param pointer to the head of a linked-list that is sorted in
* ascending order
* @param newValue the new integer value to be inserted into the
* sorted linked list
*
* @return pointer to the head of the resulting linked-list. This very
* well may point to the same memory location that head is pointing to.
*/
Node* insertInOrder(Node* head, int newValue);
#endif //HW3_PROBLEM3_H