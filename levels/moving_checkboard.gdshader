shader_type canvas_item;

uniform float num_cells = 10;
uniform vec3 color_cell_0: source_color = vec3(0.0f);
uniform vec3 color_cell_1: source_color = vec3(.1f);
uniform float columns_offset_strength: hint_range(0.0, 1.0, 0.1) = 0.0f;
uniform float rows_offset_strength: hint_range(0.0, 1.0, 0.1) = 0.0f;

void fragment() {
	
	// Calculates indices in grid range, [0, num_cells - 1] for both axis
	int column_index = int(floor(UV.x * num_cells));
	int row_index = int(floor(UV.y * num_cells));
	
	// Size of cell in normalized space
	float cell_offset = 1.0f / num_cells;
	float columns_offset = columns_offset_strength * cell_offset;
	float rows_offset = rows_offset_strength * cell_offset;
	
	// i, j are the offsetted grid indices
	
	// Takes value 1 if the row is even, if odd takes -1
	float even_row_value = float((row_index % 2) * 2 - 1);
	
	// Uses the value to get the grid cell with offset
	float i = floor((UV.x + rows_offset * even_row_value) * num_cells);

	// Same but with columns
	float even_column_value = float((column_index % 2) * 2 - 1);
	float j = floor((UV.y + columns_offset * even_column_value) * num_cells);
	
	// Final value t used to mix colors
	float t = mod(i + j, 2.0f);
	vec3 color = color_cell_0 * t + color_cell_1 * (1.0f - t);
	COLOR = vec4(color, 1.0f);
}

