import processing.video.*;

Capture video;
PImage prevFrame;

float threshold = 80;

void setup() {
  size(640, 426);
  video = new Capture(this, 640, 426);
  video.start();

  prevFrame = createImage(video.width, video.height, RGB);
}

void captureEvent(Capture video) {
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  prevFrame.updatePixels();  
  video.read();
}


void draw() {
  background(0);

  image(video, 0, 0);


  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  float sumX = 0;
  float sumY = 0;
  int motionCount = 0; 

  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      color current = video.pixels[x+y*video.width];

      color previous = prevFrame.pixels[x+y*video.width];

      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);

      float diff = dist(r1, g1, b1, r2, g2, b2);

      if (diff > threshold) {
        sumX += x;
        sumY += y;
        motionCount++;
      }
    }
  }

  float avgX = sumX / motionCount; 
  float avgY = sumY / motionCount; 

star(avgX, avgY, 30, 70, 5);
fill (200, 100, 0);

}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
