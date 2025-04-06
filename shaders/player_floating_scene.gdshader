shader_type spatial;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear;
const int pixel_size = 4;

void fragment() {
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);
	x = FRAGCOORD.x + floor(float(pixel_size) / 2.0) - x;
	y = FRAGCOORD.y + floor(float(pixel_size) / 2.0) - y;
	
	// Water distortion
	vec2 uv = vec2(x, y) / VIEWPORT_SIZE;
	
	// Sin and cos waves to simulate moving
	// For some reason, just Y looks better
	//uv.x += sin(uv.y * 15.0) * 0.005;
	uv.y += cos(uv.x * 15.0) * 0.005;
	
	// Assign to ALBEDO for 3D materials
	ALBEDO = texture(screen_texture, uv).rgb;
}