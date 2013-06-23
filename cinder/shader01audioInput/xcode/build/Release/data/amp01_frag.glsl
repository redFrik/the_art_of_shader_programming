#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

void main() {
	vec2 uv= gl_FragCoord.xy/iResolution.xy;	//common technique to normalize xy position 0-1
	float r= iAmplitude;
	float g= sin(sin(iGlobalTime)+mod(uv.x, iAmplitude));
	float b= sin(sin(iGlobalTime*0.9)+mod(uv.y, iAmplitude));
    gl_FragColor= vec4(r, g, b, 1.0);
}
