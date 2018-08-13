String[] yutnori = {"baekdo", "do", "gae", "geol"};
String[] moves = new String[3];
int prevMove = 0;
int numYut = 0;
int numMo = 0;
boolean malsFrozen = true;
boolean yutFrozen = false;
boolean throwAgain = false;

// throwing sticks
void throwYut() {
  throwAgain = false;
  if (!yutFrozen) {
    int num = throwValue();
    prevMove = num;
    if (num == 4) {
      numYut++;  // yut case
      moves[0] = "";
      if (numYut == 1) {
        moves[1] = "yut";
      } else if (numYut > 1) {
        moves[1] = "yut x" + numYut;
      }
    } else if (num == 5) {
      numMo++;  // mo case
      moves[0] = "";
      if (numMo > 1) {
        moves[2] = "mo x" + numMo;
      } else if (numMo == 1) {
        moves[2] = "mo";
      }
    } else {
      if (num == -1) {  // baekdo case
        num = 0;
      }
      moves[0] = yutnori[num];  // all non-yut/mo cases
    }
    malsFrozen = false;
    if (!moves[0].equals("") && !moves[0].equals(yutnori[0])) {
      yutFrozen = true;
    }
  }
}

// update moves according to yut text
void addPossMoves() {
  possMoves.clear();
  possMoves.add(0);  // add self
  
  // add baekdo/do/gae/geol
  if (moves[0].equals(yutnori[0])) {
    possMoves.add(-1);
  } else {
    for (int i = 1; i < yutnori.length; i++) {
      if (moves[0].equals(yutnori[i])) {
        possMoves.add(i);
        break;
      }
    }
  }
  
  // add yut and mo
  if (numYut > 0) {
    possMoves.add(4);
  }
  if (numMo > 0) {
    possMoves.add(5);
  }
}

// when mal is moved, remove corresponding move
void removePossMoves(Shape shp) {
  int index = allSpaces.get(shapes.indexOf(possSpaces.get(0))).indexOf(shp);
  
  // when mal finishes, loop to find lowest move to remove
  if (shp.equals(endCircle)) {
    while(!possMoves.contains(index) && index < 5) {
      index++;
    }
  }
  
  if (index >= 6) {
    possMoves.remove(possMoves.indexOf(-1));  // baekdo case
    moves[0] = "";
  } else if (index != 0) {
    if (index == 4) {  // yut case
      numYut--;
      if (numYut == 0) {
        moves[1] = "";
        possMoves.remove(possMoves.indexOf(index));
      } else if (numYut == 1) {
        moves[1] = "yut";
      } else {
        moves[1] = "yut x" + numYut;
      } 
    } else if (index == 5) {  // mo case
      numMo--;
      if (numMo == 0) {
        moves[2] = "";
        possMoves.remove(possMoves.indexOf(index));
      } else if (numMo == 1) {
        moves[2] = "mo";
      } else {
        moves[2] = "mo x" + numMo;
      }
    } else {  // do/gae/geol case
      moves[0] = "";
      possMoves.remove(possMoves.indexOf(index));
    }
  }
  if ((moves[0].equals("") || moves[0].equals(yutnori[0]))) {
    yutFrozen = false;
  }
}

// calculate value when yut sticks thrown
int throwValue() {
  int num = 0;
  for (YutStick stick : yutSticks) {
    stick.throwStick();
    if (stick.isFlipped()) {
      if (stick.equals(yutSticks.get(3)) && num == 0) {
        num = -1;  // baekdo case
      } else {
        num++;  // count number of flipped
      }
    }
  }
  if (num == 0) {
    num = 5;  // mo case
  }
  return num;
}

// update spaces according to moves
void updateSpaces(Shape shp) {
  possSpaces.clear();
  for (int i = 0; i < allSpaces.get(shapes.indexOf(shp)).size(); i++) {
    if (possMoves.contains(i)) {
      possSpaces.add(allSpaces.get(shapes.indexOf(shp)).get(i));
    }
  }
  if (possMoves.contains(-1) && !(shp instanceof Rect)) {  // baekdo case
    for (int i = 6; i < allSpaces.get(shapes.indexOf(shp)).size(); i++) {
      possSpaces.add(allSpaces.get(shapes.indexOf(shp)).get(i));
    }
  }
}
  

// show viable moves
void yutText() {
  fill(255);
  textSize(50);
  for (int i = 0; i < moves.length; i++) {
    if (moves[i] != null) {
      text(moves[i], s1/4+c/2+r2/4+sx/2, s2/2 + (sx/2-s2+c+r2)/2 + 60*(i+1));
    }
  }
}

// clear yut text at end of game
void clearYutText() {
  // reset yut text 
  numYut = 0;
  numMo = 0;
  for (int i = 0; i < moves.length; i++) {
    moves[i] = "";
  }
}