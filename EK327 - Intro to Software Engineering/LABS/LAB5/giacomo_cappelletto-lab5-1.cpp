#include "lab5_problem1.h"

Graph::Graph() : vertices(), edges() {}

Graph &Graph::operator+=(int ID) {
    if (find(vertices.begin(), vertices.end(), ID) != vertices.end()) {
        throw std::logic_error("Vertex already exists");
    }
    vertices.push_back(ID);
    return *this;
}

bool Graph::hasEdge(int ID1, int ID2)
{
    for ( auto edge : edges ) {
        if (edge.find(ID1) != edge.end() && edge.find(ID2) != edge.end()) {
            return true;
        }
    }
    return false;
}

void Graph::addEdge(int ID1, int ID2)
{
    if (find(vertices.begin(), vertices.end(), ID1) == vertices.end() 
    || find(vertices.begin(), vertices.end(), ID2) == vertices.end() 
    || hasEdge( ID1 , ID2 )) {
        throw std::invalid_argument("One or more verticies do not exist in this Graph");
    }
    std::set<int> newEdge{ID1, ID2};
    edges.push_back(newEdge);
}

int Graph::numVertices()
{
    return vertices.size();
}

int Graph::numEdges(){
    return edges.size();
}
