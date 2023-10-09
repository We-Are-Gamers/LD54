shader_type canvas_item;
render_mode blend_mix;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.0 && COLOR.r < .01) {
		COLOR.a = 0.25;
	}
}
