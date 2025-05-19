//Rainbow line code from: https://discourse.processing.org/t/rainbow-line-running-through-colors/4777 - adapted for shades of blue only

////////////////////////////////////////////////////////////////////////////////////
//Cubo individual com colisões
boolean showCube;
int h = 0;
PGraphics LayerCube;

// Movimento do cubo
float cubeX, cubeY;
float cubeVX, cubeVY;
float cubeSize = 150;

void setupCube() {
  LayerCube = createGraphics(width, height, P3D);
  showCube = false;

  //Posição inicial
  cubeX = width * 0.75;
  cubeY = height / 2;
  cubeVX = 15; // Velocidade no eixo X
  cubeVY = 15; // Velocidade no eixo Y
}

void drawCube() {
  // Mudar cor
  if (h > 360) h = 0;
  h += 2;

  // Atualizar posição
  cubeX += cubeVX;
  cubeY += cubeVY;

  // Colisões
  float halfSize = cubeSize / 2;
  if (cubeX + halfSize > width) {
    cubeX = width - halfSize;
    cubeVX *= -1;
  } else if (cubeX - halfSize < 0) {
    cubeX = halfSize;
    cubeVX *= -1;
  }
  if (cubeY + halfSize > height) {
    cubeY = height - halfSize;
    cubeVY *= -1;
  } else if (cubeY - halfSize < 0) {
    cubeY = halfSize;
    cubeVY *= -1;
  }

  // Adicionar à layer
  LayerCube.beginDraw();
  LayerCube.colorMode(HSB, 360, 360, 360);
  LayerCube.background(0, 0); 

  float blueHue = 220;
  float brightness = map(sin(radians(h)), -1, 1, 100, 360);

  LayerCube.pushMatrix();
  LayerCube.translate(cubeX, cubeY, 0); // atualizar posição
  LayerCube.rotateY(radians(h));
  LayerCube.rotateX(radians(h * 1.5));
  LayerCube.fill(blueHue, 360, brightness);
  LayerCube.noStroke();
  LayerCube.box(cubeSize);
  LayerCube.popMatrix();

  LayerCube.colorMode(RGB);
  LayerCube.endDraw();

  image(LayerCube, 0, 0);
}

////////////////////////////////////////////////////////////////////////////////////
// Classe do cubo, usado no TR3

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
