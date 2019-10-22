/* To-Do List:
 *  1. create rect(pipe) as an array. (DONE)
 *  2. create UI page.
 *  3. create item as an array.
 *  ************ FOR PIPE AND ITEM USE RANDOM DATA*******
 *  4. find out where we can use loop || some other concepts.
 */

import java.awt.Rectangle;

// ==================================================
// Globals
// ==================================================

private boolean
  isBeginning;

private int 
  gameMoveSpeed = 3, 
  score;

private long
  timeLast = System.currentTimeMillis();

private ArrayList<Pipe> pipes;

private Bird bird;

// ==================================================
// Entities
// ==================================================

// abstract GameEntity class to be implemented by subclasses.
private abstract class GameEntity {

  // horizontal velocity.
  int xVel;

  // bounding-box to handle intersection collisions.
  // to instantiate a new Rectangle, use (x, y, w, h).
  Rectangle bb;

  // abstract methods to be implemented by subclasses.
  protected abstract void drawMe();

  // timeDelta is provided for future-proofing in the necessity of decoupling FPS from physics.
  // ignore unless stated otherwise.
  protected abstract void moveMe(float timeDelta);

  // return true if there is a collision.
  protected abstract boolean checkCollision(GameEntity e);

  // getters for location and dimensions.
  protected float getX() {
    return (float) this.bb.getX();
  }
  protected float getY() {
    return (float) this.bb.getY();
  }
  protected float getW() {
    return (float) this.bb.getWidth();
  }
  protected float getH() {
    return (float) this.bb.getHeight();
  }

  // setter for position.
  protected Rectangle setPos(float x, float y) {
    this.bb.setLocation((int)x, (int)y);
    return this.bb;
  }
}

// the player object, the moving Bird.
private class Bird extends GameEntity {

  // vertical velocity and acceleration attributes.
  float yVel, yAcc;

  // the Bird's in-game image.
  PImage sprite;

  // default constructor.
  private Bird() {

    // set initial Bird position.
    this.bb = new Rectangle(300, 80, 50, 50);
    this.xVel = 0;
    this.yVel = 0;
    this.yAcc = 0; // the "gravity" force.

    // load the sprite image for the Bird.
    this.sprite = loadImage("assets/owl.png");
  }

  // method to draw the Bird.
  void drawMe() {

    // color the Bird white.
    fill(255);

    // draw a rectangle to imitate the Bird's 
    rect(this.getX(), this.getY(), this.getW(), this.getH());
    image(this.sprite, this.getX(), this.getY());
  }

  // method to move the Bird.
  void moveMe(float timeDelta) {

    // apply "gravity" force, before adjusting the bird's height.
    this.yVel += this.yAcc;

    // update the location with the velocities applied.
    this.setPos(this.getX() + this.xVel, this.getY() + this.yVel);
  }

  // method to check if the Bird has hit either the top or bottom boundary.
  boolean border() {
    if (this.getY() < 0) {
      bird.yVel = 0; 
      this.setPos(this.getX(), this.getY() + 1);
      return true;
    }
    if (bird.getY() > height || bird.getX() < 0) {
      // die();
      return true;
    }
    return false;
  }

  // method to return the Bird to its original location.
  void recoverMe() {
    this.xVel = (this.getX() < 300) ? 3 : 0;
  }

  // method to check collision against various other GameEntity objects.
  boolean checkCollision(GameEntity e) {
    if (e instanceof Pipe) {
      // Pipe collision.
      if (this.bb.intersects(e.bb)) {
        this.xVel = -3;
        return true;
      } else {
        bird.recoverMe();
        if (!isBeginning) bird.yAcc = 0.5;
        return false;
      }
    } else {
      // no collision.
      return false;
    }
  }
}

// the obstacle object, termed Pipe for technical simplicity.
private class Pipe extends GameEntity {

  // default constructor.
  private Pipe() {
    this.bb = new Rectangle(width, 400, 50, 400);
    this.xVel = 0;
  }

  // constructor to instantiate a pipe with specified attributes.
  private Pipe(int x, int y, int h) {
    this.bb = new Rectangle(x, y, 50, h);
  }

