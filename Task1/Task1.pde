
PImage img;

void setup() {
  size(640, 896, FX2D);

  img = loadImage("moon.jpg");
  noLoop();
}

void draw() {
  background(0);

  image(img, 0, 0);

  int maxX = 0;
  int maxY = 0;
  float maxBrightness = 0;

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {

      color pixel = img.get(x, y);
      float b = brightness(pixel);

        if (b > maxBrightness) {
        maxBrightness = b;
        maxX = x;
        maxY = y;
      }
    }
  }

  stroke(255, 0, 255);
  noFill();
  circle(maxX, maxY, 50);
}
