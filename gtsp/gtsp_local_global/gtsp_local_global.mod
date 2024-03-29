/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 27, 2024 at 4:02:15 PM
 *********************************************/
int nbV = ...; // Number of vertices
int nbC = ...; // Number of clusters

range vertices = 1..nbV;
range clusters = 1..nbC;

float costs[vertices, vertices] = ...; // Cost associated with each edge
int cluster_idx[vertices] = ...; // Index of the cluster to which each vertex belongs

dvar boolean x[vertices, vertices]; // x[edge] = 1 if the edge is chosen
dvar boolean z[vertices]; // z[vertex] = 1 if the vertex is chosen
dvar boolean y[clusters, clusters]; // y[p][q] = 1 if cluster p is connected to cluster q
dvar float+ t[clusters]; // Real variables associated with each cluster for sub-tour elimination

// Objective function: Minimize the total cost of chosen edges
minimize sum(i in vertices, j in vertices) (costs[i,j] * x[i,j]);

subject to {
  // Select exactly one vertex from each cluster
  forall (p in clusters) {
    sum (v in vertices: cluster_idx[v] == p) z[v] == 1;
  };

  // Ensure each cluster has exactly one outgoing and one incoming connection
  forall (p in clusters) {
    sum (q in clusters: q != p) y[p,q] == 1;
  };
  
  forall (q in clusters) {
    sum (p in clusters: p != q) y[p,q] == 1;
  };

  // Sub-tour elimination constraints for clusters
  forall (p in clusters: p != 1, q in clusters: q != p && q != 1) {
    (nbC-1) * y[p,q] + t[p] - t[q] <= nbC - 2;
  }; 

  // Enforce edge selection between clusters based on y[p,q]
  forall (p in clusters, q in clusters: q != p) {
    sum (i in vertices: cluster_idx[i] == p, j in vertices: cluster_idx[j] == q ) x[i,j] == y[p,q]; 
  };

  
  // Link z[vertex] to x[edge] to ensure that if a vertex is chosen, there must be an edge coming into and going out of it
  forall (i in vertices) {
    sum (j in vertices) x[i,j] == z[i];
    sum (j in vertices) x[j,i] == z[i];
  };

  // Restrict connections from a vertex to another cluster based on z[vertex]
  forall (i in vertices) {
    sum (j in vertices) x[i,j] <= z[i];
    sum (j in vertices) x[j,i] <= z[i];
  };
};
