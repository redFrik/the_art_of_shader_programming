#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= iResolution.x-v.x;		//simple leftright mirroring
    //v.x= mod(v.x+(iResolution.x*0.5), iResolution.x);
    v.x= v.x-(iResolution.x);	//uncomment this line to make it work with the sound and fft
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
