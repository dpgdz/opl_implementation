/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 7, 2024 at 2:24:23 PM
 *********************************************/

 // number of nodes
int N=...;

// distance matrix:
int c[1..N,1..N]=...;

// decision variables: 
dvar boolean x[1..N,1..N]; // xij
dvar int+ u[1..N]; //uij

// objective
minimize sum(i in 1..N) sum(j in 1..N) c[i,j]*x[i,j];

// constraints
subject to {
	// sales person entering node j: 
	forall(j in 1..N) {
			sum(i in 1..N)(x[i,j])==1;
	};

	// salesperson leaving node i: 
	forall(i in 1..N) {
			sum(j in 1..N)(x[i,j])==1;
	}

	// subtour breaking constraints (MTZ)
	forall (i,j in 1..N: j!=1 && i!=1) {
			u[i]-u[j] +N*x[i,j] <= N-1;
	}
};