//--redFrik

//keys:
// i - info on/off
// f - load fragment shader
// m - switch drawing mode

//note: there needs to be a folder called 'data' in this sketch folder
//it should include the file _default_frag.glsl

PShader mShader;
long mTimeFrag;
String mPathFrag;
boolean mHide;
int mMode;

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
  java.io.File path= new java.io.File(dataPath("_default_frag.glsl"));
  mPathFrag= path.getPath();
  mShader= loadShader(mPathFrag);
  mTimeFrag= path.lastModified();
}

void fragLoader(File selection) {
  if(selection!=null) {
    mPathFrag= selection.getAbsolutePath();
    mShader= loadShader(mPathFrag);
  }
}
void keyPressed() {
  if(key=='i') {
    mHide= !mHide;
  } else if(key=='f') {
    selectInput("Select a frag glsl file:", "fragLoader");
  } else if(key=='m') {
    mMode= (mMode+1)%4;
  }
}
void update() {
  java.io.File path= new java.io.File(mPathFrag);
  if(path.lastModified()>mTimeFrag) {  //hot-loading shader
    mShader= loadShader(mPathFrag);
    mTimeFrag= path.lastModified();
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
      rect(width*0.1, height*0.1, width*0.8, height*0.8);
      break;
    case 1:
      beginShape();
      vertex(width*0.5, height*0.125);
      vertex(width*0.125, height*0.875);
      vertex(width*0.875, height*0.875);
      endShape();
      break;
    case 2:
      ellipse(width*0.5, height*0.5, height*0.8, height*0.8);
      break;
    case 3:
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
    text("frag (f): "+mPathFrag, 30, height-40);
    text("fps: "+frameRate, 30, height-20);
  }
}

