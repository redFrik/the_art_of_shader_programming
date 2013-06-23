#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec3 uvw= gl_FragCoord.xyz/vec3(iResolution.xy, 1.0);	//using the z dimension (only works with mode 4 (sphere))
	vec4 e= texture2D(iChannel1, vec2(uvw.z*0.5, 0.0));
	vec4 f= texture2D(iChannel1, vec2((1.0-uvw.x)*0.5, 0.0));
	gl_FragColor= (
		vec4(e.x, e.x, e.x, 1.0)
		+vec4(f.x, f.x, f.x, 1.0)
	)*0.5;
}
