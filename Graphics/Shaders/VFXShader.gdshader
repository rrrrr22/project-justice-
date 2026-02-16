shader_type canvas_item;
uniform float percentage_to_remove_background : hint_range(0.0, 1.0, 0.01);
uniform float black_color_at_value_to_remove : hint_range(0.0, 1.0, 0.01);


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float removed_percent = (smoothstep(0,percentage_to_remove_background,texture(TEXTURE,UV).r));
	float removed_at_value = (step(texture(TEXTURE,UV).r,black_color_at_value_to_remove));
	COLOR.a = removed_percent - removed_at_value;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
