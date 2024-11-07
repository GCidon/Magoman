shader_type canvas_item;

uniform float amount = 40.0;

void fragment() {
	float a = fract(sin(dot(UV, vec2(12.9898, 78.233) * TIME)) * 438.5453) * 5.0;
	vec4 col = texture(TEXTURE, UV);
	col.a *= pow(a, amount);
	COLOR.r = 0.5;
	COLOR.g = 0.5;
	COLOR.b = 0.5;
	COLOR.a = col.a;
}