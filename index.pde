import processing.sound.*;

SoundFile player;
Amplitude amplitude;
BeatDetector beatDetector;
FFT fft;

float intensity, smoothingFactor, smoothedIntensity, amplifyValue;

float rotacao, raioInterior, anguloEntreLinhas, espacoEntreRetangulos;
float limiar;

float fadeTR1 = 0, fadeTR2 = 0, fadeTR3 = 0, fadeBG = 0;
float fadeSpeed = 20;

void setup() {
  size(1200, 600,P2D);
  noCursor();
  frameRate(25);
  smooth();
  noiseDetail(4);

  player = new SoundFile(this, "music.mp3");
  fft = new FFT(this, bandas);
  fft.input(player);
  
  amplitude = new Amplitude(this);
  amplitude.input(player);
  
  beatDetector = new BeatDetector(this);
  beatDetector.input(player);
  
  amplifyValue = 1.0;
  smoothingFactor = 0.5;
  
  setupTR1();
  setupTR2();
  setupTR3();
  setupBGlive();
  setupCube();
  setupSpiral();
}

void draw() {
  background(230,230,255);
 
  intensity = amplitude.analyze();
  intensity = amplifyValue * intensity;
  smoothedIntensity = (1.0 - smoothingFactor) * smoothedIntensity + smoothingFactor * intensity;
  
  if(showSpiral == true) drawSpiral();
  if(showBGlive == true) drawBGlive();
  if(showTR1 == true) drawTR1();
  if(showTR2 == true) drawTR2();
  if(showTR3 == true) drawTR3();
  if(showCube == true) drawCube();

  //if(showSun == true) drawSun();
}

void keyPressed() {
  if (key == ENTER) player.play();
  if (key == '1') showTR1 = !showTR1;
  if (key == '2') showTR2 = !showTR2;
  if (key == '3') showTR3 = !showTR3;
  if (key == '4') showBGlive = !showBGlive;
  if (key == '5') showCube = !showCube;
  if (key == '6') showSpiral = !showSpiral;
}
