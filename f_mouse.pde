/**
  Mouse class. Checks color of mover currently selected.
*/
static public class Mouse {
  static private color mouseColor = 0;
  static private boolean pickedUp = false;

  // set mouse color
  static public void setColor(color c) {
    mouseColor = c;
  }
  
  // checks if mouse color matches parameter
  static public boolean isColor(color c) {
    if (mouseColor == c) {
      return true;
    }
    return false;
  }
  
  // gives string representation of the team colors
  static public String printColor() {
    if (mouseColor == #111EF2) {
      return "Blue";
    } else if (mouseColor == #F00000) {
      return "Red";
    } else if (mouseColor == #00E010) {
      return "Green";
    } else if (mouseColor == #B702D3) {
      return "Purple";
    } else {
      return "None";
    }
  }
  
  // checks/changes picked up status
  static public void pickUp() {
    pickedUp = true;
  }
  static public void drop() {
    pickedUp = false;
  }
  static public boolean pickedUp() {
    return pickedUp;
  }
}