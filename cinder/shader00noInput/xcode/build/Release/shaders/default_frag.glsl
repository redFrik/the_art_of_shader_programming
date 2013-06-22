#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
    vec2 v= gl_FragCoord.xy-(iResolution/2.0);
    float a= 1.0-(abs(length(v))/(iResolution.x/2.0));
    a= clamp(a, 0.0, 1.0);
    gl_FragColor= vec4(a*abs(sin(v.x/20.0)), 0, 0, 1.0);
}
