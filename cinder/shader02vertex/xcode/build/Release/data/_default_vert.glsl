#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    gl_Position= gl_ModelViewProjectionMatrix*v;	//same as gl_Position= ftransform();
}
