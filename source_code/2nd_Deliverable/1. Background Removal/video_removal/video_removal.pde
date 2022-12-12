import processing.video.*;

Capture video;

PImage backgroundImage;
Movie backgroundReplace;


float threshold = 20;

void setup() {
  size(480, 360);
  video = new Capture(this, 480, 360, "pipeline:autovideosrc");
  video.start();


  backgroundImage = createImage(video.width, video.height, RGB);
  backgroundReplace = new Movie(this, "countdown.mp4");
  backgroundReplace.loop();
}

void captureEvent(Capture video) {
  video.read();
}

void movieEvent(Movie backgroundReplace) {
  backgroundReplace.read();
}

void draw() {
  threshold = map(mouseX, 0, width, 5, 50);

  image(backgroundReplace, 0, 0, width, height);

  loadPixels();
  video.loadPixels(); 
  backgroundReplace.loadPixels();


  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      color fgColor = video.pixels[loc];


      color bgColor = backgroundImage.pixels[loc];


      float r1 = red(fgColor);
      float b1 = blue(fgColor);
      float g1 = green(fgColor);
      float r2 = red(bgColor);
      float b2 = blue(bgColor);
      float g2 = green(bgColor);
      float diff = dist(r1, b1, g1, r2, b2, g2);


      if (diff > threshold) {
        pixels[loc] = fgColor;
      } 
      else {
        pixels[loc] = backgroundReplace.pixels[loc];
      }
    }
  }
  updatePixels();
}

void mousePressed() {

  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}
