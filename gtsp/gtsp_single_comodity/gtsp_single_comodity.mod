/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 28, 2024 at 2:17:52 AM
 *********************************************/

int nbV = ...; // Number of vertices
int nbC = ...; // Number of clusters

range vertices = 1..nbV;
range clusters = 1..nbC;

float costs[vertices][vertices] = ...; // Cost associated with each edge
int cluster_idx[vertices] = ...; // Index of the cluster to which each vertex belongs

dvar boolean x[vertices][vertices]; // x[edge] = 1 if the edge is chosen.
dvar boolean z[vertices]; // z[vertex] = 1 if the vertex is chosen.
dvar int+ f[vertices][vertices]; // Flow variable for each edga

// Objective function: minimize total cost
minimize sum(i in vertices, j in vertices) (costs[i, j] * x[i, j]);

// Constraints
subject to {
    // Select exactly one vertex from each cluster
    forall (p in clusters) {
        sum(v in vertices: cluster_idx[v] == p) z[v] == 1;
    }

    // Degree constraints: Guarantee that 1 cluster connects exactly 2 other clusters
    forall (v in vertices) {
        sum(i in vertices: i != v) x[i, v] == z[v]; // Exactly one incoming edge if the vertex is chosen
        sum(i in vertices: i != v) x[v, i] == z[v]; // Exactly one outgoing edge if the vertex is chosen
    }

    // Mass balance equations: Guarantee that (k-1) units of a single commodity flow into cluster C1,
    // and 1 unit flows out of each of the other clusters
    forall (i in vertices) {
        if (cluster_idx[i] == 1) {
             sum(j in vertices: i!=j) f[i, j] - sum(j in vertices: i!=j) f[j,i] == (nbC - 1) * z[i];
        } else {
			 sum(j in vertices: i!=j) f[i, j] - sum(j in vertices: i!=j) f[j,i] == -z[i];
        }
    }
    
    // Flow i -> j always less than k clusters
    forall (i in vertices, j in vertices: i != j) {
        f[i, j] <= (nbC - 1) * x[i, j];
    }
}



