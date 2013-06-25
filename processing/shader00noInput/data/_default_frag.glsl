#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform vec2 iMouse;

void main() {
	gl_FragColor= vec4(1.0, 0.0, 0.0, 1.0);		//make everything red
}

