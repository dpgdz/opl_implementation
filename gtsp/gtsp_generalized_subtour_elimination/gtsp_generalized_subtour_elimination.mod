/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 27, 2024 at 2:38:46 PM
 *********************************************/

int nbV=...; //number of vertices
int nbC=...; //number of clusters

range vertices=1..nbV;
range clusters=1..nbC;

float costs[vertices, vertices]=...; // cost associated with each edge
int cluster_idx[vertices]=...; // index of the cluster to which each vertice belongs

dvar boolean x[vertices, vertices] ; // x[edge]=1 if the edge is chosen.
dvar boolean z[vertices] ; // z[vertice]=1 if the vertice is chosen.

// create powerset (set that contain all possible stes)
int number_of_sets = ftoi(pow(2, nbV)) - 2; // subtract 2 to exclude the empty set and the set of all elements
{int} subsets[k in 1..number_of_sets] =
    {i | i in 1..nbV: ((k div (ftoi(pow(2, (ord(asSet(1..nbV), i))))) mod 2) == 1)};

// objective function: 
minimize sum(i in vertices, j in vertices) (costs[i,j] * x[i,j]);

// constraints
subject to {
	// select exactly one vertex from each cluster
  	forall (p in clusters) {
  	  ct1:
   		sum (v in vertices: cluster_idx[v] == p) z[v] == 1;
    } ;
   
  	// degree constraints: guarantee 1 cluster connect exacty 2 other clusters
    forall (v in vertices) {
        sum(i in vertices: i != v) x[i, v] == z[v]; // Exactly one incoming edge if the vertex is chosen
        sum(i in vertices: i != v) x[v, i] == z[v]; // Exactly one outgoing edge if the vertex is chosen
    }
	  
	// generalized subtour elimination constraints
	forall (s in 1..number_of_sets: 2 <= card(subsets[s]) <= nbC - 2, i in subsets[s]) {
		sum (k in subsets[s], j in subsets[s]: k<j) x[k,j] <= sum (v in subsets[s]: v != i) z[v];
	};
};