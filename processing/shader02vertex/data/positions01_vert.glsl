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
    v.x= v.x+(sin(iGlobalTime)*100.0);
    v.y= v.y+(cos(iGlobalTime)*100.0);	//move everything around in a circle
    gl_Position= transform*v;
}
