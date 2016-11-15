/// scr_wipe_nodes();

// reset data of all nodes

with(o_node) {
    move_node = false;
    g_score = 0;
    parent = noone;
    color = c_white;
}
