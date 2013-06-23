#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    v.xy= v.xy-mod(v.xy, iAmplitude*100.0);
    vec2 attractor= vec2(sin(iGlobalTime), cos(iGlobalTime))*0.5*iResolution;
    v.xy= v.xy*(length(v.xy-attractor)*0.005);
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
