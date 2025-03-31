#include "lab5_problem2.h"
#include <gtest/gtest.h>

class GraphTest : public ::testing::Test
{
protected:
    Graph G;
    void SetUp() override
    {
        // Add vertices 3 through 8 for most tests
        G += 3;
        G += 4;
        G += 5;
        G += 6;
        G += 7;
        G += 8;
    }
};

// Test vertex addition and counting
TEST_F(GraphTest, VertexOperations)
{
    EXPECT_EQ(G.numVertices(), 6);
    EXPECT_THROW(G += 3, std::logic_error); // Duplicate vertex
    G += 9;
    EXPECT_EQ(G.numVertices(), 7);
}

// Test edge operations
TEST_F(GraphTest, EdgeOperations)
{
    EXPECT_FALSE(G.hasEdge(3, 4));
    G.addEdge(3, 4);
    EXPECT_TRUE(G.hasEdge(3, 4));
    EXPECT_TRUE(G.hasEdge(4, 3)); // Undirected graph
    EXPECT_EQ(G.numEdges(), 1);

    // Test invalid edge additions
    EXPECT_THROW(G.addEdge(3, 9), std::invalid_argument); // Non-existent vertex
    EXPECT_THROW(G.addEdge(3, 4), std::invalid_argument); // Duplicate edge
}

// Test two-hop neighbors - first example from header
TEST_F(GraphTest, TwoHopNeighbors_Example1)
{
    G.addEdge(3, 4);
    G.addEdge(4, 5);
    G.addEdge(3, 6);
    G.addEdge(6, 7);
    G.addEdge(3, 8);

    std::set<int> expected35{5, 7};
    EXPECT_EQ(G.twoHopNeighbors(3), expected35);

    std::set<int> expected4{6, 8};
    EXPECT_EQ(G.twoHopNeighbors(4), expected4);

    std::set<int> expected5{3};
    EXPECT_EQ(G.twoHopNeighbors(5), expected5);

    std::set<int> expected6{4, 8};
    EXPECT_EQ(G.twoHopNeighbors(6), expected6);

    std::set<int> expected7{3};
    EXPECT_EQ(G.twoHopNeighbors(7), expected7);
}

// Test two-hop neighbors - second example from header
TEST_F(GraphTest, TwoHopNeighbors_Example2)
{
    Graph G2;
    G2 += 3;
    G2 += 4;
    G2 += 9;
    G2 += 6;

    G2.addEdge(3, 4);
    G2.addEdge(4, 9);
    G2.addEdge(3, 9);
    G2.addEdge(9, 6);
    G2.addEdge(3, 6);

    std::set<int> expected{4, 6, 9};
    EXPECT_EQ(G2.twoHopNeighbors(3), expected);
    EXPECT_EQ(G2.twoHopNeighbors(4), expected);
    EXPECT_EQ(G2.twoHopNeighbors(9), expected);
    EXPECT_EQ(G2.twoHopNeighbors(6), expected);
}

// Test edge cases
TEST_F(GraphTest, EdgeCases)
{
    // Test non-existent vertex
    EXPECT_EQ(G.twoHopNeighbors(10).size(), 0);

    // Test isolated vertex
    G += 10;
    EXPECT_EQ(G.twoHopNeighbors(10).size(), 0);

    // Test vertex with only one-hop neighbors
    G.addEdge(3, 4);
    G.addEdge(3, 5);
    EXPECT_EQ(G.twoHopNeighbors(3).size(), 0);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}