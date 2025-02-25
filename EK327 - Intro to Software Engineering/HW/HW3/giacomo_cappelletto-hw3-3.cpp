#include <stdio.h>
#include <stdlib.h>
#include "hw3_problem3.h"

Node *insertInOrder(Node *head, int newValue)
{
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->value = newValue;
    newNode->next = NULL;
    if (head == NULL || head->value > newValue)
    {
        newNode->next = head;
        return newNode;
    }
    Node *current = head;
    while (current->next != NULL && current->next->value < newValue)
    {
        current = current->next;
    }
    newNode->next = current->next;
    current->next = newNode;
    return head;
}
