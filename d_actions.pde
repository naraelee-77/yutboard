// pick up mals and calculate moves and spaces accordingly
void pickUpMals(Shape shp) {
  Mal m;
  Mouse.drop();
  for (Player p : players) {
    for (int i = 0; i < p.malsSize(); i++) {
      m = p.findMalAt(i);
      if (m.pickUppable()) {
        Mouse.pickUp();
      }
      m.pickUpAction(shp);
    }
  }
  if (Mouse.pickedUp()) {
    addPossMoves();
    updateSpaces(shp);
    showSpaces = true;
  }
}

// drop mals and calculate moves and spaces accordingly
void dropMals(Shape shp) {
  Mal m;
  Mouse.pickUp();
  for (Player p : players) {
    for (int i = 0; i < p.malsSize(); i++) {
      m = p.findMalAt(i);
      if (m.droppable(shp)) {
        Mouse.drop();
        m.dropAction(shp);
      }
    }
  }
  if (!Mouse.pickedUp()) {
    removePossMoves(shp);
    updateSpaces(possSpaces.get(0));
    showSpaces = false;
  }
}

// kick out mals if other team's mals released on them
void kickOutMals(Shape shp) {
  if (shp instanceof Circ && !Mouse.isColor(0) && possSpaces.contains(shp)) {
    Mal m;
    for (Player p : players) {
      for (int i = 0; i < p.malsSize(); i++) {
        m = p.findMalAt(i);
        m.kickOutAction(shp);
      }
    }
  }
}

// update how many mals on the shape
void groupMals(Shape shp) {
  int grouped = 0;
  Mal m;
  for (Player p : players) {
    for (int i = 0; i < p.malsSize(); i++) {
      m = p.findMalAt(i);
      if (m.isOnShape(shp)) {
        grouped++;  // get number grouped
        m.setGroup(grouped);  // set number grouped
      }
    }
  }
}

// check if any players are finished
boolean gameFinished() {
  for (Player p : players) {
    if (p.isFinished()) {
      return true;
    }
  }
  return false;
}

// reset for new game
void reset() {
  Mouse.drop();
  
  // reset mals and yut sticks
  Mal m;
  for (Player p : players) {
    for (int i = 0; i < p.malsSize(); i++) {
      m = p.findMalAt(i);
      m.reset();
    }
  }
  for (YutStick yut : yutSticks) {
    yut.reset();
  }
  
  for (Shape shp : shapes) {
    if (shp instanceof Circ) {
      ((Circ)shp).deoccupy();
    }
  }
  
  // reset moves and spaces
  possMoves.clear();
  possSpaces.clear();
  malsFrozen = true;
  yutFrozen = false;
}