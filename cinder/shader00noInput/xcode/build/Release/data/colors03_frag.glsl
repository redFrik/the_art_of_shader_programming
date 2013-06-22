#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	float x= mod(iGlobalTime+uv.x*10.0, 2.3);
	float y= mod(iGlobalTime-uv.y*4.0, 1.2);
	gl_FragColor= vec4(x, y, 1.0-x, 1.0);
}
