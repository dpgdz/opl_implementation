/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 16, 2024 at 6:05:50 PM
 *********************************************/
 
 /********************************************
 job: Number of jobs
 n: Number of people
 
 jobs: Range representing jobs
 ns: Range representing people
 
 cost[i,j]: Cost matrix representing the cost of assigning person i to job j
 
 x[i,j]: Binary decision variable representing whether person i is assigned to job j
 
 → Problem: find a minimum cost assignment 
 
 ********************************************/

 // variables 
int job=...; 
int n=...; // number of people

range jobs=1..job;
range ns=1..n;

int cost[ns][jobs]=...;

// decision variable(s)
dvar boolean x[ns][jobs];

// objective function
minimize sum(i in ns) sum(j in jobs) (cost[i,j] * x[i,j]);

subject to {
		// Each job j is done by 1 person 
		forall (j in jobs){
				sum(i in ns) x[i,j]==1;
				};
		
		// Each person i done one job: 
		forall (i in ns){
				sum(j in jobs) x[i,j]==1;
				};
};

tuple TakeSolutionT {
    int person;
    int job;
}

{TakeSolutionT} TakeSolution = {<i, j> | i in ns, j in jobs: x[i][j] == 1};

execute {
    writeln(TakeSolution);
}


