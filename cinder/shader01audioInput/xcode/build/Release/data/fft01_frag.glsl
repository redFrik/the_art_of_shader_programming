#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	float u= gl_FragCoord.x/iResolution.x;
	vec4 a= texture2D(iChannel1, vec2(u*0.1, 0.0));
	gl_FragColor= vec4(a.x*0.05, u*a.x*0.1, u*a.x*0.5, 1.0);
}
