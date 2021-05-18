import ch.bildspur.vision.*;
import ch.bildspur.vision.result.*;

import processing.video.Capture;

Capture cam;

DeepVision vision = new DeepVision(this);
SSDMobileNetwork network;
ResultList<ObjectDetectionResult> detections;

public void setup() {
  size(1280, 720, FX2D);
  colorMode(HSB, 360, 100, 100);

  println("creating network...");
  network = vision.createHandDetector();

  println("loading model...");
  network.setup();
  network.setConfidenceThreshold(0.5);

  println("setup camera...");
  cam = new Capture(this, 1280, 720, "pipeline:autovideosrc");
  cam.start();
}

public void draw() {
  background(55);

  if (cam.available()) {
    cam.read();
  }

  image(cam, 0, 0);

  if (cam.width == 0) {
    return;
  }

  detections = network.run(cam);

  noFill();
  strokeWeight(2f);

  stroke(200, 80, 100);
  for (ObjectDetectionResult detection : detections) {
    println(detection.getX()," ",detection.getY()," ",detection.getWidth());
    if (detection.getX() > 300 && detection.getX() < 600) {
      fill(254, 204, 0);
      textSize(70);
      text("NOT SURE IF UNDERSTAND", 100, 100, 10);
    }
        if (detection.getY() < 200) {
      textSize(100);
      text("I DON'T KNOW!", 100, 100, 10);
      fill(254, 204, 0);
    }
        if (detection.getX() > 800 & detection.getWidth() < 300) {
      textSize(100);
      text("THINKING...", 100, 100, 10);
      fill(254, 204, 100);
    }
  }

  surface.setTitle("Hand Detection Test - FPS: " + Math.round(frameRate));
  
  pushMatrix();
  scale(-1,1);
  popMatrix();
}
