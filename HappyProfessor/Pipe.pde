// the obstacle object, termed Pipe for technical simplicity.
private class Pipe extends GameEntity {

  // default constructor.
  private Pipe() {
    super(width, 400, 50, 400);

    // set the Pipe to move as fast as the game's movement speed.
    this.xVel = -1 * gameMoveSpeed;
  }

  // constructor to instantiate a pipe with specified attributes.
  private Pipe(int x, int y, int h) {
    this();
    this.r.resizeMe(h);
    this.r.placeMe(x, y);
  }

  // method to draw the Pipe.
  void drawMe() {
    // set the drawing color to be green.
    fill(0, 255, 0);
    rect(this.r.getX(), this.r.getY(), this.r.getW(), this.r.getH());
    
    //this.r.drawMe();
  }

  // method to move the Pipe.
  boolean moveMe() {
    
    // move bounding box.
    this.r.moveMe(this.xVel, 0);
    
    // if the Pipe goes off-screen, reset its position.
    if (this.r.getX() + this.r.getW() < 0) {
      this.respawnMe();
    }
    return false;
  }

  // method to respawn the Pipe after it has gone off-screen.
  void respawnMe() {
    if (pipes.indexOf(this) % 2 == 0) { // if the Pipe is downward-facing:
      this.r.resizeMe(100 + (int) (Math.random() * 300));
      this.r.moveMe(width + 450, 0);
    } else { // if the Pipe is upward-facing:
      this.r.resizeMe(700 - (int) pipes.get(pipes.indexOf(this) - 1).r.getH() - 200);
      this.r.moveMe(width + 450, (int) pipes.get(pipes.indexOf(this) - 1).r.getH() + 200);
    }
  }
}
