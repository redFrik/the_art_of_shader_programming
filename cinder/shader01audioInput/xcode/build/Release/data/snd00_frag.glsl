#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	float u= gl_FragCoord.x/iResolution.x;	//common technique to normalize x position 0-1
	vec4 a= texture2D(iChannel0, vec2(u, 0.0));
	gl_FragColor= vec4(a.x, 0.0, 0.0, 1.0);
}
