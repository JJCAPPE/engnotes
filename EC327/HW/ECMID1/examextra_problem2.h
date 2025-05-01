#ifndef EXAMEXTRA_PROBLEM2_H
#define EXAMEXTRA_PROBLEM2_H
/**
 * Struct representing a node in the linked list.
 */
struct Node
{
    int data;   // The value stored in the node
    Node *next; // Pointer to the next node
};
/**
 * Inserts a value into the linked list at a given position.
 * If the position
 * is invalid, either zero or smaller, or out of bounds for the size of the
 * current linked list, the linked list should remain unchanged.
 * @param head Pointer to the head of the linked list.
 * @param value The integer value to insert.
 * @param position The position to insert the value at (1-based index).
 * @return the head of the resulting linked list.
 */
Node *insertAtPosition(Node *head, int value, int position);
/**
 * Removes the node at a given position from the linked list.
 * If the position
 * is invalid, either zero or smaller, or out of bounds for the size of the
 * current linked list, the linked list should remain unchanged.
 * @param head Pointer to the head of the linked list.
 * @param position The position to remove the node at (1-based index).
 * @return the head of the resulting linked list.
 */
Node *deleteAtPosition(Node *head, int position);
/**
* Finds the greatest product of two values in the linked list.
* @param head Pointer to the head of the linked list.
* @return the greatest product, or 0 if the list has fewer than two
elements.
*/
int findGreatestProduct(Node *head);
#endif // EXAMEXTRA_PROBLEM2_H
