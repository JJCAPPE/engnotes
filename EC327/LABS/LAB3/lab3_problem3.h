#ifndef HW3_PROBLEM3_H
#define HW3_PROBLEM3_H
#include <stddef.h>
#include <stdio.h>
/**
 * A node in a linked-list storing integer values.
 */
struct Node
{
    int value;
    struct Node *next;
};
/**
 * Helper function for debugging the current state of a linked-list
 * pointed to by head.
 */
static void printList(struct Node *head)
{
    printf("Printing List:\n");
    while (head != NULL)
    {
        printf("%d -> ", head->value);
        head = head->next;
    }
    printf("NULL\n");
}
/**
 * Finds the middle node of a linked list.
 *
 * For a linked list with an odd number of nodes, this function returns the
 * single middle node. For a list with an even number of nodes, it returns
 * the node at the start of the second half (i.e. the (n/2 + 1)th node).
 *
 * If the list is empty (i.e. head is NULL), the function returns NULL.
 *
 * @param head A pointer to the head of the linked list.
 *
 * @return A pointer to the middle node of the list, or NULL if the list is empty.
 */
struct Node *findMiddle(struct Node *head);
#endif // HW3_PROBLEM3_MIDDLE_H