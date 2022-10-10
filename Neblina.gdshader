shader_type canvas_item;

uniform vec3 cores = vec3(0.55, 0.78, 0.95);
uniform int OITAVAS = 4;

float rand(vec2 coord){
	return fract(sin(dot(coord, vec2(56, 78)) * 1000.0) * 1000.0);
}

float ruido(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);

	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));

	vec2 cubic = f * f * (3.0 - 2.0 * f);

	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){
	float valor = 0.0;
	float escalar = 0.5;

	for(int i = 0; i < OITAVAS; i++){
		valor += ruido(coord) * escalar;
		coord *= 2.0;
		escalar *= 0.5;
	}
	return valor;
}

void fragment() {
	vec2 coord = UV * 20.0;

	vec2 movimento = vec2( fbm(coord + vec2(TIME * -0.5, TIME * 0.5)) );

	float final = fbm(coord + movimento);

	COLOR = vec4(cores, final * 0.5);
}
