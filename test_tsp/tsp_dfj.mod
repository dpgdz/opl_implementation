/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 7, 2024 at 12:48:39 AM
 *********************************************/

// number of nodes
int N=...;

//distance matrix
int c[1..N, 1..N] = ...; 

//decision variable 
dvar boolean x[1..N,1..N];

// create powerset (set that contain all possible stes)
int number_of_sets=ftoi(pow(2,N)-2); // tru tap rong va tap tat ca phan tu 
{int} P[k in 1..number_of_sets]=
		{i | i in 1..N:
		((k div (ftoi(pow(2,(ord(asSet(1..N),i))))) mod 2) == 1)
		};

//objective
minimize sum(i in 1..N)sum(j in 1..N) c[i,j]*x[i,j];

//constraints
subject to {
		// salesperson entering a node j
		forall (j in 1..N){
				sum (i in 1..N) x[i,j]==1;
		};

		forall (i in 1..N){
				sum (j in 1..N) x[i,j]==1;
		};

		forall (k in 1..number_of_sets: 2<=k<=N-1){
				sum(i, j in P[k]) x[i,j]<=card(P[k])-1;
		};
};