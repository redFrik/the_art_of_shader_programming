the art of shader programming
=============================

_for the workshop 'the art of shader programming' at the eye for an ear festival berlin, jun2013_

here are instructions and examples for __both__ cinder and processing.  the main focus here will be to use cinder under osx, but if people have problems with xcode, windows and visual c++ or run linux, most of the things will also work with processing.

workshop plan
-------------

* install software (cinder / processing, soundflower / jack)
* quick cinder / processing overview (MyFirstApp / MyFirstSketch)
* introduction to shaders
* basic fragment shader example (shader00noInput)
* fragment shader with audio input (shader01audioInput)
* opengl shapes & basic vertex shader (shader02shapeVertex)
* redEye (<https://github.com/redFrik/redEye>)

the workshop material on this github page might be updated once in a while.  so it is worth checking back here a few days after the workshop.
<https://github.com/redFrik/the_art_of_shader_programming>


//--installing software
=======================

first we need to get the coding environments.  note: cinder doesn't have official support for linux, so if you're running linux install processing instead.
* (osx / win) download and install xcode (4.6.3) form <https://developer.apple.com/xcode/>
* (osx / win) download cinder (0.8.5) from <http://libcinder.org/download/>. you can put the cinder folder anywhere but i recommend in your home directory.
* (linux) download and install processing (2.0.1) from <http://processing.org/download/>

we also need to be able to route audio between applications (to cinder from puredata, supercollider etc.).  so if you're on osx, install soundflower.  windows and linux users should install jack.
* (osx) download and install soundflower (1.6.6b) from <http://code.google.com/p/soundflower/>
* (win / linux) install jack from <http://jackaudio.org/download>. see also <http://jackaudio.org/jack_on_windows>

last we need a plain text editor for editing the glsl shader files.  anything will do (textedit, notepad, pico, sc) but i'll use TextWrangler available for free from here <http://www.barebones.com/products/textwrangler/download.html>.

//--quick cinder/processing overview
====================================

cinder <http://libcinder.org> is a c++ framework / library.  the standard usage is to use it for coding graphics in opengl (3d) or cairo (2d).  basically cinder do all the boring tasks for you like setting up a window, refreshing the window, build a nice standalone application etc.  it also simplifies many things like mouse interaction, window resizing and cross platform builds as well as include libraries for audio, osc and opencv.
here we will first create a simple application from scratch (instructions for xcode).

first cinder application
------------------------
* find and open the TinderBox application under cinder / tools.
* give your project a name (MyFirstApp) and select where to save it.
* optionally deselect 'create local git repository'. (no need to set up a git repro for this test).
* click next and finish. (no need to add any libraries for this test).
* find the project and open the xcode / MyFirstApp.xcodeproj in xcode.
* expand the menu at the left hand side and select MyFirstAppApp.cpp.
* add one line of code `gl::drawSphere(Vec3f(400.0f, 300.0f, 0.0f), sin(getElapsedSeconds())*100.0f);` like in the screenshot below and click run (cmd+r).  you should see your application starting with a back window and a white pulsating blob.

![firstApp](https://raw.github.com/redFrik/the_art_of_shader_programming/master/cinder/firstApp.png)

* now look in the folder xcode / build / debug and you'll find your standalone application.
* go back to xcode and select 'edit scheme' under menu product / scheme (or press cmd+<).  change from debug to release in the build configuration pop-up menu.  click ok to confirm.  now the next time we build and run, the application will be built in release mode.  that means it will run faster and take up less space.
* add some more lines like in this second screenshot.  hit run and you should see four pulsating red circles with varying number of segments.

![firstApp2](https://raw.github.com/redFrik/the_art_of_shader_programming/master/cinder/firstApp2.png)

* now your standalone application will be found in the folder xcode / build / release.

first processing sketch
-----------------------
* start processing and create a new sketch (cmd+n).
* save it somewhere and give it a name (MyFirstSketch).
* type in the code below and click run (cmd+r).  you should see your java application starting with a back window and a white pulsating blob.

![firstSketch](https://raw.github.com/redFrik/the_art_of_shader_programming/master/processing/firstSketch.png)

* change the code to the following, click run and you should see four pulsating red circles with varying number of segments.

![firstSketch2](https://raw.github.com/redFrik/the_art_of_shader_programming/master/processing/firstSketch2.png)


//--introduction to shaders
===========================

shaders are programs that run on the graphic card (GPU).  they are quite limited but can run in parallel.
<http://en.wikipedia.org/wiki/Shader>

there exist a few different languages for writing shaders.
* glsl (opengl)
* hlsl (directx)
* cg (nivida's opengl+directx)

here will will use glsl.  the glsl language come in different versions.  version 1.2 is the most general and compatible, while the newer version 1.3 is slowly taking over.  here we will use 1.2, but if your graphics card support 1.3 you might want to learn this instead.

* `vertex shader` - runs once for each vertex in the shape. good for changing the position and colour of individual vertices.
* `geometry shader` - also runs once for each vertex in the shape but can add new vertices.  will will not do any geometry shaders here (they are still rare).
* `fragment shader` (aka pixel shader) - runs once for each pixel in the texture. i.e. once per frame this is run on each pixel.

* `uniform` means that it's the same for all fragments.
* `attribute` - unique for each call (colour, position, normal), the are read only and only applies for vertex shaders
* `varying` - variables shared between vertex and fragment shader programs.  note that they interpolate.

* `gl_FragColor`
* `gl_Position`
etc.

//--basic fragment shader example
=================================
fragment shader are the easiest to get started with.  here's the first example using shaders.  the opengl part in cinder is very simple.  it just..



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


#version 120

uniform vec2 iResolution;
uniform float iGlobalTime;

void main() {
	vec2 v= gl_FragCoord.xy-(iResolution/2.0);
    float a= 1.0-(abs(length(v))/(iResolution.x/2.0));
    a= clamp(a, 0.0, 1.0);
    gl_FragColor= vec4(a*abs(sin(v.x/20.0)), 0, 0, 1.0);
}


now look at the files 
00.		no input
		play with fragment shader only
		--iGlobalTime, iResolution

//--fragment shader with audio input
====================================

01.		audio input (mic+soundfile)
		--iAmplitude, iSample (iNumSamples?)


//--opengl shapes & basic vertex shader
=========================================


//--redEye
==========

<https://github.com/redFrik/redEye>


troubleshooting
===============
the first thing to check if something doesn't compile is that the cinder path is correct. find 'build settings' and scroll to the bottom.  `CINDER_PATH` must point to your cinder_0.8.5_mac folder.

if problems compiling or linking you should make sure the following (also under 'build settings')...
1. Base SDK - Latest OSX
2. C++ Language Dialect -> C++ 11 [-std=c++11]
3. C++ Standard Library -> libc++ (LLVM C++ standard library with C++11 support)


resources
=========

//--cinder
* <http://libcinder.org/docs/>
* <http://forum.libcinder.org/#Forum/using-cinder>
* <http://www.creativeapplications.net/tutorials/shaders-geometry-and-the-kinect-part-1-cinder-tutorials/>
* <http://www.creativeapplications.net/tutorials/guide-to-meshes-in-cinder-cinder-tutorials/>
* <http://robbietilton.com/blog/?p=1475>
* <http://cindering.org>

//--processing
* <http://www.creativeapplications.net/processing/playing-with-glsl-in-processing-initial-experiments-tutorials/>
* <http://www.creativeapplications.net/processing/geometry-textures-shaders-processing-tutorial/>
* <http://processing.org/tutorials/pshader/>
* <http://thndl.com>
* <http://atduskgreg.github.io/Processing-Shader-Examples/>

//--chrome or firefox
* <http://glsl.heroku.com/>
* <https://www.shadertoy.com>

//--general glsl tutorial
* <http://nehe.gamedev.net/article/glsl_an_introduction/25007/>
* <http://www.lighthouse3d.com/tutorials/glsl-tutorial/>
