shader_type canvas_item;
uniform vec3 color: source_color = vec3(1.0f);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV) * vec4(color.r, color.g, color.b, 1.0);
}

