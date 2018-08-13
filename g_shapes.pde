/**
 Interface for a shape object. A user can check (x,y) coordinates, 
 check if mouse is hovering over object, and draw the shape.
 @author Narae Lee
 */
public interface Shape {
  public int X();
  public int Y();
  public boolean isHovering();
  public void drawShape();
}

/**
 Circle object. Implements Shape.
 @param x x-coordinate of center
 @param y y-coordinate of center
 @param r 2*radius of circle
 */
public class Circ implements Shape {
  private int x;
  private int y;
  private int r;
  private boolean occupied;

  // creates new circle object
  public Circ(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
    occupied = false;
  }

  // get methods
  public int X() {
    return x;
  }
  public int Y() {
    return y;
  }
  public int R() {
    return r;
  }

  // checks if mouse is hovering over circle
  public boolean isHovering() {
    if (Math.hypot(mouseX - x, mouseY - y) <= r/2) {
      return true;
    }
    return false;
  }
  
  // checks/changes occupied status
  public void occupy() {
    occupied = true;
  }
  public void deoccupy() {
    occupied = false;
  }
  public boolean isOccupied() {
    return occupied;
  }

  // draws circle
  public void drawShape() {
    ellipse(x, y, r, r);
  }

  // returns center coordinates of circle
  public String toString() {
    return "C(" + x + ", " + y + ")";
  }
}

/**
 Rectangle object. Implements Shape.
 @param x x-coordinate of center
 @param y y-coordinate of center
 @param w width of rectangle (x-dimension)
 @param h height of rectangle (y-dimension)
 */
public class Rect implements Shape {
  private int x;
  private int y;
  private int w;
  private int h;

  // creates new rectangle object
  public Rect(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // get methods
  public int X() {
    return x;
  }
  public int Y() {
    return y;
  }
  public int W() {
    return w;
  }
  public int H() {
    return h;
  }

  // checks if mouse is hovering over rectangle
  public boolean isHovering() {
    if (mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2) {
      return true;
    }
    return false;
  }

  // draws rectangle
  public void drawShape() {
    //rectMode(CORNERS);
    rect(x, y, w, h);
  }

  // returns center coordinates of rectangle
  public String toString() {
    return "R(" + x + ", " + y + ")";
  }
}