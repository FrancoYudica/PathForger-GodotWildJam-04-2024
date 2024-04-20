shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR = texture(TEXTURE, UV) * texture(screen_texture, SCREEN_UV).a;
}
