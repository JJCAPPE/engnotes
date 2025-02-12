#include "lab3_problem3.h"

struct Node *findMiddle(struct Node *head)
{
    if (head == NULL)
    {
        return NULL;
    }
    struct Node *slowPass = head;
    struct Node *fastPass = head->next;
    while (fastPass != NULL && fastPass->next != NULL)
    {
        slowPass = slowPass->next;
        fastPass = fastPass->next->next;
    }
    return slowPass;
}