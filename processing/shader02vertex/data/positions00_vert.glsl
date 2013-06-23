#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= v.x+300.0;	//offset everything to the right
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
