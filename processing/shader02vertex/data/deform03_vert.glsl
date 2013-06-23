#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

uniform mat4 transform;
attribute vec4 vertex;

void main() {
    vec4 v= vec4(vertex);
    v.x= (sin(v.x*0.15+iGlobalTime)*0.5)*iResolution.x;
	v.y= (cos(v.y*0.15+iGlobalTime)*0.5)*iResolution.y;
    gl_Position= transform*v;
}
