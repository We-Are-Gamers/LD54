extends VBoxContainer


var paths = []
var path_taken = []

func _draw_selection(button):
	var texture = button.texture_normal
	var half_size: Vector2 = texture.get_size() / 2
	var pos = button.get_global_position() + half_size
	pos -= get_global_position()
	draw_arc(pos, half_size.length(),0, 12, 100, Color.BLACK, 1, true)


func _draw_path(from, to):
	draw_line(from, to, Color.SLATE_GRAY, 5.0)


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
	for button in path_taken:
		_draw_selection(button)
	for row in paths:
		_draw_row_connections(row)
