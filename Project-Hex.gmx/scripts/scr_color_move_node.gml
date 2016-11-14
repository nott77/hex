/// scr_color_move_node(node ID, actor's move, actor's actions);

var node_id;
var move;
var actions;

node_id = argument0;
move = argument1;
actions = argument2;

if (actions > 1) {
    if (node_id.g_score > move) {
        node_id.color = c_yellow;
    } else {
        node_id.color = c_aqua;
    }
} else {
    node_id.color = c_yellow;
}
