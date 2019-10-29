// the player object, the moving Bird.
private class Bird extends GameEntity {

  private PShape vector;

  // vertical velocity and acceleration attributes.
  private float yVel, yAcc;

  // default constructor.
  private Bird() {

    super(300, 80, 50, 50);
    entities.remove(this); // don't test the bird's collision against itself.
    this.yVel = 0;
    this.yAcc = 0; // the "gravity" force.

    // load the sprite image for the Bird.
    this.sprite = loadImage("assets/owl.png");
    this.vector = loadShape("assets/owl.svg");
    this.vector.enableStyle();
  }

  // method to move the Bird.
  boolean moveMe() {

    // if the Bird is too far left, adjust its velocity.
    this.xVel = (this.r.getX() < 300) ? 3 : 0;
    // apply "gravity" force, before adjusting the Bird's height.
    this.yVel += this.yAcc;

    Pair<GameEntity, Character> p = this.checkCollision();
    // if there's nothing there, move & stop testing now.
    if (p == null) {
      this.r.moveMe(this.xVel, (int) this.yVel);
      return true;
    }

    GameEntity e = p.getKey();
    char side = p.getValue();

    if (e instanceof Item) {
      if (side != 'n') {
        log("Collected item.");
        Item i = (Item) e;
        i.respawnMe();
        return false;
      }
    } else if (e instanceof Pipe) {
      if (side == 'n' || side == 'r') {
        // if there's nothing there, go ahead and update the position.
        this.r.moveMe(this.xVel, (int) this.yVel);
        //log("Moved bird.");
        return false;
      } else {
        if (side == 'l') { // hit a left wall.
          log("Hit left side.");
          this.r.moveMe(-1 * gameMoveSpeed, (int) this.yVel);
          return true;
        } else if (side == 't') { // hit a top wall.
          log("Hit top side.");
          this.yVel = 0;
          this.r.moveMe(0, -1);
          return true;
        } else if (side == 'b') {
          // hit a bottom wall.
          log("Hit bottom side.");
          this.yVel = 0;
          this.r.moveMe(0, 1);
          return true;
        } else return false;
      }
    } 
    return false;
  }

  // method to check if the Bird has hit either the top or bottom boundary.
  boolean checkBorders() {
    if (this.r.getY() < 0) {
      this.yVel = 0; 
      this.r.placeMe(this.r.getX(), this.r.getY() + 1);
      return true;
    }
    if (this.r.getY() > height || this.r.getX() < 0) {
      // die();
      return true;
    }
    return false;
  }

  // method to draw the Bird.
  void drawMe() {

    // color the Bird white.
    fill(255);

    // draw a rectangle to imitate the Bird's bounding box.
    rect(this.r.getX(), this.r.getY(), this.r.getW(), this.r.getH());
    //image(this.sprite, this.r.getX(), this.r.getY());
    shape(this.vector, this.r.getX(), this.r.getY());

    //this.r.drawMe();
  }
}
