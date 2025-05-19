//Rainbow line code from: https://discourse.processing.org/t/rainbow-line-running-through-colors/4777 - adapted for shades of blue only
boolean showCube;
int h = 0;
PGraphics LayerCube;

void setupCube() {
  LayerCube = createGraphics(width, height, P3D);
  showCube = false;
}

void drawCube() {
  LayerCube.beginDraw();
  LayerCube.colorMode(HSB, 360, 360, 360);
  LayerCube.background(0, 0); // transparent background

  if (h > 360) h = 0;
  h += 2;

  float blueHue = 220;
  float brightness = map(sin(radians(h)), -1, 1, 100, 360);

  LayerCube.pushMatrix();
  LayerCube.translate(width * 0.75, height / 2, 0); // move to right side
  LayerCube.rotateY(radians(h));
  LayerCube.rotateX(radians(h * 1.5));
  LayerCube.fill(blueHue, 360, brightness);
  LayerCube.noStroke();
  LayerCube.box(150);
  LayerCube.popMatrix();

  LayerCube.colorMode(RGB);
  LayerCube.endDraw();

  image(LayerCube, 0, 0);
}

class RotatingCube {
  PVector position;
  color cubeColor;
  float size;
  float rotationOffset;

  RotatingCube(PVector position, color cubeColor, float size, float rotationOffset) {
    this.position = position.copy();
    this.cubeColor = cubeColor;
    this.size = size;
    this.rotationOffset = rotationOffset;
  }

  void update(float velZ) {
    position.z += velZ;
  }

  void render(PGraphics pg, int frameOffset) {
    float rot = radians(frameCount + frameOffset + rotationOffset);

    pg.pushMatrix();
    pg.translate(position.x, position.y, position.z);
    pg.rotateY(rot);
    pg.rotateX(rot * 1.5);
    pg.fill(cubeColor);
    pg.noStroke();
    pg.box(size);
    pg.popMatrix();
  }
}
