/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 7, 2024 at 5:47:38 PM
 *********************************************/

/********************************************
 Nbitems: Number of items
 items: Range representing items
 capacity: Knapsack capacity
 weights: Array representing the weight of each item
 profits: Array representing the profit of each item
 
 → Problem: maximize the total profit by selecting items with their weights and profits, ensuring that the total weight of selected items doesn't exceed the knapsack's capacity.
 ********************************************/

int Nbitems = ...;
range items = 1..Nbitems;
int capacity = ...;
int weights[items] = ...;
int profits[items] = ...;

// decision variable(s)
dvar float x[items] in 0..1; 

// objective function: Maximize total profit
maximize sum(j in items) profits[j] * x[j];

// Constraints
subject to {
    // total weight of selected items must not exceed capacity
    sum(j in items) weights[j] * x[j] <= capacity;
}

tuple TakeSolutionT {
    int item;
    float value;
}

{TakeSolutionT} TakeSolution = {<j, x[j]> | j in items: x[j] != 0};

execute {
    writeln(TakeSolution);

}
