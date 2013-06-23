#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec3 uvw= gl_FragCoord.xyz/vec3(iResolution.xy, 1.0);	//using the 3rd dimension (works best in mode 4 (sphere))
	float x= abs(sin(uvw.x*52.0))*sin(uvw.y*56.0+iGlobalTime);
	float y= abs(cos(uvw.y*50.0+iGlobalTime)*sin(uvw.y*5.0+iGlobalTime));
	float z= abs(cos(uvw.z*180.0+iGlobalTime*2.0));
	float a= (x+y)*0.667;
	gl_FragColor= vec4(z, a, a, 1.0);
}
