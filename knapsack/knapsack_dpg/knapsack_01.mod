/*********************************************
 * OPL 22.1.1.0 Model
 * Author: duongphuonggiang
 * Creation Date: Mar 7, 2024 at 4:47:02 PM
 *********************************************/

/********************************************
 Nbitems: number of items
 items: range representing items
 capacity: knapsack capacity
 weights[j]: array representing the weight of each item j
 profits[j]: array representing the profit of each item j
 
 → Problem: maximize the total profit by selecting items with their weights and profits, ensuring that the total weight of selected items doesn't exceed the knapsack's capacity.
 ********************************************/

// number of items and range representing items
int Nbitems = ...;
range items = 1..Nbitems;

// knapsack capacity
int capacity = ...;

// arrays representing weights and profits of items
int weights[1..Nbitems] = ...;
int profits[1..Nbitems] = ...;

// decision variable(s)
dvar boolean x[1..Nbitems];  // x[j]==1 if item 1 is chosen 

// objective function: Maximize total profit
maximize sum(j in items) (profits[j] * x[j]);

// Constraints
subject to {
    // total weight of selected items must not exceed capacity
    sum(j in items) (weights[j] * x[j]) <= capacity;
};


tuple TakeSolutionT {
    int item;
}

{TakeSolutionT} TakeSolution = {<j> | j in items: x[j] == 1};

execute {
    writeln("selected items:");
    for (var sol in TakeSolution) {
        writeln("Item ", sol.item);
    }
}
