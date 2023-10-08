shader_type canvas_item;
render_mode blend_mix;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.0) {
		COLOR.b += 0.5;
	}
}