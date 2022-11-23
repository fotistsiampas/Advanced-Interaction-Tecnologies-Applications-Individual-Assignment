import processing.video.*;

Capture video;

PImage backgroundImage;
PImage backgroundReplace;


float threshold = 30;

void setup() {
  size(300, 200);
  video = new Capture(this, width, height, 30);
  video.start();


  backgroundImage = createImage(video.width, video.height, RGB);
  backgroundReplace = loadImage("tokyo.jpg");
}

void captureEvent(Capture video) {
  video.read();
}


void draw() {

  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();


  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      color fgColor = video.pixels[loc];


      color bgColor = backgroundImage.pixels[loc];


      float r1 = red(fgColor);
      float r2 = blue(fgColor);
      float r3 = green(fgColor);
      float g3 = green(bgColor);
      float diff = dist(r1, r2, r3, g3);


      if (diff > threshold) {

          pixels[loc] = fgColor;
      } else {

       pixels[loc] = backgroundReplace.pixels[loc];
      }
    }
  }
  updatePixels();
}
