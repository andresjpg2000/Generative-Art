// Exemplo_089_4 

// Declaração de variável int e de Arraylist
int numeroDeObjectos; 
ArrayList <myObject> objsList;

float increment = 0.01;
// The noise function's 3rd argument, a global variable that increments once per cycle
float zoff = 0.0;  
// We will increment zoff differently than xoff and yoff
float zincrement = 0.02; 

//////////////////////////////////////////////////////////////////////////////////////
void setup() {   
  size(400, 400);   
  frameRate(30);
  smooth();   
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
}

//////////////////////////////////////////////////////////////////////////////////////
void draw() {
  
  // Optional: adjust noise detail here
  // noiseDetail(8,0.65f);
  
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff,zoff)*255;

      // Try using this line instead
      //float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright,bright,bright);
    }
  }
  updatePixels();
  
  zoff += zincrement; // Increment zoff
  
  // Este ciclo for começa no topo e termina na
  // base da lista
  for ( int i = objsList.size() - 1; i > -1; i = i - 1) {  
    // Vai buscar o objecto[ i ] da ArrayList  
    myObject obj = objsList.get( i );   
    // Se o tempo de vida terminou, elimina o objecto  
    if ( obj.stillAlive() == false ){
       objsList.remove (i);
       myObject b = new myObject();
       objsList.add(b);
    }   
    else {   
      // Caso contrário verifica atualiza  a posição,   
      // verifica a colisão com os limites da janela e   
      // desenha objecto 
      obj.updateIt();      
      obj.worldCollision();      
      obj.drawIt();
    } // Aqui termina o bloco else do if
  } // Aqui termina o ciclo for
  fill(235, 235, 235, 31);  
  rect(0, 0, width, height);
}

/////////////////////////////////////////////////////////
void mousePressed() {
  // Declaração e iniciação do elemento 
  // com nome obj do tipo myObject 
  myObject obj = new myObject();
  // Função da classe myObject que altera a 
  // posição do objecto
  obj.setPos( mouseX, mouseY);
  // O objecto obj é adicionado na ArrayList objsList
  objsList.add(obj);
} 

/////////////////////////////////////////////////////////
void keyPressed() {
  if (key == '+') {
    myObject b = new myObject();
    objsList.add(b);
  }
  if (key == '-' && objsList.size() > 0) {
    objsList.remove( int(random(objsList.size())));
  }
}  
