#ifndef LAB5_PROBLEM2_H
#define LAB5_PROBLEM2_H
#include <set>
#include <vector>
#include <algorithm>  // for std::find
#include <stdexcept>
using namespace std;
/**
 * Copy all your code from lab5_problem1.h to here.
 *
 * Implement a twoHopNeighbors(int ID) member function in your existing
 * Graph class that returns a set of all vertices that can be
 * reached by exactly two hops from the given nodevID. Specifically, you
 * will copy all of your code from lab5_problem1.h into lab5_problem2.h
 * and add this new function. Two-hop neighbors are defined as the
 * neighbors of the neighbors of ID, *excluding ID itself*. and they
 * must be stored in an std::set (ensuring the final output is sorted).
 * If ID does not exist or has no two-hop neighbors, return an empty set.
 *
 * @example
 * Graph G;
 * G+=3;
 * G+=4;
 * G+=5;
 * G+=6;
 * G+=7;
 * G+=8;
 * G.addEdge(3,4);
 * G.addEdge(4,5);
 * G.addEdge(3,6);
 * G.addEdge(6,7);
 * G.addEdge(3,8);
 *
 * G.twoHopNeighbors(3); // returns {5, 7}
 * G.twoHopNeighbors(4); // returns {6, 8}
 * G.twoHopNeighbors(5); // returns {3}
 * G.twoHopNeighbors(6); // returns {4, 8}
 * G.twoHopNeighbors(7); // returns {3}
 *
 * @example
 * Graph G;
 * G+=3;
 * G+=4;
 * G+=9;
 * G+=6;
 * G.addEdge(3,4);
 * G.addEdge(4,9);
 * G.addEdge(3,9);
 * G.addEdge(9,6);
 * G.addEdge(3,6);
 *
 * G.twoHopNeighbors(3); // returns {4, 6, 9}
 * G.twoHopNeighbors(4); // returns {3, 6, 9}
 * G.twoHopNeighbors(9); // returns {3, 4, 6}
 * G.twoHopNeighbors(6); // returns {3, 4, 9}
 */
class Graph
{
private:
   std::vector<int> vertices;
   std::vector<std::set<int>> edges;
   set<int> oneHopNeighbors(int ID);
public:
    Graph();
    Graph &operator+=(int ID);
    bool hasEdge(int ID1, int ID2);
    void addEdge(int ID1, int ID2);
    int numVertices();
    int numEdges();
    set<int> twoHopNeighbors(int ID);
    /**
     * Create your public variables and functions that you think will be
     * useful(shouldn’t need any public functions, all helper functions and
     * variables should be private)
     */
};
#endif // LAB5_PROBLEM2_H