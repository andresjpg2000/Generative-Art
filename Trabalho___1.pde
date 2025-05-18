import processing.sound.*;

color c1, c2, c3;
int numerDeLinhas, numeroDeRetangulos;
PShape nota;

boolean showTR1;

PGraphics TR1Layer;


void setupTR1() {
  TR1Layer = createGraphics(width, height);
  TR1Layer.beginDraw();
  TR1Layer.background(0, 255, 255, 0);

  rectMode(CENTER);

  

  // Cores
  c1 = color(64, 0, 32);
  c2 = color(255, 255, 0);

  numerDeLinhas = 10;
  numeroDeRetangulos = 10;
  rotacao = 0;
  raioInterior = 270;
  espacoEntreRetangulos = 300;
  nota = loadShape("nota.svg");
  TR1Layer.endDraw();

  showTR1 = false;
}

void drawTR1() {
  TR1Layer.beginDraw();
  TR1Layer.background(0, 255, 255, 0);
  TR1Layer.noStroke();
  TR1Layer.endDraw();

  // Controle com som
  rotacao = rotacao - smoothedIntensity * 10;
  raioInterior = map(smoothedIntensity, 0, 1, 0, 270);
  espacoEntreRetangulos = map(smoothedIntensity, 0, 1, 0, 300);

  if (keyPressed == true) {
    if (keyCode == UP) numerDeLinhas = numerDeLinhas + 1;
    if (keyCode == DOWN) numerDeLinhas = numerDeLinhas - 1;
    numerDeLinhas = constrain(numerDeLinhas, 1, 10);

    if (keyCode == RIGHT) numeroDeRetangulos = numeroDeRetangulos + 1;
    if (keyCode == LEFT) numeroDeRetangulos = numeroDeRetangulos - 1;
    numeroDeRetangulos = constrain(numeroDeRetangulos, 1, 10);
  }

  anguloEntreLinhas = 360.0 / numerDeLinhas;

  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(rotacao));

  for (int a = 0; a < numerDeLinhas; a++) {
    rotate(radians(anguloEntreLinhas));
    pushMatrix();
    translate(raioInterior, 0);

    for (int i = 0; i < numeroDeRetangulos; i++) {
      pushMatrix();
      scale(0.1 + map(i, 0, numeroDeRetangulos, 0.0, 0.8));
      scale(0.05 + smoothedIntensity * 0.5);
      rotate(radians(90));

      c3 = lerpColor(c1, c2, map(i, 0, numeroDeRetangulos, 0.0, 1.0));
      TR1Layer.fill(c3, 192);
      TR1Layer.noStroke();
      shape(nota, 0, 0);

      popMatrix();
      translate(espacoEntreRetangulos, 0);
    }
    popMatrix();
  }
  popMatrix();
  TR1Layer.endDraw();

  image(TR1Layer, 0, 0);
}
