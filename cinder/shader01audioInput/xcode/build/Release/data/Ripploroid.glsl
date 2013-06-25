#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform vec2 iMouse;
uniform float iAmplitude;
uniform sampler2D iChannel0;	//sound
uniform sampler2D iChannel1;	//fft

float dist(vec2 p1, vec2 p2) {
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	return sqrt(dx * dx + dy * dy);	
}

float getSin(float seed, float a, float f, float t) {
	return a*sin(seed * f + t);
}

float getCos(float seed, float a, float f, float t) {
	return a*cos(seed * f + t);
}


void main(void)
{
	vec2 uv = gl_FragCoord.xy / iResolution.xy;
	float t = iGlobalTime;
	vec2 mid = vec2(0.5,0.5);
	vec2 ripMid = vec2(iMouse.xy / iResolution.xy);

	float mod1 = sin(t*2.0);
	float mod2 = cos(t*(0.5+(sin(uv.x*0.015))));
	float b1 = (getSin((uv.x+mod2)+cos(uv.y)*15.0,1.0,1.0,t) + getCos(dist(uv,ripMid)*10.0,0.25,2.0,t)); 
	float b2 = (getSin(uv.y*mod2*10.0,0.75+mod1,0.25,t) + getCos(dist(uv,ripMid)*10.0,0.25,2.0,t)); 
	float avg = (b1 + b2) / 2.0;
	
	float r = t * 0.5;
	mat2 mt = mat2(cos(r), -sin(r), sin(r), cos(r));
	uv = uv * mt;

	vec4 c = texture2D(iChannel0,vec2(uv.x+avg, uv.y + avg));
	c.rgb += clamp(avg,0.0,0.6);

	gl_FragColor = c;
}