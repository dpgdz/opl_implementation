/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 9, 2024 at 4:04:00 PM
 *********************************************/
 
 /********************************************
 
N={1…n}: set of potential depots N
M: {1,..,m}: set of clients

fj: fixed cost associated with the use of depot 
cij: transportation cost if all of the clinet i’s order is delivered from depot j

→ Problem: decide which depots to open and which serve each client so as to minimize the sum of the fixed, transportation cost 
 
 *********************************************/

int N=...; // number of potential depot (j)
int M=...; // number of client (i)

int f[1..N]=...; // fixed cost associate with the use of depot j
int cost[1..M][1.. N]=...; // transportation cost form depot j to client i

// decision variable(s) 
dvar float+ y[1..M][1..N]; // the fraction of the demand of client i satisfied from depot j
dvar boolean x[1..N]; // xj=1 if depot j is used, and xj=0$ otherwise 

//  objective function
// minimize the total cost, which is the sum of transportation costs and fixed costs
minimize sum(i in 1..M) sum(j in 1..N) (cost[i,j] * y[i,j]) + sum(j in 1..N) (f[j] * x[j]);

//constraints
subject to {
  		// each client must be assigned to exactly one depot
		forall (i in 1..M) {
				sum(j in 1..N) y[i,j] ==1;
		};
		
		// the total fraction of client orders assigned to each depot cannot exceed its capacity
		forall (j in 1..N) {
				sum(i in 1..M) y[i,j] <= M * x[j];
		};
};

tuple TakeSolutionT {
    int depot;
    int client;
    float fraction;
}

{TakeSolutionT} TakeSolution = {<j, i, y[i,j]> | i in 1..M, j in 1..N: y[i,j] > 0};

execute {
    writeln(TakeSolution);
}