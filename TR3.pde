
boolean mode = true;
int numDeTiras, numSeccoesPorTira;
float escala, raioA, raioB, raioMin, raioMax;
float vxA, vyA, vzA, vxB, vyB, vzB, offSetZ, velZ;
float raioNoise, distNoiseAB, valorNoiseA, valorNoiseB;
float nxA, nyA, nzA, nxB, nyB, nzB, offSetNZ;
float morphAmount = 0;

//ArrayList<PVector> squares = new ArrayList<PVector>();
//ArrayList<Integer> squareColors = new ArrayList<Integer>();

ArrayList<RotatingCube> cubes = new ArrayList<RotatingCube>();

boolean showTR3;

PGraphics TR3Layer;

void setupTR3() {
  TR3Layer = createGraphics(width, height, P3D);
  TR3Layer.beginDraw();
  TR3Layer.noFill();
  TR3Layer.strokeWeight(1.25);
  TR3Layer.endDraw();


  raioNoise = 0.5;
  distNoiseAB = 0.125 * raioNoise;
  offSetNZ = 0;
  raioMin = 0.5 * raioNoise;
  raioMax = 4.0 * raioNoise;

  escala = 950.0;
  numDeTiras = 200;
  numSeccoesPorTira = 48;
  offSetZ = 0.0;
  velZ = 15.0;

  showTR3 = false;
}

void drawTR3() {
  TR3Layer.beginDraw();
  TR3Layer.background(0, 19, 138);
  beatDetector.sensitivity(1000);

  if (beatDetector.isBeat()) {
    float x = random(-200, 200);
    float y = random(-150, 150);
    float z = -random(1000, 5000);
    //squares.add(new PVector(x, y, z));
    //squareColors.add(color(random(100), random(127), 255, random(255)));
    color c = color(random(100), random(127), 255, 255);
    cubes.add(new RotatingCube(new PVector(x, y, z), c, 40, random(1000)));
  }

  if (mode == true) {
    morphAmount = constrain(smoothedIntensity, 0, 1);
    println(morphAmount);
  } else {
    if (keyPressed == true && keyCode == RIGHT) morphAmount = min(1.0, morphAmount + 0.005);
    if (keyPressed == true && keyCode == LEFT) morphAmount = max(0.0, morphAmount - 0.005);
  }

  TR3Layer.translate(0.5 * width, 0.5 * height, height);
  TR3Layer.translate(-raioNoise, -raioNoise, 0);

  float angulo, cosAngulo, sinAngulo, opacidade;

  for (int nt = 0; nt < numDeTiras; nt++) {
    TR3Layer.beginShape(QUAD_STRIP);
    opacidade = map(nt, 0, numDeTiras, 1.0, 0);
    TR3Layer.stroke(255, 255 * pow(opacidade, 3));

    for (int nl = 0; nl < numSeccoesPorTira + 1; nl++) {
      angulo = map(nl, 0, numSeccoesPorTira, 0, 360);
      cosAngulo = cos(radians(angulo));
      sinAngulo = sin(radians(angulo));

      nxA = raioNoise + raioNoise * cosAngulo;
      nyA = raioNoise + raioNoise * sinAngulo;
      nzA = -nt * distNoiseAB;
      nxB = nxA;
      nyB = nyA;
      nzB = -(nt + 1) * distNoiseAB;

      valorNoiseA = noise(nxA, nyA, offSetNZ + nzA);
      valorNoiseB = noise(nxB, nyB, offSetNZ + nzB);

      float baseRaio = 2.0 * raioNoise;
      float curvaA = map(valorNoiseA, 0.0, 1.0, raioMin, raioMax);
      float curvaB = map(valorNoiseB, 0.0, 1.0, raioMin, raioMax);

      raioA = lerp(baseRaio, curvaA, morphAmount);
      raioB = lerp(baseRaio, curvaB, morphAmount);

      vxA = raioA * sinAngulo;
      vyA = raioA * cosAngulo;
      vzA = nzA;
      vxB = raioB * sinAngulo;
      vyB = raioB * cosAngulo;
      vzB = nzB;

      vxA = escala * vxA;
      vyA = 0.75 * escala * vyA;
      vzA = escala * vzA;
      vxB = escala * vxB;
      vyB = 0.75 * escala * vyB;
      vzB = escala * vzB;

      TR3Layer.vertex(vxA, vyA, offSetZ + vzA);
      TR3Layer.vertex(vxB, vyB, offSetZ + vzB);
    }
    TR3Layer.endShape();
  }

  //for (int i = 0; i < squares.size(); i++) {
  //  PVector s = squares.get(i);
  //  s.z += velZ;
  //  TR3Layer.pushMatrix();
  //  TR3Layer.translate(s.x, s.y, s.z);
  //  TR3Layer.fill(squareColors.get(i));
  //  TR3Layer.noStroke();
  //  TR3Layer.rectMode(CENTER);
  //  TR3Layer.rect(0, 0, 40, 40);
  //  TR3Layer.popMatrix();
  //  TR3Layer.noFill();
  //}
  
  for (int i = 0; i < cubes.size(); i++) {
    RotatingCube c = cubes.get(i);
    c.update(velZ);
    c.render(TR3Layer, i * 10);
  }


  offSetZ += velZ;
  while (offSetZ > escala * distNoiseAB) {
    offSetZ -= escala * distNoiseAB;
    offSetNZ -= distNoiseAB;
  }
  if (keyPressed == true && keyCode == 'a' || keyCode == 'A') {
    mode = true;
  }
  if (keyPressed == true && keyCode == 'b' || keyCode == 'B') {
    mode = false;
  }

  println(mode);

  TR3Layer.endDraw();
  image(TR3Layer, 0, 0);
}
