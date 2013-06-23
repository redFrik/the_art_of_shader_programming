#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= (sin(v.x*0.15+iGlobalTime)*0.5)*iResolution.x;
	v.y= (cos(v.y*0.15+iGlobalTime)*0.5)*iResolution.y;
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
