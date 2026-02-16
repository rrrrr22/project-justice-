shader_type canvas_item;
uniform sampler2D cloud_noise : repeat_enable;
uniform vec2 camera_position;
uniform int layer : hint_range(1, 3, 1);
uniform float mesh_width;
uniform float mesh_height;
void vertex() {
	// Called for every vertex the material is visible on.
}

float sinBetween(float a, float b, float v)
{
	float half = (b - a) / 2.;
	return a + half + sin(v) * half;
}
void fragment() {
	
	vec2 centeredUV = vec2(UV * 2. - 1.) + camera_position / vec2(mesh_width,-mesh_height);

	centeredUV = floor(centeredUV * (vec2(mesh_width,mesh_height) / 4.)) / (vec2(mesh_width,mesh_height) /4.);
	
	// apply 3d cylinder feel to it
	centeredUV.x += centeredUV.x * 2.;
	switch(layer)
	{
		case 1:
			vec2 stretchyUV1 = vec2(round(TIME * 24.) / 24. * 0.4,0) - centeredUV  * vec2(0.2,1);
			COLOR = texture(cloud_noise,stretchyUV1) * texture(cloud_noise,stretchyUV1 * 1.1).a;
			break;
		case 2:
			vec2 stretchyUV2 = vec2(round(TIME * 24.) / 24. * 0.4,0) - centeredUV  * vec2(0.3,1) + vec2(0.1,0.1);
			COLOR = texture(cloud_noise,stretchyUV2) * texture(cloud_noise,stretchyUV2 * 1.1).a;
		break;
		case 3:
			vec2 stretchyUV3 = vec2(round(TIME * 24.) / 24. * 0.4,0) - centeredUV  * vec2(0.1,1) + vec2(0.34,0.24);
			COLOR = texture(cloud_noise,stretchyUV3) * texture(cloud_noise,stretchyUV3 * 1.1).a;
		break;
	}
	COLOR = floor(COLOR * 4.) / 4.;

}
