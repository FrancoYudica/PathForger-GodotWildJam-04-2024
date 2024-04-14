shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0f);
uniform float edge_blur = 0.05f;

void fragment() {
	float outer_radius = 1.0f;
	float inner_radius = .81;
	vec2 centered = (2.0f * UV - vec2(1.0f));
	float l = dot(centered, centered);
	
	float outer_circle = smoothstep(outer_radius, outer_radius - edge_blur, l);
	float inner_circle = smoothstep(inner_radius, inner_radius - edge_blur, l);
	
	COLOR = color;
	COLOR.a = outer_circle - inner_circle;
}

