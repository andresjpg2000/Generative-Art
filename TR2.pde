// File: SunRaysSoundReactive.pde
float[] intensidades;
float suavizacao = 0.3;

int numeroLinhas;
float anguloEntreLinha2, rotAtual, rotVel;

boolean ativo_agora = false;
boolean ativo_antes = false;
float diametro = 30;
int bandas = 64;

ArrayList<PVector> solCentros;

boolean showTR2;

PGraphics TR2Layer;

void setupTR2() {
  TR2Layer = createGraphics(width, height, P3D);
  TR2Layer.beginDraw();
  TR2Layer.stroke(25, 70, 210);
  TR2Layer.strokeWeight(4.0);
  TR2Layer.endDraw();


  limiar = 0.05;
  rotAtual = 0.0;
  rotVel = 1.5;
  intensidades = new float[bandas];

  showTR2 = false;

  solCentros = new ArrayList<PVector>();
  solCentros.add(new PVector(width/2, height/2));
}

void drawTR2() {
  TR2Layer.beginDraw();

  TR2Layer.background(194, 200, 210);


  

  rotAtual = (rotAtual + rotVel) % 360.0;

  numeroLinhas = bandas;
  anguloEntreLinhas = 360.0 / numeroLinhas;

  fft.analyze();

  for (int i = 0; i < bandas; i++) {
    intensidades[i] = suavizacao * fft.spectrum[i] + (1.0 - suavizacao) * intensidades[i];
  }

  // Ativação por limiar na banda 0
  ativo_agora = intensidades[0] > limiar;

  for (PVector centro : solCentros) {
    if (diametro < width && ativo_agora) {

      TR2Layer.noFill();
      TR2Layer.stroke(25, 70, 210, 0.5 * random(50,255));
      TR2Layer.strokeWeight( 0.05 * random(0, 255));
      TR2Layer.ellipse(centro.x, centro.y, diametro, diametro);
     
    }

    TR2Layer.pushMatrix();
    TR2Layer.translate(centro.x, centro.y);
    TR2Layer.rotate(radians(rotAtual));

    for (int i = 0; i < numeroLinhas; i++) {
      float comprimento = map(intensidades[i], 0, 0.1, 100, 400);
      TR2Layer.line(0, 0, comprimento, 0);
      TR2Layer.rotate(radians(anguloEntreLinhas));
    }

    TR2Layer.popMatrix();
  }
  
  println(diametro);
  TR2Layer.endDraw();
  image(TR2Layer, 0, 0);
}

void mouseClicked(){
  if (showTR2){
  float x = random(0, width);
  float y = random(0, height);

  solCentros.add(new PVector(x, y));
  }
}
