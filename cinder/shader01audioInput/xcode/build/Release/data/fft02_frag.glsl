#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	vec4 a= texture2D(iChannel1, vec2(uv.x*0.1, 0.0))*mod(uv.y*100.0, 5.0);
	gl_FragColor= vec4(a.x, a.x, a.x, 1.0);
}
