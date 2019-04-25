import javax.swing.JOptionPane;

int [][] tablero;

int sizeX = 15;
int sizeY = 15;
int size = 40;
int [] posicionCasillaInicial = {0,0};
int [] posicionCasillaFinal = {0,0};

Nodo[][] TABLA_A;
int xFinal=0,yFinal=0;

boolean [][] casillaVisitado = new boolean [sizeX][sizeY];

boolean [][] enAbierta = new boolean [sizeX][sizeY];
boolean[][] esCamino = new boolean[sizeX][sizeY];

boolean resultadoLaberinto = false;
int distanciaDelCamino = 0;

/**
  * Crea la ventana
  */
void setup() {
  iniciarTablero();
  size(600, 600); 
  textSize(18);
}

/*
 *  Representa el tablero
 */ 
void draw() {
   for(int i = 0; i<sizeX; i++){
     for(int j = 0; j<sizeY; j++){
       // Cambia el color a pintar
       if (tablero[j][i]!= -2 && tablero[j][i]!= -3 && !esCamino[j][i] && casillaVisitado[j][i]) fill(220, 234, 100);  // Se ha expandido el nodo
        else if (tablero[j][i] == -1) { // Obstáculo
         fill(165,165,165); // A negro
       } else if (tablero[j][i] == -2) { // Casilla Inicial
         fill(30,89,69); // A verde
       } else if(tablero[j][i] == -3){ // Posición Meta
         posicionCasillaFinal[0] = j;
         posicionCasillaFinal[1] = i;
         fill(73,103,141); // A azul
       } else if (esCamino[j][i]) { // Es camino visitado
         fill(255,204,79); // A oro
       } else if(tablero[j][i] >= 0) { // Casilla libre
         fill(78,59,49); // A marrón
       }
       if(enAbierta[j][i]) fill(255,0,0);  // Es camino solución
       
       rect(size*i,size*j,size,size); // Dibuja el tablero
       if(tablero[j][i] != -1 && tablero[j][i] != -2 && tablero[j][i] != -3){
         fill(255, 0, 0); // Rojo
         text(""+tablero[j][i],size*i+size/3, size*j+size/1.5);
       }
     }
   }
}

/**
  * Se invoca cuando alguien clicka en la pantalla
  */
void mouseClicked(){
  iniciarTablero(); // Dibujar el tablero por defecto
  if (calculaPosicionCasillaInicial()){ // Es posición válida
    redraw(); // Redibuja el tablero
    thread("lanzarOpcion");
  }
}

String algoritmo = new String();
void lanzarOpcion() {
  int option = JOptionPane.showConfirmDialog(null,"¿Deseas iniciar el laberinto?", "BFS", JOptionPane.YES_NO_CANCEL_OPTION);
  if(option == 0){
    algoritmo = myOptionPane();
    long millisIni = 0;
    long millisFinal = 0;
    if(algoritmo.equals( "Primero en Anchura")) {
      millisIni=millis();
      resultadoLaberinto = salirDelLaberintoEnAnchura(posicionCasillaInicial[0], posicionCasillaInicial[1]);
      millisFinal = millis()-millisIni;   
    } else if (algoritmo.equals("Primero en Profundidad")) {
      millisIni=millis();
      resultadoLaberinto = salirDelLaberintoPrimeroEnProfundidad(posicionCasillaInicial[0], posicionCasillaInicial[1]);
      millisFinal = millis()-millisIni;       
    } else if (algoritmo == "Coste Uniforme") {
      millisIni=millis();
      resultadoLaberinto = salirDelLaberintoEnCosteUniforme(posicionCasillaInicial[0], posicionCasillaInicial[1]);
      millisFinal = millis()-millisIni;      
    } else if (algoritmo == "Best First") {
      millisIni=millis();
      resultadoLaberinto = salirDelLaberintoEnBestFirst(posicionCasillaInicial[0], posicionCasillaInicial[1]);
      millisFinal = millis()-millisIni;      
    }else if (algoritmo == "A*") {
      millisIni=millis();
      resultadoLaberinto = salirDelLaberintoEnAEstrella(posicionCasillaInicial[0], posicionCasillaInicial[1]);
      millisFinal = millis()-millisIni;      
    }
    
    if(!algoritmo.equals("")){ // No se ha cancelado
      if(!resultadoLaberinto ){ // Si hay resultado ofrece la opción de imprimirlo 
          JOptionPane.showMessageDialog(null, "No hay camino posible desde esa casilla inicial hasta la casilla META");
        } else {
           option = JOptionPane.showConfirmDialog(null,"Se ha encontrado camino distancia de " + distanciaDelCamino +" en " + millisFinal + "ms. " + "¿Deseas imprimir el camino?", "BFS", JOptionPane.YES_NO_CANCEL_OPTION);
          if (option == 0) {
            if (algoritmo.equals( "Primero en Anchura")){  
              mostrarCaminoAnchura();
            } else if (algoritmo.equals("Coste Uniforme")){
              mostrarCaminoUniforme();
            } else if (algoritmo.equals("Primero en Profundidad")){
              mostrarCaminoProfundidad();
            } else if (algoritmo.equals("Best First")){
              mostrarCaminoBestFirst();
            } else if (algoritmo.equals("A*")){
              mostrarCaminoAEstrella();
            }
          }
        }
    }
  } 
}

/**
  * Calcula la posición Inicial y devuelve si se ha podido inicializar
  * con unos valores correctos
  */
boolean calculaPosicionCasillaInicial(){
  int co0 = mouseY / size;
  int co1 = mouseX / size;

  // Comprueba que la nueva posición es una zona válida
  if(tablero[co0][co1] != -1 && tablero[co0][co1] != -3 ) {
    posicionCasillaInicial[0] =co0;
    posicionCasillaInicial[1] = co1;
    tablero[co0][co1] = -2;
    return true;
  } 
  return false;
}

/**
  * Inicializa el tablero con valores por defecto
  */
void iniciarTablero(){
    tablero = new int [][]{
    {0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,-1,0,0,0,0,0,0,0,0,-1,0,0,0,0},
    {0,-1,-1,-1,-1,-1,0,0,0,0,-1,0,0,0,0},
    {9,9,9,9,-3,-1,0,0,0,0,-1,-1,-1,-1,-1},
    {9,0,0,0,0,-1,0,0,0,0,0,0,-1,0,0},
    {9,0,-1,0,0,-1,0,0,0,-1,-1,-1,-1,0,0},
    {0,0,-1,0,0,-1,0,0,0,-1,0,0,0,0,0},
    {0,9,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0},
    {0,9,-1,0,0,5,0,0,0,0,0,0,0,0,0},
    {0,0,-1,0,0,8,0,6,0,0,5,5,5,5,0},
    {0,9,-1,-1,-1,-1,0,0,0,5,5,5,5,0,0},
    {0,9,9,9,9,-1,9,9,1,0,5,5,5,0,0},
    {1,1,1,1,9,-1,1,9,1,1,1,1,1,0,0},
    {1,9,9,9,9,-1,1,1,9,9,9,9,9,9,9},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,0,0},
  };
  casillaVisitado = new boolean [sizeX][sizeY];
  enAbierta = new boolean [sizeX][sizeY];
  esCamino = new boolean[sizeX][sizeY];
}
