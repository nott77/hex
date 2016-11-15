///scr_gen_hex_grid();

// Vars
globalvar map;

globalvar node_w; node_w = sprite_get_width(s_hex_2);
globalvar node_h; node_h = sprite_get_height(s_hex_2);

globalvar map_offset_x; map_offset_x = 320;
globalvar map_offset_y; map_offset_y = 220;

map_w = 13;
map_h = 9;

xPos = 0;

offset_y = node_h * (3/4); // 104
offset_x = node_w/2;


// Create Grid/Nodes
for (xx = 0; xx < map_w; xx += 1) {
    for (yy = 0; yy < map_h; yy +=1) {
        
        xPos = offset_x;
        
        // Are we on an odd row?
        if (yy mod 2 == 1) {
            xPos += offset_x;
        }    
        map[xx, yy] = instance_create(xx * node_w + xPos + map_offset_x, yy * offset_y + map_offset_y, o_node);
        map[xx, yy].grid_x = xx;
        map[xx, yy].grid_y = yy;
    } 
}


// Populate Neighbor Lists for Nodes
for (xx = 0; xx < map_w; xx += 1){
    for (yy = 0; yy < map_h; yy += 1){
       
        // Store array in var    
        node = map[xx,yy];
         
        //For xOffset = 0 hexes
        if ( yy mod 2 == 0){

            //Top Right Neighbor
            if (yy > 0){
                ds_list_add(node.neighbors, map[xx, yy - 1]);
            }
            //Right Neighbor
            if (xx + 1 < map_w){
                ds_list_add(node.neighbors, map[xx + 1, yy]);
            }
            //Bot Right Neighbor
            if (yy + 1 < map_h){
                ds_list_add(node.neighbors, map[xx, yy + 1]);
            }    
            //Bot Left Neighbor
            if (xx > 0 && yy + 1 < map_h){
                ds_list_add(node.neighbors, map[xx - 1, yy + 1]);
            }  
            //Left Neighbor
            if (xx > 0){
                ds_list_add(node.neighbors, map[xx - 1, yy]);
            }  
            //Top Left Neighbor
            if (yy > 0 && xx > 0){
                ds_list_add(node.neighbors, map[xx - 1, yy - 1]);
            }        
        }
        else{ //For xOffset > 0 hexes

            //Top Right Neighbor
            if (yy > 0 && xx + 1 < map_w){
                ds_list_add(node.neighbors, map[xx + 1, yy - 1]);
            }
            //Right Neighbor
            if (xx + 1 < map_w){
                ds_list_add(node.neighbors, map[xx + 1, yy]);
            }
            //Bot Right Neighbor
            if (xx + 1 < map_w && yy + 1 < map_h){
                ds_list_add(node.neighbors, map[xx + 1, yy + 1]);
            }    
            //Bot Left Neighbor
            if (yy + 1 < map_h){
                ds_list_add(node.neighbors, map[xx, yy + 1]);
            }  
            //Left Neighbor
            if (xx > 0){
                ds_list_add(node.neighbors, map[xx - 1, yy]);
            }  
            //Top Left Neighbor
            if (yy > 0){
                ds_list_add(node.neighbors, map[xx, yy - 1]);
            }          
        }    
    }
}

// Generate Terrain
scr_gen_terrain();
