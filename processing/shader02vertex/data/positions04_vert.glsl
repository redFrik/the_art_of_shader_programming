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
    vec2 a= vec2(sin(iGlobalTime+(sin(iGlobalTime*10.1)*10.2))*10.3, sin(iGlobalTime*0.1)*sin(iGlobalTime*10.2));
    vec4 w= vec4(a.x, v.x/iResolution.x, abs(a.y-a.x)*0.5, v.y/iResolution.y);
    gl_Position= transform*v*w;
}
