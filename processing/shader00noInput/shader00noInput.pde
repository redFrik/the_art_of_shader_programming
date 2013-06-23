//--redFrik

//keys:
// i - info on/off
// f - load fragment shader
// m - switch drawing mode

//note: there need to be a folder called 'data' in this sketch folder
//it should include the file _default_frag.glsl

PShader mShader;
long mTimeFrag;
java.io.File mPathFrag;
boolean mHide;  //show/hide fps
int mMode;      //which shape

void setup() {
  size(640, 480, P3D);
  if(frame!=null) {
    frame.setResizable(true);
  }
  frameRate(60);
  noStroke();
  ellipseMode(CENTER);
  mHide= false;  //also keydown 'i'
  mMode= 0;
  mPathFrag= new java.io.File(dataPath("_default_frag.glsl"));
  mShader= loadShader(mPathFrag.getPath());   //only fragment
  mTimeFrag= mPathFrag.lastModified();
}

void fragLoader(File selection) {
  if(selection!=null) {
    mPathFrag= new java.io.File(selection.getAbsolutePath());
    mShader= loadShader(mPathFrag.getPath());   //only fragment
  }
}
void keyPressed() {
  if(key=='i') {
    mHide= !mHide;
  } else if(key=='f') {
    selectInput("Select a frag glsl file:", "fragLoader");
  } else if(key=='m') {
    mMode= (mMode+1)%5;
  }
}

void update() {
  if(mPathFrag.lastModified()>mTimeFrag) {  //hot-loading shader
    fragLoader(mPathFrag);
  }
}

void draw() {
  
  update();
  
  background(0);
  shader(mShader);
  mShader.set("iResolution", float(width), float(height));
  mShader.set("iGlobalTime", float(millis())*0.001);
  fill(255);
  switch(mMode) {
    case 0:
      rect(0, 0, width, height);
      break;
    case 1:
      rect(width*0.1, height*0.1, width*0.8, height*0.8);
      break;
    case 2:
      beginShape();
      vertex(width*0.5, height*0.125);
      vertex(width*0.125, height*0.875);
      vertex(width*0.875, height*0.875);
      endShape();
      break;
    case 3:
      ellipse(width*0.5, height*0.5, height*0.8, height*0.8);
      break;
    case 4:
      pushMatrix();
      translate(width*0.5, height*0.5);
      sphereDetail(6);
      sphere(height*0.4);
      popMatrix();
      break;
    }
  
  if(!mHide) {
    fill(255);
    textSize(12);
    text("mode (m): "+mMode, 30, height-60);
    text("frag (f): "+mPathFrag.getName(), 30, height-40);
    text("fps: "+frameRate, 30, height-20);
  }
}

