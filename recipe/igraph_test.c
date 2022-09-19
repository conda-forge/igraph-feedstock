#include <igraph.h>

int main(void)
{
     igraph_real_t diameter;
     igraph_t graph;
     igraph_rng_seed(igraph_rng_default(), 42);
     igraph_erdos_renyi_game(&graph, IGRAPH_ERDOS_RENYI_GNP, 1000, 5.0/1000,
                             IGRAPH_UNDIRECTED, IGRAPH_NO_LOOPS);
     igraph_diameter(&graph, &diameter, 
                     /*from=*/NULL, /*to=*/NULL, /*vertex_path=*/NULL, /*edge_path=*/NULL,
                     IGRAPH_UNDIRECTED, /*unconn=*/true);
     printf("Diameter of a random graph with average degree 5: %d\n",
             (int) diameter);
     igraph_destroy(&graph);
     return 0;
}

