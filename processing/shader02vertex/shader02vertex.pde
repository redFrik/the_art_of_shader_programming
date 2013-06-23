//--redFrik

//keys:
// i - info on/off
// f - load fragment shader
// v - load vertex shader
// m - switch drawing mode

//note: there need to be a folder called 'data' in this sketch folder
//it should include the files _default_frag.glsl and _default_vert.glsl

import ddf.minim.analysis.*;
import ddf.minim.*;

PImage mTextureSnd;
PImage mTextureFft;
PShader mShader;
long mTimeFrag;
long mTimeVert;
java.io.File mPathFrag;
java.io.File mPathVert;
boolean mHide;  //show/hide fps
int mMode;      //which shape

Minim minim;
AudioInput mInput;
float[] mBufferLeft;
FFT mFftLeft;
int mBufferSize;
float mAmplitude;  //amptracker

void setup() {
  size(640, 480, P3D);
  if(frame!=null) {
    frame.setResizable(true);
  }
  frameRate(60);
  smooth(8);
  ellipseMode(CENTER);
  noStroke();
  
  //--defaults
  mHide= false;  //also keydown 'i'
  mMode= 0;
  mAmplitude= 0.0;
  
  //--audio
  minim= new Minim(this);
  mInput= minim.getLineIn();  //use default input device
  mBufferSize= mInput.bufferSize();
  println("mBufferSize: "+mBufferSize);
  mFftLeft= new FFT(mBufferSize, mInput.sampleRate());
  mBufferLeft= new float[mBufferSize];
  
  //--shader
  mPathFrag= new java.io.File(dataPath("_default_frag.glsl"));
  mPathVert= new java.io.File(dataPath("_default_vert.glsl"));
  shaderLoader();
  mTextureSnd= createImage(mBufferSize, 1, RGB);
  mTextureFft= createImage(mFftLeft.specSize()-1, 1, RGB);
  println("fftSize: "+mFftLeft.specSize());
}

void fragLoader(File selection) {
  if(selection!=null) {
    mPathFrag= new java.io.File(selection.getAbsolutePath());
    shaderLoader();
  }
}
void vertLoader(File selection) {
  if(selection!=null) {
    mPathVert= new java.io.File(selection.getAbsolutePath());
    shaderLoader();
  }
}
void shaderLoader() {
  mShader= loadShader(mPathFrag.getPath(), mPathVert.getPath());
  mTimeFrag= mPathFrag.lastModified();
  mTimeVert= mPathVert.lastModified();
}
void keyPressed() {
  if(key=='i') {
    mHide= !mHide;
  } else if(key=='f') {
    selectInput("Select a frag glsl file:", "fragLoader");
  } else if(key=='v') {
    selectInput("Select a vert glsl file:", "vertLoader");
  } else if(key=='m') {
    mMode= (mMode+1)%9;
  }
}

void update() {
  
  //--audio input
  mAmplitude= 0.0;
  mTextureSnd.loadPixels();
  for(int i= 0; i<mBufferSize; i++) {
    float sample= mInput.left.get(i);
    mBufferLeft[i]= sample;
    mAmplitude += abs(sample);
    mTextureSnd.pixels[i]= color(max(0.0, sample)*255.0); 
  }
  mTextureSnd.updatePixels();
  mAmplitude /= float(mBufferSize);  //average amplitude
  
  mFftLeft.forward(mInput.left);
  mTextureFft.loadPixels();
  for(int i= 0; i<(mFftLeft.specSize()-1); i++) {
    float sample= mFftLeft.getBand(i);
    mTextureFft.pixels[i]= color(min(255.0, sample*5.0));
  }
  mTextureFft.updatePixels();
  
  //--shaders
  if((mPathFrag.lastModified()>mTimeFrag) || (mPathVert.lastModified()>mTimeVert)) {  //hot-loading shader
    shaderLoader();
  }
}
void drawWaveform(boolean fill) {
  pushMatrix();
  translate(width*0.5, height*0.5);
  float a= height*0.25;              //wave amplitude
  for(int i= 0; i<mBufferSize; i++) {
    float x= (i/(float)(mBufferSize-1))*width-(width*0.5);
    float y= mBufferLeft[i]*a;
    rect(x, 0, 1, y);
    if(fill) {
      rect(x, 0, 1, 0.0-y);
    }
  }
  popMatrix();
}

void drawSpectrum(boolean fill) {
  pushMatrix();
  translate(width*0.5, height*0.5);
  float a= height*0.01;              //spectrum scale
  int fftSize= mFftLeft.specSize()-1;
  for(int i= 0; i<fftSize; i++) {
    float x= (i/(float)(fftSize-1))*width-(width*0.5);
    float y= mFftLeft.getBand(i)*a;
    rect(x, 0, 1, 0.0-y);
    if(fill) {
      rect(x, 0, 1, y);
    }
  }
  endShape();
  popMatrix();
}

void draw() {
  
  update();
  
  background(0);
  shader(mShader);
  mShader.set("iResolution", float(width), float(height));
  mShader.set("iGlobalTime", float(millis())*0.001);
  mShader.set("iAmplitude", mAmplitude);
  mShader.set("iChannel0", mTextureSnd);  //sound
  mShader.set("iChannel1", mTextureFft);  //fft
  
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
    case 5:
      drawWaveform(false);
      break;
    case 6:
      drawWaveform(true);
      break;
    case 7:
      drawSpectrum(false);
      break;
    case 8:
      drawSpectrum(true);
      break;
    }
  
  if(!mHide) {
    fill(255);
    textSize(12);
    text("mode (m): "+mMode, 30, height-80);
    text("frag (f): "+mPathFrag.getName(), 30, height-60);
    text("vert (v): "+mPathVert.getName(), 30, height-40);
    text("fps: "+frameRate, 30, height-20);
  }
}

