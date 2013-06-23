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
    float a= length(v.xy/iResolution)*iAmplitude*2.0;
    v.x= v.x*a;
    v.y= v.y*a;
    gl_Position= transform*v;
}
