#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    gl_FragColor= vec4(1.0, 0.0, 0.0, 1.0);		//make everything red
}
