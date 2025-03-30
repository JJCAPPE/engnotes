#ifndef LAB5_PROBLEM1_H
#define LAB5_PROBLEM1_H
#include <map>
#include <set>
#include <vector>
#include <stdexcept>
#include <iostream>
#include <algorithm>
using namespace std;
/**
 * A graph is a collection of vertices, together with edges connecting
 * some of the vertices.
 *
 * Implement an undirected Graph class with the following properties:
 * - There is only one public default constructor that produces an
 * empty graph with no vertices (or edges).
 * - operator+= is used to add a vertex with a given ID to the graph.
 * if a vertex already has the given ID, a logic_error exception
 * should be thrown.
 * - hasEdge(int ID1, int ID2) returns true iff an edge between vertices
 * with ids ID1 and ID2 exists.
 * - addEdge(int ID1, int ID2) adds an edge between vertices with
 * ids ID1 and ID2, respectively.
 * if one of the IDs does not exist, or the edge already exists,
 * an invalid_argument exception should be thrown.
 * - numVertices() returns the number of vertices in the graph
 * - numEdges() returns the number of edges in the graph
 *
 * @example
 * Graph G;
 * G+=3;
 * G+=5;
 * G+=3; // throws logic_error
 * G.hasEdge(3,5); // returns false
 * G.addEdge(5,3); // adds an edge connecting vertex 5 and 3.
 * G.hasEdge(3,5); // returns true (edge between 5 to 3 == between 3 and 5).
 * G.numVertices(); // returns 2 - vertex ID 3 and ID 5
 * G.numEdges(); // returns 1 - between vertex ID 3 and ID 5
 */
class Graph
{
private:
   std::vector<int> vertices;
   std::vector<std::set<int>> edges;
public:
    Graph();
    Graph &operator+=(int ID);
    bool hasEdge(int ID1, int ID2);
    void addEdge(int ID1, int ID2);
    int numVertices();
    int numEdges();
    /**
     * Create your public variables and functions that you think will be
     * useful(shouldn’t need any public functions, all helper functions and
     * variables should be private)
     */
};
#endif // LAB5_PROBLEM1_