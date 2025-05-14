// Exemplo_089_4 

// Declaração de variável int e de Arraylist
int numeroDeObjectos; 
ArrayList <myObject> objsList;

//////////////////////////////////////////////////////////////////////////////////////
void setup() {   
  size(400, 400, JAVA2D);   
  smooth();   
  noStroke();   
  background(235, 235, 235);
  // Iniciação da variável int e da Arraylist 
  //numeroDeObjectos = int( random( 1, 20) );
  numeroDeObjectos = int(5);
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
