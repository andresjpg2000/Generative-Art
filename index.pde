void setup() {
  size(400, 400,P2D);
  
  setupTR1();
  setupMain();
  frameRate(25);
  smooth();
}

void draw() {
  background(255);
  if(showTR1 == true) drawTR1();
  if(showMain == true) drawMain();
  //if(showSun == true) drawSun();
}

void keyPressed() {

  if (key == '1') showTR1 = !showTR1;
  if (key == '2') showMain = !showMain;
  
}
