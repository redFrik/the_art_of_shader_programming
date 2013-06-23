#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    v.xy= v.xy-mod(v.xy, 10.0);
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
