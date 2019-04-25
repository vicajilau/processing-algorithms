import java.util.Queue;
import java.util.LinkedList;
import java.util.PriorityQueue;
import java.util.Comparator;

/**
  * EL algoritmo de búsqueda sobre espacio de estados basado en el
  * Algoritmo primero en Anchura
  * @param xInicial la coordenada X inicial
  * @param yInicial la coordenada Y inicial
  * @return Si tiene solución o no
  */
boolean salirDelLaberintoEnBestFirst(int xInicial, int yInicial) {
  PriorityQueue<Nodo> ABIERTA;
  boolean encontrado = false;
  ABIERTA = new PriorityQueue<Nodo>(new Comparator <Nodo> (){
    public int compare(Nodo a, Nodo b){
      if( (heuristicaBestFirst(a)) > (heuristicaBestFirst(b)) ) return 1;
      else if( (heuristicaBestFirst(a)) < (heuristicaBestFirst(b)) ) return -1;
      else return 0;
    }
  });
  
  TABLA_A = new Nodo[sizeX][sizeY];
  ABIERTA.add(new Nodo(xInicial, yInicial, 0));  // Añade el nodo inicial a ABIERTA
  

  while(!ABIERTA.isEmpty() && !encontrado) {

    Nodo actual = ABIERTA.remove();
    int x = actual.getX(), y = actual.getY();
    enAbierta[x][y]=false;

    if(tablero[x][y] == -3) { // Es el nodo meta
      xFinal=x;
      yFinal=y;
      distanciaDelCamino = actual.getDistance();
      encontrado = true;
      continue; // Salta a la siguiente iteración
    } 
    casillaVisitado[x][y] = true; // Lo marco como visitado
    
    visitaBestFirst(ABIERTA,x+1,y,TABLA_A,actual);
    visitaBestFirst(ABIERTA,x-1,y,TABLA_A,actual);
    visitaBestFirst(ABIERTA,x,y+1,TABLA_A,actual);
    visitaBestFirst(ABIERTA,x,y-1,TABLA_A,actual);
    
    delay(50);
  }
  return encontrado;
}

void mostrarCaminoBestFirst(){
    int a=xFinal;
    int b=yFinal;
    while(TABLA_A[a][b]!=null) {
        Nodo padre= TABLA_A[a][b].getNodoPadre();
        if (tablero[a][b] != -3) esCamino[a][b]=true;
        a=padre.x;
        b=padre.y;
        redraw();
        delay(50);
    }
}

void visitaBestFirst(PriorityQueue<Nodo> cola, int x,int y, Nodo antecesores [][], Nodo actual) {
    if(x>=sizeX || y>=sizeY ||x<0 || y<0) // la casilla no es valida
       return;
       
    if(tablero[x][y]==-1)//es un obstaculo
        return;
        
    if(casillaVisitado[x][y])
        return;
     
     int distancia = actual.getDistance() + (tablero[x][y]== -3 ? 0 : tablero[x][y]);
     
     if(antecesores[x][y]!= null && antecesores[x][y].getNodoPadre()!= null) { // Por ahí hemos pasado
       if(distancia >= antecesores[x][y].getDistanciaPadre()) {
         return;
       }       
     }
     Nodo nuevoNodo = new Nodo(x,y, actual.getDistance(), new Nodo(actual.getX(), actual.getY()), distancia);    
     antecesores[x][y] = nuevoNodo;
     
     cola.add(new Nodo(x,y, distancia));
     casillaVisitado[x][y]=true;
     enAbierta[x][y]=true;
     redraw();
    
}

/**
  * Algoritmo que aplica la distancia de Manhattan también conocida como geometría del taxista como heurístico
  @return una aproximación optimista de h*
  */
int heuristicaBestFirst(Nodo n) {
  //println("De la casilla (" + n.getX() + ", " + n.getY() + ") a la (" + xFinal + ", " + yFinal + ") hay una distancia de " + Math.abs(n.getX()-xFinal) + Math.abs(n.getY()-yFinal));
  return (Math.abs(n.getX()-posicionCasillaFinal[0]) + Math.abs(n.getY()-posicionCasillaFinal[1]) );
}
