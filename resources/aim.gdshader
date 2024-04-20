shader_type canvas_item;

uniform float speed = 1.0f;
uniform int segments_count = 10;
uniform vec4 color: source_color = vec4(1.0f);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	uv.x *= float(segments_count);
	vec4 texture_color = texture(TEXTURE, uv - vec2(TIME * speed, 0.0));
	COLOR = texture_color * color;
	COLOR.a *= 1.0 - UV.x;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
