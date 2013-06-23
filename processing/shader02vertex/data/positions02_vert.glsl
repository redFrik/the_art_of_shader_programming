#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec4 v= vec4(gl_Vertex);
    mat4 m= mat4(
    	1.0, 0.0, 0.0, 0.0,
    	0.0, 1.0, 0.0, 0.0,
    	0.0, 0.0, 1.0, 0.0,
    	0.0, 0.0, 0.0, sin(iGlobalTime)+2.0
    );
    gl_Position= gl_ModelViewProjectionMatrix*v*m;
}
