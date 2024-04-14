shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0f);
uniform float edge_blur = 0.05f;
uniform int segments_count = 10;
uniform float rotation_speed = 2.0f;

void fragment() {
	
	// Calculates ring values
	float outer_radius = 1.0f;
	float inner_radius = .81;
	vec2 centered = 2.0f * UV - vec2(1.0f);
	float l = dot(centered, centered);
	
	float outer_circle = smoothstep(outer_radius, outer_radius - edge_blur, l);
	float inner_circle = smoothstep(inner_radius, inner_radius - edge_blur, l);
	
	// Ring color
	COLOR = color;
	COLOR.a = outer_circle - inner_circle;
	
	// Now calculates segments
	float angle = atan(centered.y / centered.x);
	float t = abs(sin(angle * float(segments_count) + TIME * rotation_speed));
	t = smoothstep(0.5, 0.6, t);
	COLOR.a *= t;
}

