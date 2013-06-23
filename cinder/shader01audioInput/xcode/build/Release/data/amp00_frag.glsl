#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec2 vu= gl_FragCoord.xy;
	float r= iAmplitude;
	gl_FragColor= vec4(sin(r*vu.x)*0.5+0.5, sin(r*vu.y)*0.5+0.5, 0.0, 1.0);
}
