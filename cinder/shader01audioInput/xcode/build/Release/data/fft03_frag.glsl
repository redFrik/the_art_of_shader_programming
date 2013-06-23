#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	vec4 a= texture2D(iChannel1, vec2(uv.x*0.5, 0.0));
	vec4 b= texture2D(iChannel1, vec2((1.0-uv.x)*0.5, 0.0));
	vec4 c= texture2D(iChannel1, vec2(uv.y*0.5, 0.0));
	vec4 d= texture2D(iChannel1, vec2((1.0-uv.y)*0.5, 0.0));
	gl_FragColor= (vec4(a.x, a.x, b.x, 1.0)
		+vec4(b.x, b.x, a.x, 1.0)
		+vec4(c.x, c.x, c.x, 1.0)
		+vec4(d.x, d.x, d.x, 1.0))*0.25;
}
