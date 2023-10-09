extends VBoxContainer


var paths = []
var path_taken = []


func _draw_path(from, to, color):
	draw_dashed_line(from, to, color, 5.0, 20, false)


func _get_button_pos(node):
	var texture = node.texture_normal
	var pos = node.get_global_position() + texture.get_size() / 2
	return pos - get_global_position()


func _draw_node_connections(node):
	var node_pos = _get_button_pos(node.button)
	var path_index = path_taken.find(node.button)
	for connection in node.connections:
		var color = Color.SLATE_GRAY
		if(path_index > -1 && path_index + 1 < path_taken.size() && path_taken[path_index + 1] == connection):
			color = Color.BLACK
		var next_pos = _get_button_pos(connection)
		_draw_path(node_pos, next_pos, color)


func _draw_row_connections(row):
	for node in row:
		_draw_node_connections(node)

func _draw():
	for row in paths:
		_draw_row_connections(row)
