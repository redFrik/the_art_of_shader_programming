#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;

void main() {
    vec4 v= vec4(gl_Vertex);
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
