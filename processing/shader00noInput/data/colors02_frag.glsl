#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	float x= sin(iGlobalTime+uv.x*4.0)*0.5+0.5;
	float y= cos(iGlobalTime+uv.y*5.0)*0.5+0.5;
	gl_FragColor= vec4(x, y, 0, 1.0);
}
