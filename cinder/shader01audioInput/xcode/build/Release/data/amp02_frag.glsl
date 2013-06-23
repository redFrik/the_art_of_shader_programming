#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;	//common technique to normalize xy position 0-1
	float r= iAmplitude*sin(uv.x*3.1415)*15.0;	//amplitude tracker control red (saturated)
	float g= abs(uv.y-0.5)*5.0;					//distance from vertical center control green (saturated)
	float b= (sin(iGlobalTime)*0.5+0.5);		//time control blue
    gl_FragColor= vec4(r, g, b, 1.0);
}
