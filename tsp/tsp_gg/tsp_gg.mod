/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 16, 2024 at 6:00:22 PM
 *********************************************/
 
 /********************************************
 N: number of nodes in the network, i.e.., the number of cities
 cij: the distance between any two nodes i,j
 xij: decision variable to describe if the salesperson traverses from node i to node j (nij=1), or not (xij=0)
 zij: track a travelled arc’s position in the salesperson tour
 
→ Problem: find the shortest possible for a traveling salesman seeking to visit each city on a list exactly once and return to his city of origin
**********************************************/

// number of nodes
int N=...;

// distance matrix
int c[1..N, 1..N] =...; 

// decision variable
dvar boolean x[1..N,1..N];
dvar int+ z[2..N,1..N];

//objective
minimize sum(i in 1..N) sum(j in 1..N) (c[i,j] * x[i,j]);

// constraint
subject to{
			// salesperson entering a node j
			forall (j in 1..N){
					sum(i in 1..N) x[i,j]==1;
			};
			
			// salesperson leaving node i
			forall(i in 1..N){
					sum(j in 1..N) x[i,j]==1;
			};
			
			// subtour breaking 
			forall (i in 2..N){
					sum(j in 1..N) z[i,j] - sum(j in 2..N) z[j,i]==1;
			};
		
			forall (i in 2..N, j in 1..N){
					z[i,j] <=(N-1) * x[i,j];
			};
};

tuple TakeSolutionT {
    int step;
    int city;
}

{TakeSolutionT} TakeSolution = {<step, j> | step in 1..N, j in 1..N: x[j, step] == 1};

execute {
    writeln(TakeSolution);
}