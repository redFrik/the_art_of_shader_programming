#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    v.y= iResolution.y-v.y;		//simple way to flip upsidedown (test with triangle mode)
    //v.y= v.y-(iResolution.y);	//uncomment this line to make it work with the sound and fft
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
