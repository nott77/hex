/// scr_movement_range(origin node, unit's movement range, unit's remaining actions);

// Reset all node data
scr_wipe_nodes();

// Vars
var open;
var closed;

var start;
var current;
var neighbor;

var temp_g_score;
var range;
var cost_mod;

// Args
start = argument0;
range = argument1 * argument2;

// Create Data structures
open = ds_priority_create();
closed = ds_list_create();

// Add starting node to opne list
ds_priority_add(open, start, start.g_score);

// While opne queue is NOT empty...
// repeat the following until ALL nodes have been looked at
while (ds_priority_size(open) > 0) {
    
    // remove node with the lowest G score from open
    current = ds_priority_delete_min(open);
    
    // Add that node to the closed list
    ds_list_add(closed, current);
    
    // Step through all of CURRENT's neighbors
    for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1) {
        
        // Store current neighbor in neighbor var
        neighbor = ds_list_find_value(current.neighbors, ii);
        
        // Add neighbor to open list if it qualifies
        // What qualifies? ->
        // neighbors is accessible
        // neighbors doenst have an occupant
        // neighbors projected G score is less than movement range
        // neighbor isnt already on the closed list
        
        // if not on the closed list AND is accessible AND no occupant AND projected Gscore is less than movement range
        if (ds_list_find_index(closed, neighbor) < 0 and neighbor.accessible == true and neighbor.occupant == noone and neighbor.cost + current.g_score <= range) { 
            
            // Only calc a new G score for neighbor if it hasnt already been calc'd
            if (ds_priority_find_priority(open, neighbor) == 0 or ds_priority_find_priority(open, neighbor) == undefined) {
                cost_mod = 1;
                
                // give neighbor appropriate parent
                neighbor.parent = current;
                
                /*
                // if node is diag create appropriate cost mod (Not sure if use for Hex's
                if (neighbor.grid_x != current.grid_x and neighbor.grid_y != current.grid_y) {
                    cost_mode = 1.5;
                }
                */
                
                // Calc G score of neighbor, with cost mod in place
                neighbor.g_score = current.g_score + (neighbor.cost + cost_mod);
                
                // Add neighbor to open list, so it can be checked out too!!
                ds_priority_add(open, neighbor, neighbor.g_score);
            
            // ELSE!!!!!
            // If neighbors score has ALREADY been calc'd for the open list                                      
            } else {
                // Figure out if the neighbors score would be LOWER if found from the current node!
                cost_mod = 1;
                
                /*
                // if node is diag create appropriate cost mod (Not sure if use for Hex's
                if (neighbor.grid_x != current.grid_x and neighbor.grid_y != current.grid_y) {
                    cost_mode = 1.5;
                }
                */
                
                temp_g_score = current.g_score + (neighbor.cost * cost_mod);
                
                // check if G score would be lower
                if (temp_g_score < neighbor.g_score) {
                    neighbor.parent = current;
                    neighbor.g_score = temp_g_score;
                    ds_priority_change_priority(open, neighbor, neighbor.g_score);
                }
                
            }       
        
            
        }
                   
    
    }
    

}

// Round down all G scores for Movement calcs
with(o_node) {
    g_score = floor(g_score);
}

// Destroy open! IMPORTANT!
ds_priority_destroy(open);

// Color all move nodes and DESTROY closed list as well.

for (ii = 0; ii < ds_list_size(closed); ii +=1) {
    current = ds_list_find_value(closed, ii);
    current.move_node = true;
    
    scr_color_move_node(current, argument1, argument2);
}

// Destroy Closed List!! IMPORTANT!
ds_list_destroy(closed);





