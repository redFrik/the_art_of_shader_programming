the art of shader programming
=============================

_workshop 'the art of shader programming' at the eye for an ear festival berlin_

here are instructions and examples for __both__ cinder and processing.  the main focus for the workshop will be to use cinder, but if people have problems with xcode, visual c++ or run linux, most of the things we will try also works with processing.

//--workshop plan
-----------------

* installing software
* quick overview of cinder/processing
* basic fragment shader example (shader00noInput)
* fragment shader with audio input (shader01audioInput)
* opengl shapes and basic vertex shader (shader02shapeVertex)
* redEye

the code on the github pages might be updated once in a while.
<https://github.com/redFrik/the_art_of_shader_programming>
<https://github.com/redFrik/redEye>

installing software
===================

first we need to get the coding environments.  note that cinder doesn't have official support for linux, so if you're running linux install processing instead.
* (osx/win) download and install xcode (4.6.3) form <https://developer.apple.com/xcode/>
* (osx/win) download cinder (0.8.5) from <http://libcinder.org/download/>. put the folder anywhere.
* (linux) download and install processing (2.0.1) from <http://processing.org/download/>

we'll also need to be able to route audio between applications (to cinder from puredata, supercollider etc.).  so if you're on osx, install soundflower and for windows and linux jack.
* (osx) download and install soundflower (1.6.6b) from <http://code.google.com/p/soundflower/>
* (win/linux) install jack <http://jackaudio.org/download> <http://jackaudio.org/jack_on_windows>

quick overview of cinder/processing
===================================

cinder is a c++ framework/library.  it makes many things a lot easier.

//--first cinder application
----------------------------
* find and open the TinderBox application under cinder/tools.
* give your project a name (MyFirstApp) and select where to save it.
* deselect 'create local git repository' for now
* click next and finish
* find the project and open the xcode/MyFirstApp.xcodeproj in xcode
* expand the tree at the left hand side and select MyFirstAppApp.cpp
* add one line of code `gl::drawSphere(Vec3f(400.0f, 300.0f, 0.0f), sin(getElapsedSeconds())*100.0f);` like in the screenshot below and hit cmd+r to run.  you should see your application starting with a back window and a while pulsating blob.

![firstApp](https://raw.github.com/redFrik/the_art_of_shader_programming/master/cinder/firstApp.png)

* now look in the folder xcode/build/debug and you'll find your application.
* go back to xcode and select 'edit scheme' under menu product/scheme (or press cmd+<).  change from debug to release in the build configuration popup.
* add some more lines like in this second screenshot.  hit run and you should see four pulsating red circles with varying number of segments.

![firstApp2](https://raw.github.com/redFrik/the_art_of_shader_programming/master/cinder/firstApp2.png)
