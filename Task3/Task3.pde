import processing.video.*;

Capture cam;

void setup() {
  size(640, 480, FX2D);

  cam = new Capture(this, "pipeline:autovideosrc");
  cam.start();

  background(0);
}

void draw() {

  if (cam.available())
    cam.read();

  // image(cam, 0, 0);

  cam.filter(BLUR, 3);

  int maxX = 0;
  int maxY = 0;
  float maxBrightness = 0;

  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {

      color pixel = cam.get(x, y);
      float b = brightness(pixel);

      if (b > maxBrightness) {
        maxBrightness = b;
        maxX = x;
        maxY = y;
      }
    }
  }
if (maxBrightness >= 254) {
  fill(255);
  noStroke();
  circle(maxX, maxY, 10);
}
}
