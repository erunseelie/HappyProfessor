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
private Item item;
private boolean isBeginning;
private ArrayList<Pipe> pipes;
private int itemSpawnPositionIndex;
private int timer;

// ==================================================
// Entities
// ==================================================

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

  itemSpawnPositionIndex = 0;
  item = new Item();

  // create an empty Pipe list.
  pipes = new ArrayList<Pipe>();
  
  // create & add a new Pipe object to the list.
  //Steudents part I.
  for(int i = 0; i <= 5; i++)
  {
    pipes.add(new Pipe(1000 + 250*i, 0, 250, 0));
    pipes.add(new Pipe(1000 + 250*i, 450, 250, 1));
  }
}

/* A method that will keep running and updating each time a new frame is drawn.
 *  Image-moving code should be placed in here.
 *  Images use the rule of stacks; each successive image is drawn "on top of" the previous images.
 */
public void draw() 
{ 
  // sets the background color.
  background(51);

  // draws a gradient "sky" background.
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(0, 0, 200), color(0, 200, 200), inter);
    stroke(c);
    line(0, i, width, i);
  }

  
  for (Pipe p : pipes) {
    if (bird.checkCollision(p)) break;
  }
  for (Pipe p : pipes) {
    p.moveMe();
    p.drawMe();
  }

  if (bird.checkCollision(item)){
    score += 5;
    itemRespawn();
  }
  if (item.x < 0) itemRespawn();
  item.moveMe();
  item.drawMe();

  bird.moveMe();
  // call the Bird drawing method.
  bird.drawMe();
  // check if bird die or not.
  bird.border();


  updateScore();
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

public void itemRespawn() {
  itemSpawnPositionIndex+=8;
  if (itemSpawnPositionIndex>11) {
    itemSpawnPositionIndex=itemSpawnPositionIndex%12;
  }
  item.x = pipes.get(itemSpawnPositionIndex).x + 10;
  item.y = pipes.get(itemSpawnPositionIndex).h + 100;
  System.out.println("Item respawned at: (" + item.x + ", " + item.y + ")");
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
      item.xVel = -3;
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
