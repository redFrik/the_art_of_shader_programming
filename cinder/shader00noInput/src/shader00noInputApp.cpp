#include "cinder/app/AppNative.h"
#include "cinder/gl/gl.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class shader00noInputApp : public AppNative {
  public:
	void setup();
	void mouseDown( MouseEvent event );	
	void update();
	void draw();
};

void shader00noInputApp::setup()
{
}

void shader00noInputApp::mouseDown( MouseEvent event )
{
}

void shader00noInputApp::update()
{
}

void shader00noInputApp::draw()
{
	// clear out the window with black
	gl::clear( Color( 0, 0, 0 ) ); 
}

CINDER_APP_NATIVE( shader00noInputApp, RendererGl )
