#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	float a= sin(iGlobalTime*2)*0.5+0.5;	//make a oscillate from 0 to 1
	gl_FragColor= vec4(a, a, a, 1.0);
}
