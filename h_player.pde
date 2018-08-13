/**
 Player object. Inherits from Rect.
 @param x x-coordinate of center
 @param y y-coordinate of center
 @param w width (x-dimension)
 @param h height (y-dimension)
 */
public class Player extends Rect {
  private List<Mal> mals;
  private color c;

  // creates new player
  public Player(int x, int y, int w, int h) {
    super(x, y, w, h);
    mals = new ArrayList<Mal>();
    c = 0;
  }

  // set/get color
  public color C() {
    return c;
  }
  public void setColor(color c) {
    this.c = c;
    if (!mals.isEmpty()) {
      for (Mal m : mals) {
        m.setColor(c);
      }
    }
  }
  
  // add mal to player's mal list
  public void addMal(Mal m) {
    if (mals.size() < 4) {
      mals.add(m);
      m.setHome(this);
      if (c != 0) {
        m.setColor(c);
      }
    }
  }
  
  // find mal in player's mal list
  public Mal findMalAt(int i) {
    return mals.get(i);
  }
  
  // size of player's mal list
  public int malsSize() {
    return mals.size();
  }

  // checks if any mal of this player is selected
  public boolean isSelected() {
    for (Mal m : mals) {
      if (m.isSelected()) {
        return true;
      }
    }
    return false;
    //return Mouse.isColor(c);
  }
  
  // checks what mals are at home
  public boolean isAnyoneHome() {
    for (Mal m : mals) {
      if (m.isHome() && !m.isFinished()) {
        return true;
      }
    }
    return false;
  }
  public boolean isEveryoneHome() {
    for (Mal m : mals) {
      if (!m.isHome()) {
        return false;
      }
    }
    return true;
  }

  // checks if all mals of this player are frozen
  public boolean isFrozen() {
    for (Mal m : mals) {
      if (!m.isFrozen()) {
        return false;
      }
    }
    return true;
  }
  public void freeze() {
    for (Mal m : mals) {
      m.freeze();
    }
  }

  // checks if all mals of this player are finished
  public boolean isFinished() {
    for (Mal m : mals) {
      if (!m.isFinished()) {
        return false;
      }
    }
    return true;
  }

  // draw methods for mals
  public void drawSelectedMals() {
    for (Mal m : mals) {
      if (!m.isSelected()) {
        m.drawShape();
      }
    }
  }
  public void drawUnselectedMals() {
    for (Mal m : mals) {
      if (m.isSelected()) {
        m.setXY(mouseX, mouseY);
        m.drawShape();
      }
    }
  }
}