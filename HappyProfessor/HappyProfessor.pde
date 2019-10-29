/* To-Do List:
 *  1. create rect(pipe) as an array. (DONE)
 *  2. create UI page.
 *  3. create item as an array.
 *  ************ FOR PIPE AND ITEM USE RANDOM DATA*******
 *  4. find out where we can use loop || some other concepts.
 */

import java.awt.Rectangle;
import javafx.util.Pair;

// ==================================================
// Globals
// ==================================================

private boolean
  isBeginning;

private int 
  gameMoveSpeed = 3, 
  itemSpawnPositionIndex, 
  score, 
  timer;

private ArrayList<Pipe> pipes;
// list to hold all GameEntity objects for collision reference purposes.
// ensure to cleanly instantiate this for each new game session.
private static ArrayList<GameEntity> entities;

private Bird bird;
private Item item;

// ==================================================
// Processing methods
// ==================================================

/* Processing always starts with two methods: 
 *  setup(): Initialize any specified values when the app is first opened, only once.
 *  draw(): Visually update any objects based on possible new positions or values.
 *
 * Additionally, we use the reset() method:
 *  reset(): For game restart purposes, we always use reset() to reset data.
 */
public void setup() {
  // Initialize the window size in pixels.
  size(1000, 700);
  // Disables drawing objects' outline.
  noStroke();
  
  frameRate(60);

  reset();
}

public void reset() {
  // player score.
  score = 0;

  // prevents motion until the player hits a key to start the game.
  isBeginning = true;

  // from the GameEntity class. reset the list of all entities.
  entities = new ArrayList<GameEntity>();

  // create an empty player Bird entity.
  bird = new Bird();

  // create an empty Pipe list.
  pipes = new ArrayList<Pipe>();
  // create & add new Pipe objects to the list.
  pipes.add(new Pipe(1000, 0, 250));
  pipes.add(new Pipe(1000, 450, 250));
  pipes.add(new Pipe(1250, 0, 250));
  pipes.add(new Pipe(1250, 450, 250));
  pipes.add(new Pipe(1500, 0, 250));
  pipes.add(new Pipe(1500, 450, 250));
  pipes.add(new Pipe(1750, 0, 250));
  pipes.add(new Pipe(1750, 450, 250));
  pipes.add(new Pipe(2000, 0, 250));
  pipes.add(new Pipe(2000, 450, 250));
  pipes.add(new Pipe(2250, 0, 250));
  pipes.add(new Pipe(2250, 450, 250));

  // Item setup.
  itemSpawnPositionIndex = 0;
  item = new Item();
}

/* A method that will keep running and updating each time a new frame is drawn.
 * Image-moving code should be placed in here.
 * Images use the rule of stacks; each successive image is drawn "on top of" the previous images.
 */
public void draw() { 
  
  // sets the background color.
  background(51);
  // draws a gradient color for the background.
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(0, 0, 200), color(0, 200, 200), inter);
    stroke(c);
    line(0, i, width, i);
  }

  // move & draw Pipe objects.
  for (Pipe p : pipes) {
    p.moveMe();
    p.drawMe();
  }

  // move & the Item.
  item.moveMe();
  item.drawMe();

  // move the Bird.
  bird.moveMe();
  // draw the Bird.
  bird.drawMe();

  // update the player's score.
  updateScore();
  // draw the scoreboard.
  statBoard();
}

// ==================================================
// UI
// ==================================================

public void updateScore() {
  if (!isBeginning) {
    if (millis() - timer >= 1000) {
      score += 1;
      timer = millis();
    }
  }
}

public void statBoard() {
  textSize(32);

  fill(204, 102, 0);
  text("X: " + bird.r.getX(), 10, 30); 

  fill(0, 102, 153);
  text("Y: " + bird.r.getY(), 10, 60);

  fill(204, 102, 0);
  text("Score: " + score, 10, 90);
}

// ==================================================
// Inputs
// ==================================================

/* Basic input that will update the data.
 *  Only variables should be changed in side this method.
 *  Img moving should be in draw() method.
 *  If you want to update img outside draw(), you can use redraw().
 */
public void keyPressed() { 
  if (key == TAB || key == ENTER) {
    reset();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      bird.yVel = -10;
    }
    if (keyCode == UP && isBeginning) {
      isBeginning = false;
      bird.yAcc = 0.5;
      item.xVel = -3;
      for (Pipe p : pipes) p.xVel = -3;
    }
  }
}

void keyReleased() {
  if (keyCode == UP || keyCode == DOWN) {
    // TODO
  }
}

// ==================================================
// Debug
// ==================================================

private void log(String s) {
  System.out.println("[" + java.time.LocalTime.now() + "] " + s);
}
