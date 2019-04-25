/**
  * Esta clase representa un nodo de un espacio de búsqueda
  *
  */

public class Nodo {
  private int x; // Coordenada con respecto al eje X
  private int y; // Coordenada con respecto al eje Y
  private int distance; // Distancia a este nodo
  private Nodo padre;  // El padre de este nodo o null si todavía no se ha expandido
  private int distanciaPadre; //Distancia con respecto al padre
  
  public Nodo(int x, int y){
    this(x, y, 0);
  }
  
  public Nodo(int x, int y, int distance){
    this(x, y, distance, null, -1);
  }
  
  public Nodo( int x, int y, int distancia, Nodo padre, int distanciaPadre){
    this.x = x;
    this.y = y;
    this.distance = distancia;
    this.padre = padre;
    this.distanciaPadre = distanciaPadre;
  }
  
  public int getX(){ return x;}
  
  public int getY(){ return y;}
  
  public int getDistance(){ return distance;}
  
  public Nodo getNodoPadre(){return padre;}
  
  public int getDistanciaPadre(){return distanciaPadre;}
  
  public void setNodoPadre(Nodo nuevoPadre) { padre = nuevoPadre;}
  
  public void setDistanciaPadre(int nuevaDistanciaPadre) { distanciaPadre = nuevaDistanciaPadre;}
  
  public void setDistance(int newDistance){ distance = newDistance;}
  
}
