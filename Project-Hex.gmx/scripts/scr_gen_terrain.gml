///scr_gen_terrain();

// Gen Sand
repeat (10) {

    rand_x = irandom_range(0, map_w-1);
    rand_y = irandom_range(0, map_h-1);
    
    with (instance_create(map[rand_x,rand_y].world_x, map[rand_x,rand_y].world_y, o_sand)) {
        //grid_x = rand_x;    
        //grid_y = rand_y;
    }
}

// Gen Rock
repeat (10) {

    rand_x = irandom_range(0, map_w-1);
    rand_y = irandom_range(0, map_h-1);
    
    with (instance_create(map[rand_x,rand_y].world_x, map[rand_x,rand_y].world_y, o_rock)) {
        //grid_x = rand_x;    
        //grid_y = rand_y;
    }
}



