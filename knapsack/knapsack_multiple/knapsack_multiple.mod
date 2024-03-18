/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 8, 2024 at 3:04:01 PM
 *********************************************/

 int Nbitems=...;
 int knapss=...;
 
 range items=1..Nbitems;
 range knaps=1..knapss;
 
 int capacity[knaps]=...;
 int weights[items]=...;
 int profits[items]=...;
 
 // decision variable(s)
 dvar int x[knaps][items] in 0..1;
 
 
// objective
 maximize sum(i in knaps)sum(j in items)(profits[j]*x[i,j]);
 
 
// constraints
 subject to {
   forall (i in knaps) 
   ct:
   	{
     sum(j in items) (weights[j]*x[i,j])<=capacity[i];
    };   
    
    forall (j in items) {
      sum(i in knaps)x[i,j]<=1;
    };
    
 };
 
 // Take Solution
 tuple TakeSolutionT{ 
	int items; 
	int value; 
};
{TakeSolutionT} TakeSolution = {<i0,x[i0][j0]> | i0 in knaps, j0 in items};
execute{ 
	writeln(TakeSolution);
}
