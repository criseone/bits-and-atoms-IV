import gab.opencv.*;

OpenCV opencv;
PImage img;

int lowerb = 46;
int upperb = 59;

void setup() {
  size(640, 480);

  lowerb = round(map(lowerb, 0, 360, 0, 255));
  upperb = round(map(upperb, 0, 360, 0, 255));

  img = loadImage("apples.jpg");
  opencv = new OpenCV(this, img.width, img.height);
  opencv.useColor(HSB);
}

void draw() {
  background(0);

  opencv.loadImage(img);
  opencv.setGray(opencv.getH().clone());
  opencv.inRange(lowerb, upperb);

  blendMode(BLEND);
  image(img, 0, 0);

  strokeWeight(3);
  stroke(255, 0, 0);
  fill(255, 0, 0, 100);
  for (Contour contour : opencv.findContours()) {
    // filter by size
    if (contour.area() > 5000) {
      contour.draw();
    }
  }
}
