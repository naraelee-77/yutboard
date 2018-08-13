/**
 Mal object. Can be dragged, selected, hovered over, etc. Versatile. Implements Shape.
 @param x x-coordinate of center
 @param y y-coordinate of center
 */
public class Mal implements Shape {
  private int x;
  private int y;
  private int origX;
  private int origY;
  private float r;
  private color c;
  private boolean selected;
  private boolean frozen;
  private boolean finished;
  private int grouped;
  private Shape home;

  // creates new mal
  public Mal(int x, int y) {
    origX = x;
    origY = y;
    this.x = x;
    this.y = y;
    r = (float) Math.sqrt(.5)*r2;
    grouped = 1;
  }

  // get methods
  public int X() {
    return x;
  }
  public int Y() {
    return y;
  }
  public float R() {
    return r;
  }
  public color C() {
    return c;
  }

  // set color of mal
  public void setColor(color c) {
    this.c = c;
  }

  // set/get location of home
  public void setHome(Shape home) {
    this.home = home;
  }
  public Shape getHome() {
    return home;
  }
  
  public boolean isHome() {
    return (x == origX && y == origY);
  }

  // change (x, y) coordinates
  public void setXY() {
    x = origX;
    y = origY;
    grouped = 1;
  }
  public void setXY(Shape s) {
    x = s.X();
    y = s.Y();
  }
  public void setXY(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // checks if mouse is hovering over mal
  public boolean isHovering() {
    if (mouseX >= x - r/2 && mouseX <= x + r/2 && mouseY >= y - r/2 && mouseY <= y + r/2) {
      return true;
    }
    return false;
  }

  // checks if mal location and shape location are the same
  public boolean isOnShape(Shape shp) {
    if (x == shp.X() && y == shp.Y()) {
      return true;
    }
    return false;
  }

  // checks/changes selected status
  public boolean isSelected() {
    return selected;
  }
  public void select() {
    selected = true;
  }
  public void deselect() {
    selected = false;
  }
  
  // checks/changes frozen status
  public boolean isFrozen() {
    return frozen && malsFrozen;
  }
  public void freeze() {
    frozen = true;
  }
  public void unfreeze() {
    frozen = false;
  }
  
  // checks/changes finished status
  public boolean isFinished() {
    return finished;
  }
  public void finish() {
    setXY();
    frozen = true;
    finished = true;
  }
  public void reset() {
    setXY();
    deselect();
    frozen = false;
    finished = false;
  }

  // checks/changes grouped status
  public void setGroup(int grouped) {
    this.grouped = grouped;
  }
  public int numGrouped() {
    return grouped;
  }
  
  // pick up mal if able
  public boolean pickUppable() {
    if (isHovering() && !isFrozen() && !isSelected() && Mouse.isColor(0)) {
      return true;
    }
    return false;
  }
  public void pickUpAction(Shape shp) {
    if (pickUppable()) {
      select();  // pick up mal
      if (shp instanceof Circ) {
        ((Circ)shp).deoccupy();  // clear position
      }
    }
  }
  
  // drop mal if able
  public boolean droppable(Shape shp) {
    if (!isFrozen() && isSelected() && possSpaces.contains(shp)) {
      return true;
    }
    return false;
  }
  public void dropAction(Shape shp) {
    if (droppable(shp)) {
      deselect();  // release mal
      if (shp.equals(getHome())) {
        setXY();  // if hovering over home, return home
      } else if (shp.equals(endCircle)) {
        finish();  // if hovering over end circle, finish and go home
      } else if (shp instanceof Circ) {
        setXY(shp);  // place in position of selected circle
        ((Circ)shp).occupy();
      }
    }
  }
  
  // carried out when kicked out by another player
  public void kickOutAction(Shape shp) {
    if (isOnShape(shp) && !Mouse.isColor(C())) {
      setXY();
      if (Arrays.asList(yutnori).contains(moves[0])) {
        throwAgain = true;
      }
    }
  }

  // draw mal
  public void drawShape() {
    //rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    fill(c);
    rect(0, 0, r, r);
    if (finished) {  // x lines for finished mals
      stroke(#341100);
      line(-r/2, -r/2, r/2, r/2);
      line(-r/2, r/2, r/2, -r/2);
    } else if (grouped > 1) {  // group number for grouped mals
      fill(255);
      textSize(r/2);
      text("x" + grouped, 0, r/8);
    }
    popMatrix();
  }

  // returns center coordinates of mal
  public String toString() {
    return "(" + x + ", " + y + ")";
  }
}