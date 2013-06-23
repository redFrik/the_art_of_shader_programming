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
    v.xy= v.xy-mod(v.xy, iAmplitude*100.0);
    vec2 attractor= vec2(sin(iGlobalTime), cos(iGlobalTime))*0.5*iResolution;
    v.xy= v.xy*(length(v.xy-attractor)*0.01);
    gl_Position= transform*v;
}
