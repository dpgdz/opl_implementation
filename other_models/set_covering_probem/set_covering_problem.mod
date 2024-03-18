/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 12, 2024 at 2:52:52 PM
 *********************************************/

/*********************************************
c_j: cost of installing a service center

M={1,…,m}: set of regions
N={1,…,n}: set of potential centers
S_j \subseteq M be the regions that can be serviced by a center at j in N  

→ Problem: decide where to install emergency service centers. 
**********************************************/
int N=...; // number of potential centers
int M=...; // number of regions

int c[1..N]=...; //cost of installing j service center
int a[1..M][1..N]=...; // incidence matrix A

// decision variables
dvar int x[1..N] in 0..1;

// objective
minimize sum(j in 1..N)(c[j]*x[j]);

// constraints
subject to {
	// At least one center must service region i
	forall (i in 1..M) {
	  sum(j in 1..N) (a[i,j] * x[j]) >= 1;
	};
};

tuple TakeSolutionT {
    int center;
}

{TakeSolutionT} TakeSolution = {<j> | j in 1..N: x[j] == 1};

execute {
    writeln(TakeSolution);
}