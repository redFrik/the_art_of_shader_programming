#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    float a= length(v.xy/iResolution)*iAmplitude*2.0;
    v.x= v.x*a;
    v.y= v.y*a;
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
