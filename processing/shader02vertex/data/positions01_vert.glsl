#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    v.x= v.x+(sin(iGlobalTime)*100.0);
    v.y= v.y+(cos(iGlobalTime)*100.0);	//move everything around in a circle
    gl_Position= gl_ModelViewProjectionMatrix*v;
}