  // method to draw the Pipe.
  void drawMe() {
    // set the drawing color to be green.
    fill(0, 255, 0);
    rect(this.getX(), this.getY(), this.getW(), this.getH());
  }

  // method to move the Pipe.
  void moveMe(float timeDelta) {
    this.setPos(this.getX() + this.xVel, this.getY());
    // if the Pipe goes off-screen, reset its position.
    if (this.getX() + this.getW() < 0) {
      respawn();
    }
  }

  // method to respawn the Pipe after it has gone off-screen.
  void respawn() {
    if (pipes.indexOf(this) % 2 == 0) {
      this.bb = new Rectangle(width, 0, 50, 100 + (int) Math.random() * 300);
    } else {
      this.bb = new Rectangle(
        width, 
        (int) pipes.get(pipes.indexOf(this) - 1).getH() + 200, 
        50, 
        700 - (int) pipes.get(pipes.indexOf(this) - 1).getH() - 200);
    }
  }

  // method to check whether a Pipe collides with anything else.
  // we shouldn't need to use this.
  boolean checkCollision(GameEntity e) {
    // TODO
    return false;
  }
}

private class Item extends GameEntity {
  private Item() {
  }

  void drawMe() {
    // TODO
  }
  void moveMe(float timeDelta) {
    // TODO
  }
  boolean checkCollision(GameEntity e) {
    if (e instanceof Bird) {
      // TODO
      return true;
    } else { 
      return false;
    }
  }
}

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

  reset();
}

public void reset() {
  // player score.
  score = 0;

  isBeginning = true;

  // create an empty player Bird entity.
  bird = new Bird();

  // create an empty Pipe list.
  pipes = new ArrayList<Pipe>();
  // create & add a new Pipe object to the list.
  pipes.add(new Pipe(1000, 0, 250));
  pipes.add(new Pipe(1000, 450, 250));
  pipes.add(new Pipe(1250, 0, 250));
  pipes.add(new Pipe(1250, 450, 250));
  pipes.add(new Pipe(1500, 0, 250));
  pipes.add(new Pipe(1500, 450, 250));
  pipes.add(new Pipe(1750, 0, 250));
  pipes.add(new Pipe(1750, 450, 250));
}

/* A method that will keep running and updating each time a new frame is drawn.
 *  Image-moving code should be placed in here.
 *  Images use the rule of stacks; each successive image is drawn "on top of" the previous images.
 */
public void draw() 
{ 
  // sets the background color.
  background(51);
  // draws a gradient color.
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(0, 0, 200), color(0, 200, 200), inter);
    stroke(c);
    line(0, i, width, i);
  }

  // adapted from: https://gamedev.stackexchange.com/a/97948
  // here in the event we need to decouple physics from framerate.
  long timeNow = System.currentTimeMillis();
  float timeDelta = 0.001 * (timeNow - timeLast);
  if (timeDelta <= 0 || timeDelta > 1.0) {
    timeDelta = 0.001;
  }

  for (Pipe p : pipes) {
    p.moveMe(timeDelta);
  }
  for (Pipe p : pipes) {
    if (bird.checkCollision(p)) break;
  }
  bird.moveMe(timeDelta);

  // call the Bird drawing method.
  bird.drawMe();
  bird.border(); // check if the bird dies due to border collision.
  for (Pipe p : pipes) {
    p.drawMe();
  }

  updateScore();
  statBoard();

  timeLast = timeNow;
}

// ==================================================
// UI
// ==================================================

public void updateScore()
{
  if (!isBeginning) {
    //item: score += 100;
    score += 1;
  }
}

public void statBoard()
{
  textSize(32);

  fill(204, 102, 0);
  text("X: " + bird.getX(), 10, 30); 

  fill(0, 102, 153);
  text("Y: " + bird.getY(), 10, 60);

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
      for (Pipe p : pipes) p.xVel = -3;
    }
  }
}

void keyReleased() 
{
  if (keyCode == UP || keyCode == DOWN) {
    // TODO
  }
}
