/**
 Yut stick object. Can be thrown. Implements shape.
 @param x x-coordinate of yut stick
 @param y y-coordinate of yut stick
 @param w width of stick
 @param h height of stick
 */
public class YutStick implements Shape {
  private int x;
  private int y;
  private int w;
  private int h;
  private boolean flipped;
  private boolean baekdo;
  private Random rand;
  private double r;
  private Shape home;
  private Stick stick;

  // creates new yut stick
  public YutStick(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    stick = new Stick(x, y, w, h);
    rand = new Random();
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

  // assign baekdo status to a stick
  public void makeBaekdo() {
    baekdo = true;
  }

  // set/get location of home
  public void setHome(Shape home) {
    this.home = home;
  }
  public Shape getHome() {
    return home;
  }

  // checks if mouse is hovering
  public boolean isHovering() {
    return false;
  }
  
  // checks if stick is flipped
  public boolean isFlipped() {
    return flipped;
  }

  // throws yut stick
  public void throwStick() {
    r = rand.nextDouble();
    if (r < .4) {
      flipped = false;
    } else {
      flipped = true;
    }
  }

  // draws yut stick
  public void drawShape() {
    if (flipped) {
      if (baekdo) {
        stick.drawShape(3);
      } else {
        stick.drawShape(1);
      }
    } else {
      stick.drawShape(2);
    }
  }
  
  // when new game starts, start in mo position
  public void reset() {
    flipped = false;
  }

  // returns center coordinates of yut stick
  public String toString() {
    return "(" + x + ", " + y + ")";
  }
  
  /**
   Creates a yut stick using PShapes.
   @param x x-coordinate of yut stick
   @param y y-coordinate of yut stick
   @param w width of stick
   @param h height of stick
   */
  private class Stick {
    private PShape stick;
    private List<PShape> sticks;
    private PShape shp;
    private int x;
    private int y;
    //private int w;
    //private int h;
    private float r;
    private float a;
  
    // creates new stick
    private Stick(int x, int y, int w, int h) {
      this.x = x;
      this.y = y;
      //this.w = w;
      //this.h = h;
      a = .45*w;
      r = h-a;
      sticks = new ArrayList<PShape>();
      sticks.add(stick1());
      sticks.add(stick2());
      sticks.add(stick3());
    }
  
    // creates a flipped stick
    private PShape stick1() {
      stick = createShape(GROUP);
      
      // body
      fill(#FCC263);
      stroke(#341100);
      shp = createShape(RECT, 0, -a/2, w, r);
      stick.addChild(shp);
  
      // bottom edge
      shp = createShape(ARC, 0, r/2-a/2, w, 2*a, 0, PI, CHORD);
      stick.addChild(shp);
      
      return stick;
    }
  
    // creates an unflipped stick
    private PShape stick2() {
      stick = createShape(GROUP);
  
      // body
      fill(#C67D34);
      noStroke();
      shp = createShape(RECT, 0, a/2, w, r);
      stick.addChild(shp);
      stroke(#341100);
  
      // lines on side of body
      shp = createShape(LINE, -w/2, -r/2+a/2, -w/2, r/2+a/2);
      stick.addChild(shp);
      shp = createShape(LINE, w/2, -r/2+a/2, w/2, r/2+a/2);
      stick.addChild(shp);
  
      // arc lines to make 3D
      shp = createShape(ARC, 0, -r/2+a/2, w, 2*a, -PI, 0);
      stick.addChild(shp);
      shp = createShape(ARC, 0, -r/4+a/2, w, 2*a, -PI, 0);
      stick.addChild(shp);
      shp = createShape(ARC, 0, a/2, w, 2*a, -PI, 0);
      stick.addChild(shp);
      shp = createShape(ARC, 0, r/4+a/2, w, 2*a, -PI, 0);
      stick.addChild(shp);
  
      // bottom edge
      fill(#FCC263);
      shp = createShape(ARC, 0, r/2+a/2, w, 2*a, -PI, 0, CHORD);
      stick.addChild(shp);
      
      return stick;
    }
  
    // creates a flipped, baekdo stick
    private PShape stick3() {
      stick = createShape(GROUP);
  
      // base: regular flipped stick
      fill(#FCC263);
      stroke(#341100);
      stick.addChild(stick1());
  
      // red dot
      fill(#FF0000);
      noStroke();
      ellipseMode(CENTER);
      shp = createShape(ELLIPSE, 0, -a/2, a/2, a/2);
      stick.addChild(shp);
      
      return stick;
    }
    
    // draws stick
    private void drawShape(int i) {
      pushMatrix();
      translate(x, y);
      shape(sticks.get(i-1));
      popMatrix();
    }
  }
}