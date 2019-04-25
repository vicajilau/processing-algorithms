import javax.swing.JOptionPane;
import javax.swing.*;

Object[] selectionValues = { "Primero en Anchura", "Primero en Profundidad", "Coste Uniforme",
                                  "Best First", "A*" };
public String myOptionPane() {  
    JDialog.setDefaultLookAndFeelDecorated(true);
    
    String initialSelection = "Primero en Anchura";
    Object selection = JOptionPane.showInputDialog(null, "Selecciona el tipo de recorrido en el espacio de búsqueda",
        "Inteligencia Artificial", JOptionPane.QUESTION_MESSAGE, null, selectionValues, initialSelection);
    if(selection == null) return new String();
    return selection.toString();
}  
 
