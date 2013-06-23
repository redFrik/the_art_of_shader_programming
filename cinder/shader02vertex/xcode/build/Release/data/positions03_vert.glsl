#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

void main() {
    vec4 v= vec4(gl_Vertex);
    mat4 m= mat4(
    	cos(iGlobalTime*0.1), sin(iGlobalTime*0.2), 0.0, 0.0,
    	sin(iGlobalTime*sin(iGlobalTime*0.1)*0.1), 1.0, sin(iGlobalTime*0.3), 0.0,
    	sin(iGlobalTime*0.4), 0.0, 1.0, 0.1,
    	0.0, 0.0, 0.0, sin(iGlobalTime)+2.0
    );
    gl_Position= gl_ModelViewProjectionMatrix*v*m;
}
