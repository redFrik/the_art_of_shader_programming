#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= v.x+(sin(iGlobalTime)*100.0f);
    v.y= v.y+(cos(iGlobalTime)*100.0f);	//move everything around in a circle
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
