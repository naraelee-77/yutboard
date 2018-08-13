/** FIXME: 
  hangeul unicode by yut values 
  sound and visual effects
  check color method is obsolete
  allow different numbers of players (menu at new game)
  reset/new game, help button
  add nak possibility
  enumerations for player colors
  pick up mal when click anywhere within current shape
  change end circle location depending on branch taken
  double click to make mal go to default position
  add undo button
  let multiple moves be done at once
 */
  
import java.util.List;
import java.util.Random;
import java.util.Arrays;

// run once at beginning
void setup() {
  size(1100, 690);
  rectMode(CENTER);
  textAlign(CENTER);
  boardCircles();
  makeYutSticks();
  makePlayers();
  organize();
  printStuff();
  println("\n");
}

// run over and over again, always
void draw() {
  background(#E5B77B);
  stroke(#341100);
  colorShapes();
  drawYutSticks();
  yutText();
  drawMals();
}

// run each time mouse button is pressed
void mousePressed() {
  pressAction();
  checkColor();
}

// run over and over again when mouse button is dragged
void mouseDragged() {
  dragAction();
}

// run each time mouse button is released
void mouseReleased() {
  releaseAction();
  checkColor();
}

// run each time key released
void keyReleased() {
  keyReleaseAction();
}