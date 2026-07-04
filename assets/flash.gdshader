shader_type canvas_item;

uniform bool enabled = false;
uniform float brightness = 0.8;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 img = texture(TEXTURE, UV);
	if (enabled) {
		COLOR = vec4(brightness, brightness, brightness, img.a);
	}
}
