shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 water_color : source_color;
uniform sampler2D wave_noise : repeat_enable;

void fragment() {
	vec2 water_wave = (texture(wave_noise, UV + TIME * 0.02).rg - 0.5) * 0.02;
	vec2 uv = vec2(SCREEN_UV.x, SCREEN_UV.y - UV.y) + water_wave;
	vec4 color = texture(screen_texture, uv);
	float mix_value = 1.0 - UV.y;
	
	float avg_color = (color.r + color.g + color.b) / 3.0;
	avg_color = pow(avg_color, 1.4);
	mix_value += avg_color;
	
	mix_value = clamp(mix_value, 0.0, 0.7);
	COLOR = mix(water_color, color, mix_value);
}

