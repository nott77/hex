/// scr_color_move_node(node ID, actor's move, actor's actions);

var node;
var move;
var actions;

node = argument0;
move = argument1;
actions = argument2;

if (actions > 1) {
    if (node.g_score > move) {
        node.color = c_yellow;
    } else {
        node.color = c_aqua;
    }
} else {
    node.color = c_yellow;
}
