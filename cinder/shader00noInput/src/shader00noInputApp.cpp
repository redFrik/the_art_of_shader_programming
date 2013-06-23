//--redFrik

//keys:
// i - info on/off
// esc - fullscreen on/off
// f - load fragment shader
// m - switch drawing mode

//note: there need to be a folder called 'data' in the same folder as this application
//it should include the file _default_frag.glsl

#include "cinder/app/AppNative.h"
#include "cinder/gl/gl.h"
#include "cinder/Utilities.h"
#include "cinder/Filesystem.h"
#include "cinder/gl/GlslProg.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class shader00noInputApp : public AppNative {
  public:
	void setup();
	void update();
	void draw();
    void keyDown(KeyEvent event);
    void loadShader();
    
    gl::GlslProgRef         mShader;
    std::time_t             mTimeFrag;
    fs::path                mPathFrag;
    bool                    mHide;          //show/hide error and fps
    std::string             mError;
    int                     mMode;          //which shape
};

void shader00noInputApp::setup() {
    
    //--defaults
    mHide= false;   //also keydown 'i'
    mError= "";
    mMode= 0;
    
    //--shader
    mPathFrag= getPathDirectory(app::getAppPath().string())+"data/_default_frag.glsl";
    loadShader();
}

void shader00noInputApp::keyDown(ci::app::KeyEvent event) {
	if(event.getChar()=='i') {
        mHide= !mHide;
    } else if(event.getCode()==KeyEvent::KEY_ESCAPE) {
        setFullScreen(!isFullScreen());
    } else if(event.getChar()=='f') {
        fs::path path= getOpenFilePath(mPathFrag);
        if(!path.empty()) {
			mPathFrag= path;
            loadShader();
		}
    } else if(event.getChar()=='m') {
        mMode= (mMode+1)%5;
    }
}
void shader00noInputApp::loadShader() {
    mError= "";
    try {
        mTimeFrag= fs::last_write_time(mPathFrag);
        mShader= gl::GlslProg::create(NULL, loadFile(mPathFrag), NULL);   //only fragment
    }
    catch(gl::GlslProgCompileExc &exc) {
        mError= exc.what();
    }
    catch(...) {
        mError= "Unable to load shader";
    }
}

void shader00noInputApp::update() {
    if(fs::last_write_time(mPathFrag)>mTimeFrag) {
        loadShader();   //hot-loading shader
    }
}

void shader00noInputApp::draw() {
	gl::clear(Color(0, 0, 0));
    
    mShader->bind();
    mShader->uniform("iResolution", (Vec2f)getWindowSize());
    mShader->uniform("iGlobalTime", (float)getElapsedSeconds());
    gl::color(1.0f, 1.0f, 1.0f);
    switch(mMode) {
        case 0:
            gl::drawSolidRect(Rectf(getWindowBounds()));
            break;
        case 1:
            gl::drawSolidRect(Rectf(getWindowBounds()).scaledCentered(0.8f));
            break;
        case 2:
            gl::drawSolidTriangle(
                                  Vec2f(getWindowCenter()*Vec2f(1.0f, 0.25f)),
                                  Vec2f(getWindowCenter()*Vec2f(0.25f, 1.75f)),
                                  Vec2f(getWindowCenter()*Vec2f(1.75f, 1.75f)));
            break;
        case 3:
            gl::drawSolidCircle(getWindowCenter(), getWindowHeight()*0.4f, 100);
            break;
        case 4:
            gl::drawSphere((Vec3f)getWindowCenter(), getWindowHeight()*0.4f, 12);
            break;
    }
    mShader->unbind();
    
    if(!mHide) {
        Color col= Color(1, 1, 1);
        Font fnt= Font("Verdana", 12);
        gl::drawString("mode (m): "+toString(mMode), Vec2f(30.0f, getWindowHeight()-80.0f), col, fnt);
        gl::drawString("frag (f): "+toString(mPathFrag.filename()), Vec2f(30.0f, getWindowHeight()-60.0f), col, fnt);
        gl::drawString("error: "+mError, Vec2f(30.0f, getWindowHeight()-40.0f), col, fnt);
        gl::drawString("fps: "+toString(getAverageFps()), Vec2f(30.0f, getWindowHeight()-20.0f), col, fnt);
    }
}

CINDER_APP_NATIVE(shader00noInputApp, RendererGl)
