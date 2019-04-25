import java.util.Stack;
import java.util.List;

/**
  * EL algoritmo de búsqueda sobre espacio de estados basado en el
  * Algoritmo primero en profundidad
  * @param xInicial la coordenada X inicial
  * @param yInicial la coordenada Y inicial
  * @return Si tiene solución o no
  */
boolean salirDelLaberintoPrimeroEnProfundidad(int xInicial, int yInicial) {
  Stack<Nodo> ABIERTA;
  boolean encontrado = false;
  ABIERTA = new Stack<Nodo>();
  TABLA_A = new Nodo[sizeX][sizeY];
  ABIERTA.add(new Nodo(xInicial, yInicial));  // Añade el nodo inicial a ABIERTA

  while(!ABIERTA.isEmpty() && !encontrado) {

    Nodo actual = ABIERTA.pop();
    int x = actual.getX(), y = actual.getY();
    enAbierta[x][y]=false;

    if(tablero[x][y] == -3) { // Es el nodo meta
      xFinal=x;
      yFinal=y;
      encontrado = true;
      distanciaDelCamino = actual.getDistance();
      continue; // Salta a la siguiente iteración
    } 
    casillaVisitado[x][y] = true; // Lo marco como visitado
    
    visitar(ABIERTA,x+1,y,TABLA_A,actual);
    visitar(ABIERTA,x-1,y,TABLA_A,actual);
    visitar(ABIERTA,x,y+1,TABLA_A,actual);
    visitar(ABIERTA,x,y-1,TABLA_A,actual);
    
    delay(50);
  }
  return encontrado;
}

/**
  * Muestra el camino meta generado en el algoritmo Primero en Profundidad
  */
void mostrarCaminoProfundidad(){
    int a=xFinal;
    int b=yFinal;
    while(TABLA_A[a][b]!=null) {
        //System.out.println("Estoy aqui con " + a + " y b " + b);
        Nodo padre= TABLA_A[a][b];
        if (tablero[a][b] != -3) esCamino[a][b]=true;
        a=padre.x;
        b=padre.y;
        redraw();
        delay(50);
    }
}

void visitar(Stack pila, int x,int y, Nodo antecesores [][],Nodo actual)
{
    if(x>=sizeX || y>=sizeY ||x<0 || y<0) // la casilla no es valida
       return;
       
    if(tablero[x][y]==-1)//es un obstaculo
        return;
        
    if(casillaVisitado[x][y])
        return;
        
     int distancia = actual.getDistance() + (tablero[x][y]== -3 ? 0 : tablero[x][y]);
     
     antecesores[x][y]=actual;
     pila.push(new Nodo(x,y, distancia));
     casillaVisitado[x][y]=true;
     enAbierta[x][y]=true;
     redraw();
    
}

/**
  * Replica el anterior algoritmo mediante el empleo de recursión
  */
boolean salirDelLaberintoPrimeroEnProfundidadRecursivo(int coordenadaX, int coordenadaY){
  // Caso base
  if(coordenadaX >= sizeX || coordenadaX < 0 || coordenadaY >= sizeY || coordenadaY < 0) return false; // La posición se sale del tablero
  if(casillaVisitado[coordenadaX] [coordenadaY]) return false; // Esta casilla ya ha sido visitada
  else if(tablero[coordenadaX][coordenadaY] == -1) return false; // Esta casilla es un obstáculo
  else if(tablero[coordenadaX][coordenadaY] == -3) return true; // Esta casilla es la casilla de salida
  casillaVisitado[coordenadaX][coordenadaY] = true; // Lo marco como visitado
  delay(50);
  boolean resultado = salirDelLaberintoPrimeroEnProfundidadRecursivo(coordenadaX, coordenadaY-1) || salirDelLaberintoPrimeroEnProfundidadRecursivo(coordenadaX+1, coordenadaY) || 
                          salirDelLaberintoPrimeroEnProfundidadRecursivo(coordenadaX, coordenadaY+1) || salirDelLaberintoPrimeroEnProfundidadRecursivo(coordenadaX-1, coordenadaY) ;                      
  delay(50);
  if(resultado && tablero[coordenadaX][coordenadaY] != -2){
    casillaVisitado[coordenadaX][coordenadaY] = true; // Lo marco como visitado
    distanciaDelCamino += tablero[coordenadaX][coordenadaY];  // Suma la distancia
  }
  return resultado;
}

/**
  * Muestra el camino que la recursión ha devuelto como camino
  */
void mostrarCaminoProfundidadRecursivo(){
  for(int i = 0; i<sizeX; i++){
     for(int j = 0; j<sizeY; j++){
       if(enAbierta[j][i]) fill(255,0,0);  // Es camino solución fill(255,204,79); // A oro
     }
    }
}
