// Spiral code adapted from: https://forum.processing.org/two/discussion/13125/for-loop-to-make-a-spiral.html. Creator: benja - october 2025
boolean showSpiral;
float angle = 0.2;
float scaleFactor = 1;
int i = 0;
int repetitions = 500;
color colorValue;
PGraphics LayerSpiral;

void setupSpiral() {
  LayerSpiral = createGraphics(width, height);
  showSpiral = false;
  colorValue = color(random(255), random(255), random(255));
}


void drawSpiral() {
  LayerSpiral.beginDraw();
  LayerSpiral.pushMatrix();
  LayerSpiral.translate(width / 2, height / 2);
  LayerSpiral.rotate(angle);
  LayerSpiral.scale(scaleFactor);
  LayerSpiral.stroke(colorValue);
  LayerSpiral.strokeWeight(0.1);
  LayerSpiral.line(10, -15, 10, 15);

  angle += 0.1;
  scaleFactor *= 1.01;
  i++;

  if (i > repetitions) {
    angle = 0;
    scaleFactor = 1;
    i = 0;
    colorValue = LayerSpiral.color(random(255), random(255), random(255));
  }

  LayerSpiral.popMatrix();
  LayerSpiral.endDraw();

  image(LayerSpiral, 0, 0);
}
