/**
 * NyARToolkit for proce55ing/3.0.5
 * (c)2008-2017 nyatla
 * airmail(at)ebony.plala.or.jp
 * 
 * This sketch is shortest sample.
 * The sketch shows cube on the marker of "patt.hiro".
 * Any pattern and configuration files are found in libraries/nyar4psg/data inside your sketchbook folder. 
*/
import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;
PImage img;

void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this,640,480);
  nya=new MultiMarker(this,width,height,"../augmented_reality/data/camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("../augmented_reality/data/patt.hiro",80);
  cam.start();
   img = loadImage("strawberry.jpg");
}

void draw()
{
  if (cam.available() !=true) {
      return;
  }
  cam.read();
  nya.detect(cam);
  //background(0);
  nya.drawBackground(cam);
  if((!nya.isExist(0))){
    return;
  }
  nya.beginTransform(0);
  fill(0,0,255);
  //translate(0,0,20);
   image(img, 0, 0);
  nya.endTransform();
}
