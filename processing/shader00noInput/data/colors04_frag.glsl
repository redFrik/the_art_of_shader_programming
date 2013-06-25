#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform vec2 iMouse;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;
	float x= mod(cos(iGlobalTime+(uv.x*2.5))*10.0+20.0, uv.y);
	float y= mod(cos(iGlobalTime+(uv.x*2.5))*5.0+10.0, uv.x);
	gl_FragColor= vec4(x/y, x*y, y, 1.0);
}
