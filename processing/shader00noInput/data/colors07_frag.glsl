#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec3 uvw= gl_FragCoord.xyz/vec3(iResolution.xy, 1.0);
	float x= smoothstep(0.25, 1.0, sin(uvw.x+iGlobalTime*10.0));
	float y= smoothstep(sin(iGlobalTime*10.11)*sin(iGlobalTime*10.14), 0.5, sin(uvw.y*pow(2.0, sin(iGlobalTime*0.01)+0.5*0.5*50.0)));
	gl_FragColor= vec4(x, y*x, y*x, 1.0);
}
