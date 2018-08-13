// determines color of and draws board pieces
void colorShapes() {
  for (Shape shp : shapes) {
    if (showSpaces && possSpaces.contains(shp)) {
      if (shp.equals(possSpaces.get(0)) || shp.isHovering()) {
        fill(#FFE603);  // selected space: yellow
      } else {
        fill(#FF8D00);  // possible spaces: orange
      }
    } else if (shp instanceof Rect) {
      if (shp.equals(throwMat)) {
        if (gameFinished() || !Mouse.isColor(0) || yutFrozen) {
          fill(#713609);  // default for throwing mat: dark brown
        } else if ((shp.isHovering() && mousePressed) || (keyPressed && key == ' ')) {
          fill(#FFE603); // selected throwing mat: yellow
        } else if (shp.isHovering()) {
          fill(#FF8D00);  // hovered throwing mat: orange
        } else {
          fill(#713609);  // default for throwing mat: dark brown
        }
      } else {
        if (((Player)shp).isFinished()) {
          fill(#FFE603);  // winner player: yellow
        } else if (shp.isHovering() && !malsFrozen && !gameFinished() && Mouse.isColor(0) && ((Player)shp).isAnyoneHome()) {
          fill(#FF8D00);  // hovering over shape: orange
        } else {
          fill(#713609);  // default for players: dark brown
        }
      }
    } else if (shp.isHovering() && !malsFrozen && !gameFinished() && Mouse.isColor(0) && ((Circ)shp).isOccupied()) {
      fill(#FF8D00);  // hovering over shape: orange
    } else if (((Circ)shp).R() == r1) {
      fill(#713609);  // default for big circles: dark brown
    } else {
      fill(#B46A31);  // default for small circles: light brown
    }
    if (!shp.equals(endCircle) || (possSpaces.contains(endCircle) && showSpaces)) {
      shp.drawShape();  // draws shape!
    }
  }
}

// draws all mals
void drawMals() {
  stroke(#341100);
  for (Player p : players) {
    p.drawSelectedMals();
  }
  for (Player p : players) {
    p.drawUnselectedMals();
  }
}

// draws yut sticks
void drawYutSticks() {
  for (YutStick stick : yutSticks) {
    stick.drawShape();
  }
}

// pick up mal if another mal is not currently selected
void pressAction() {
  if (!malsFrozen) {
    for (Shape shp : shapes) {
      if (shp.isHovering()) {
        pickUpMals(shp);
      }
    }
  }
  println(possMoves);
}

// allow mals to be released once dragged outside a space
void dragAction() {
  if (Mouse.pickedUp()) {
    boolean hover = false;
    for (Shape shp : shapes) {
      if (shp.isHovering() && possSpaces.contains(shp)) {
        hover = true;
      }
    }
    if (!hover) {
      Mouse.drop();
    }
  }
}

// when mouse is released, drop and kick out mals
void releaseAction() {
  if (throwMat.isHovering() && !gameFinished() && Mouse.isColor(0)) {
    throwYut();
  } else if (!Mouse.pickedUp()) {
    for (Shape shp : shapes) {
      if (shp.isHovering()) {
        kickOutMals(shp);
        dropMals(shp);
        groupMals(shp);
      }
    }
    if (gameFinished()) {
      malsFrozen = true;
      yutFrozen = true;
      clearYutText();
    } else if (!Mouse.pickedUp() && possMoves.size() == 1) {
      malsFrozen = true;
    }
  }
}

// throw yut sticks or reset game depending on key
void keyReleaseAction() {
  if (key == ' ') {
    if (!gameFinished() && Mouse.isColor(0)) {
      throwYut();
    } else if (gameFinished()) {
      reset();
      clearYutText();
    }
  }
  if (key == 'n') {
    reset();
    clearYutText();
  }
}

// sets mouse color to mal currently selected
void checkColor() {
  Mal m;
  Mouse.setColor(0);
  for (Player p : players) {
    for (int i = 0; i < p.malsSize(); i++) {
      m = p.findMalAt(i);
      if (m.isSelected()) {
        Mouse.setColor(m.C());
      }
    }
  }
}