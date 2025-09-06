#include "examextra_problem2.h"
#include <cstdlib>
#include <iostream>

Node *insertAtPosition(Node *head, int value, int position)
{
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->data = value;
    newNode->next = NULL;

    if (position < 1)
    {
        free(newNode);
        return head;
    }
    if (position == 1)
    {
        newNode->next = head;
        return newNode;
    }
    Node *current = head;
    for (int i = 1; i < position - 1; i++)
    {
        if (current == NULL)
        {
            free(newNode);
            return head;
        }
        current = current->next;
    }
    if (current == NULL) 
    {
        free(newNode);
        return head;
    }
    newNode->next = current->next;
    current->next = newNode;
    return head;
}

Node *deleteAtPosition(Node *head, int position)
{
    if (position < 1)
    {
        return head;
    }
    if (position == 1)
    {
        if (head == NULL)
            return head;
        Node *tmp = head;
        head = head->next;
        free(tmp);
        return head;
    }
    Node *current = head;
    for (int i = 1; i < position - 1; i++)
    {
        if (current == NULL)
            return head;
        current = current->next;
    }
    if (current == NULL || current->next == NULL)
    {
        return head;
    }
    Node *tmp = current->next;
    current->next = tmp->next;
    free(tmp);
    return head;
}

int findGreatestProduct(Node *head)
{
    int currentProduct;
    int numBig;
    int numSmall;
    if (head == NULL || head->next == NULL)
    {
        return 0;
    }
    if (head->data > head->next->data)
    {
        numBig = head->data;
        numSmall = head->next->data;
    }
    else
    {
        numSmall = head->data;
        numBig = head->next->data;
    }
    currentProduct = numBig * numSmall;
    head = head->next;
    while (head->next != NULL)
    {
        int candidate = head->next->data;
        if (candidate > numSmall && candidate <= numBig)
        {
            numSmall = candidate;
            currentProduct = numBig * numSmall;
        }
        else if (candidate > numBig)
        {
            numSmall = numBig;
            numBig = candidate;
            currentProduct = numBig * numSmall;
        }
        head = head->next;
    }
    return currentProduct;
}
