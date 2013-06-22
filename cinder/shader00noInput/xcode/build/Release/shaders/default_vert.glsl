#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    //vec4 v= vec4(gl_Vertex);
	//v.x += iGlobalTime;
    //gl_Position= gl_ModelViewProjectionMatrix*v;
    gl_FrontColor = gl_Color;
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position= ftransform();
}
