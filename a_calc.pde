final int s1 = 1000;  // screen width (# of pixels)
final int s2 = 550;  // screen height (# of pixels)
final int sx = 1100;  // true screen width
final int sy = 690;  // true screen height
final int r1 = 80;  // 2*radius of big circles
final int r2 = 50;  // 2*radius of small circles
final int c = 200;  // distance between center and corner
final int h = 100;  // height of platform
int numPlayers;
List<Player> players = new ArrayList<Player>();  // list of players (blue, red, green)
List<YutStick> yutSticks = new ArrayList<YutStick>();  // list of yut sticks
List<Shape> shapes = new ArrayList<Shape>();  // full list of board shapes (circ, rect)
Rect throwMat;
Circ endCircle;

// place yut sticks
void makeYutSticks() {
  YutStick y;
  for (int l = 0; l < 4; l++) {
    y = new YutStick(s1/4+sx/4+s2/2+3*r1/4-3*r2/4+l*(sx/2-s2+c-3*r1/2+2*r2)/3, s2/2, r1/2, sx/2-s2+c+r2-r1);
    yutSticks.add(y);
    y.setHome(throwMat);
    if (l == 3) {
      y.makeBaekdo();  // assign baekdo status to last one
    }
  }
}

// rectangles on board
void makePlayers() {
  Player p;
  numPlayers = 2;
  if (numPlayers >= 2 && numPlayers <= 4) {
    // blue mals (self)
    p = new Player(s1/2, s2+h/2, 2*c, h);
    shapes.add(p);
    players.add(p);
    p.setColor(#111EF2);  // blue
    for (int i = 0; i < 4; i++) {
      p.addMal(new Mal(s1/2-c+h/2+i*(2*c-h)/3, s2+h/2));
    }
    if (numPlayers == 2) {  // one player along left side for 2 players
      //// red mals (other)
      //p = new Player(s2/2-h, s2/2, h, 2*c);
      //shapes.add(p);
      //players.add(p);
      //p.setColor(#F00000);  // red
      //for (int i = 0; i < 4; i++) {
      //  p.addMal(new Mal(s2/2-h, s2/2+h/2-c+i*(2*c-h)/3));
      //}
      
      // red mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#F00000);  // red
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2-c/2+r1/8+h/2+j*(c-r1/4-h)));
        }
      }
    } else if (numPlayers == 3) {
      // red mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2-c/2-r1/8, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#F00000);  // red
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2-c+h/2+j*(c-r1/4-h)));
        }
      }
    
      // green mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2+c/2+r1/8, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#00E010);  // green
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2+r1/4+h/2+j*(c-r1/4-h)));
        }
      }
    } else if (numPlayers == 4) {  // two players along left side for 3 or 4 players
      // red mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2-c/2-r1/8-r1/2, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#F00000);  // red
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2-c-r1/2+h/2+j*(c-r1/4-h)));
        }
      }
    
      // green mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2+c/2+r1/8-r1/2, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#00E010);  // green
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2+r1/4-r1/2+h/2+j*(c-r1/4-h)));
        }
      }
      
      // purple mals (other)
      p = new Player(s1/4-r1/4-c/2, s2/2+c/2+r1/8+c+r1/4-r1/2, s1/2-s2+c+r1/2, c-r1/4);
      shapes.add(p);
      players.add(p);
      p.setColor(#B702D3);  // purple
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          p.addMal(new Mal(s2/2-c-r1/2+h/2+i*(s1/2-s2+c+r1/2-h), s2/2+r1/4+c+r1/4-r1/2+h/2+j*(c-r1/4-h)));
        }
      }
    }
  }
  
  // throwing mat
  throwMat = new Rect(s1/4+c/2+r2/4+sx/2, s2/2, sx/2-s2+c+2*r2, sx/2-s2+c+r2);
  shapes.add(throwMat);
}

void boardCircles() {
  // right edge
  for (int i = 3; i >= 0; i--) {
    shapes.add(new Circ(s1/2+c, s2/2-3*c/5+3*r1/10-3*r2/10+i*(2*c-r1+r2)/5, r2));
  }
  shapes.add(new Circ(s1/2+c, s2/2-c, r1));
  
  // top edge
  for (int i = 3; i >= 0; i--) {
    shapes.add(new Circ(s1/2-3*c/5+3*r1/10-3*r2/10+i*(2*c-r1+r2)/5, s2/2-c, r2));
  }
  shapes.add(new Circ(s1/2-c, s2/2-c, r1));
  
  // left edge
  for (int i = 0; i < 4; i++) {
    shapes.add(new Circ(s1/2-c, s2/2-3*c/5+3*r1/10-3*r2/10+i*(2*c-r1+r2)/5, r2));
  }
  shapes.add(new Circ(s1/2-c, s2/2+c, r1));
  
  // bottom edge
  for (int i = 0; i < 4; i++) {
    shapes.add(new Circ(s1/2-3*c/5+3*r1/10-3*r2/10+i*(2*c-r1+r2)/5, s2/2+c, r2));
  }
  shapes.add(new Circ(s1/2+c, s2/2+c, r1));
  
  // / diagonal
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 2; j++) {
      shapes.add(new Circ(s1/2+2*c/3-c*i-r1/6+r2/6-j*(c-r1+r2)/3, s2/2-2*c/3+c*i+r1/6-r2/6+j*(c-r1+r2)/3, r2));
    }
  }
  
  // \ diagonal
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 2; j++) {
      shapes.add(new Circ(s1/2-2*c/3+c*i+r1/6-r2/6+j*(c-r1+r2)/3, s2/2-2*c/3+c*i+r1/6-r2/6+j*(c-r1+r2)/3, r2));
    }
  }
  
  // center
  shapes.add(new Circ(s1/2, s2/2, r1));
  
  // end
  endCircle = new Circ(s1/2-2*c/3+2*c+r1/6-r2/6, s2/2-2*c/3+2*c+r1/6-r2/6, r2);
  shapes.add(endCircle);
}  

// print coordinates of shapes placed
void printStuff() {
  int k = 0;
  for (Shape shp: shapes) {
    print(k + ": " + shp + "\t");
    if (k % 5 == 4) {  // next line
      println();
    }
    k++;
  }
}