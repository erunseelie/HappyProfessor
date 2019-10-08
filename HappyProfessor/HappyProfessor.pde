/* To-Do List:
 *  1. create rect(pipe) as an array. (DONE)
 *  2. create UI page.
 *  3. create item as an array.
 *  ************ FOR PIPE AND ITEM USE RANDOM DATA*******
 *  4. find out where we can use loop || some other concepts.
 */

// ==================================================
// Globals
// ==================================================

private int score;
private Bird bird;
private boolean isBeginning;
private ArrayList<Pipe> pipes;
private long timeLast = System.currentTimeMillis();
private int gameMoveSpeed = 3;

// ==================================================
// Entities
// ==================================================

private abstract class GameEntity {
  float x, xVel, y;
  float w, h;
  protected abstract void drawMe();
  protected abstract void moveMe(float timeDelta);
  // return true if there is a collision.
  protected abstract boolean checkCollision(GameEntity e);
}

private class Bird extends GameEntity {
  float yVel, yAcc;
  PImage sprite;
  // default constructor.
  private Bird() {
    this.x = 300;
    this.y = 80;
    this.w = 50;
    this.h = 50;
    this.xVel = 0;
    this.yVel = 0;
    this.yAcc = 0; // the "gravity" force.
    this.sprite = loadImage("assets/noctowl.png");
  }
  // method to draw the Bird.
  void drawMe() {
    // color the Bird white.
    fill(255);
    rect(this.x, this.y, this.w, this.h);
    image(this.sprite, this.x, this.y);
  }
  // method to move the Bird.
  void moveMe(float timeDelta) {
    this.x += this.xVel;
    // apply "gravity" force, before adjusting the bird's height.
    this.yVel += this.yAcc;
    this.y += this.yVel;
  }
  void recoverMe() {
    this.xVel = (this.x < 300) ? 3 : 0;
  }
  boolean checkCollision(GameEntity e) {
    if (e instanceof Pipe) {
      // TODO
      // A) detecting when the bird is in a position that intersects with an upwards pipe.
      if (((bird.x + bird.w) >= e.x) && ((bird.x + bird.w) <= (e.x + 10)) && ((bird.y + bird.h) > e.y) && (bird.y <= (e.y + e.h))) {
        // if...
        // 1) bird's right edge is past the pipe's left edge;
        // 2) bird's left edge is ahead of the pipe's right edge;
        // 3) bird's base is below the pipe's roof;
        // 4) bird's roof is above the pipe's base...
        bird.xVel = -3;
        return true;
      } else if (((bird.x + bird.w) >= e.x) && (bird.x <= (e.x + e.w)) && ((bird.y + bird.h) > e.y) && ((bird.y + bird.h) <= (e.y + 10))) {
        // dont know should use 'else if' or 'if'  MAY CAUSE BUG ISSUE.
        bird.yVel = 0;
        bird.yAcc = 0;
        return true;
      } else {
        // there is no collision, and we reset the bird's x-velocity and y-acceleration to their default values.
        bird.recoverMe();
        if(!isBeginning) bird.yAcc = 0.5;
        return false;
      }
    } else if (e instanceof Item) {
      // TODO
      return false;
    } else return false;
  }
}

private class Pipe extends GameEntity {
  // default constructor.
  // TODO: add alternate constructors for random pipe placement.
  // TODO: add capability for downward-facing pipes.
  private Pipe() {
    this.x = 1000;
    this.y = 400;
    this.w = 50;
    this.h = 400;
    this.xVel = 0;
  }
  private Pipe(int x) {
    this();
    this.x = x;
  }
  private Pipe(int x, int y, int h) {
    this();
    this.x = x;
    this.y = y;
    this.h = h;
  }
  // method to draw the Pipe.
  void drawMe() {
    // color the Pipe green.
    fill(0, 255, 0);
    rect(this.x, this.y, this.w, this.h);
  }
  // method to move the Pipe.
  void moveMe(float timeDelta) {
    this.x += this.xVel;
    // if the Pipe goes off-screen, reset its position.
    // TODO: possibly, randomize its position and size accordingly.
    if (this.x + this.w < 0) {
      respawn();
    }
  }

  void respawn(){
  if(pipes.indexOf(this) % 2 == 0)
      {
        this.x = 1000;
        this.w = 50;
        this.h = 100 + (float)Math.random() * 300;
        this.y = 0;
      }
      else
      {
        this.x = 1000;
        this.w = 50;
        this.h = 700 - pipes.get(pipes.indexOf(this) - 1).h - 200;
        this.y = pipes.get(pipes.indexOf(this) - 1).h + 200;
      }
  }
  boolean checkCollision(GameEntity e) {
    // TODO
    return false;
  }
}

private class Item extends GameEntity {
  void drawMe() {
    // TODO
  }
  void moveMe(float timeDelta) {
    // TODO
    this.x -= gameMoveSpeed;
  }
  boolean checkCollision(GameEntity e) {
    // TODO
    if (e instanceof Bird) {
      bird = (Bird) e;
      return true;
    }
    else return false;
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
    if(!isBeginning) {
  //item: score += 100;
  score += 1;
  }
}

public void statBoard()
{
  textSize(32);

  fill(204, 102, 0);
  text("X: " + bird.x, 10, 30); 

  fill(0, 102, 153);
  text("Y: " + bird.y, 10, 60);

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
      for(Pipe p: pipes) p.xVel = -3;
    }
  }
}

void keyReleased() 
{
  if (keyCode == UP || keyCode == DOWN) {
    // TODO
  }
}
