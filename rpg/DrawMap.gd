extends VBoxContainer


var paths = []

func _draw_path(from, to):
	draw_line(from, to, Color.BLUE_VIOLET, 5.0)
	
func _get_button_pos(node):
	var texture = node.texture_normal
	var pos = node.get_global_position() + texture.get_size() / 2
	return pos - get_global_position()

func _draw_node_connections(node):
	var node_pos = _get_button_pos(node.button)
	for connection in node.connections:
		var next_pos = _get_button_pos(connection)
		_draw_path(node_pos, next_pos)

func _draw_row_connections(row):
	for node in row:
		_draw_node_connections(node)
	
func _draw():
	for row in paths:
		_draw_row_connections(row)
