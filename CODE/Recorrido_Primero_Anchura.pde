import java.util.Queue;
import java.util.LinkedList;

/**
  * EL algoritmo de búsqueda sobre espacio de estados basado en el
  * Algoritmo primero en Anchura
  * @param xInicial la coordenada X inicial
  * @param yInicial la coordenada Y inicial
  * @return Si tiene solución o no
  */
boolean salirDelLaberintoEnAnchura(int xInicial, int yInicial) {
  boolean encontrado = false;
  LinkedList<Nodo> ABIERTA;
  ABIERTA = new LinkedList<Nodo>();
  TABLA_A = new Nodo[sizeX][sizeY];
  ABIERTA.add(new Nodo(xInicial, yInicial));  // Añade el nodo inicial a ABIERTA

  while(!ABIERTA.isEmpty() && !encontrado) {

    Nodo actual = ABIERTA.remove();
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
    
    visita(ABIERTA,x+1,y,TABLA_A,actual);
    visita(ABIERTA,x-1,y,TABLA_A,actual);
    visita(ABIERTA,x,y+1,TABLA_A,actual);
    visita(ABIERTA,x,y-1,TABLA_A,actual);
    
    delay(50);
  }
  return encontrado;
}

void mostrarCaminoAnchura(){
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

void visita(Queue cola, int x,int y, Nodo antecesores [][],Nodo actual)
{
    if(x>=sizeX || y>=sizeY ||x<0 || y<0) // la casilla no es valida
       return;
       
    if(tablero[x][y]==-1)//es un obstaculo
        return;
        
    if(casillaVisitado[x][y])
        return;
        
     int distancia = actual.getDistance() + (tablero[x][y]== -3 ? 0 : tablero[x][y]);
     
     antecesores[x][y]=actual;
     cola.add(new Nodo(x,y, distancia));
     casillaVisitado[x][y]=true;
     enAbierta[x][y]=true;
     redraw();
    
}
