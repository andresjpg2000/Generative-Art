// Declaração de variável int e de Arraylist
boolean showBGlive;
int numeroDeObjectos; 
ArrayList <myObject> objsList;

float increment = 0.005;
// The noise function's 3rd argument, a global variable that increments once per cycle
float zoff = 0.0;  
// We will increment zoff differently than xoff and yoff
float zincrement = 0.02; 

PGraphics LayerBGlive;

//////////////////////////////////////////////////////////////////////////////////////  
void setupBGlive() {
  LayerBGlive = createGraphics(width, height);
  noStroke();   
  background(235, 235, 235);
  // Iniciação da variável int e da Arraylist 
  //numeroDeObjectos = int( random( 1, 20) );
  numeroDeObjectos = int(0);
  objsList = new ArrayList();   
  for (int i = 0; i < numeroDeObjectos; i += 1) {
    // Declaração e iniciação de um novo objecto do
    // tipo myObject     
    myObject obj = new myObject();  
    // Para adicionar um elemento no final da lista   
    objsList.add(obj);
  }
  
  showBGlive = false;
}

//////////////////////////////////////////////////////////////////////////////////////
void drawBGlive() {
  LayerBGlive.beginDraw();
  LayerBGlive.colorMode(HSB, 255);
  LayerBGlive.noStroke();

  LayerBGlive.loadPixels();
  // Noise
  float xoff = 0.0;
  for (int x = 0; x < width; x++) {
    xoff += increment;
    float yoff = 0.0;
    for (int y = 0; y < height; y++) {
      yoff += increment;
      float n = noise(xoff, yoff, zoff);
      float hue = n * (millis() * 0.05f) % 255;
      LayerBGlive.pixels[x + y * width] = LayerBGlive.color(hue, 200, 255);
    }
  }
  LayerBGlive.updatePixels();

  zoff += zincrement;

  // Desenhar
  for (int i = objsList.size() - 1; i >= 0; i--) {
    myObject obj = objsList.get(i);
    if (!obj.stillAlive()) {
      objsList.remove(i);
      objsList.add(new myObject());
    } else {
      obj.updateIt();
      obj.worldCollision();
      obj.drawIt(LayerBGlive);
    }
  }

  LayerBGlive.fill(235, 235, 235, 31);
  LayerBGlive.rect(0, 0, width, height);

  if (keyPressed) {
    if (key == '+') {
      objsList.add(new myObject());
    }
    if (key == '-' && objsList.size() > 0) {
      objsList.remove(int(random(objsList.size())));
    }
  }

  LayerBGlive.endDraw();

  if (showBGlive) {
    image(LayerBGlive, 0, 0);
  }
}
 
