#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= v.x+300.0f;	//offset everything to the right
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
