#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	float x= abs(sin(uv.x*uv.y*16.0)+sin(0.2*iGlobalTime));
	float y= abs(cos(uv.y+uv.x)-sin(iGlobalTime));
	gl_FragColor= vec4(x+y, x*y, 0.0, 1.0);
}
