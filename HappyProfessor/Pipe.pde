private class Pipe extends GameEntity {
  PImage pipe;
  
  // default constructor.
  private Pipe() {
    this.x = 1000;
    this.y = 400;
    this.w = 50;
    this.h = 400;
    this.xVel = 0;
  }

  // overloaded constructor for defined Pipe location.
  private Pipe(int x) {
    this();
    this.x = x;
  }

  // overloaded constructor for defined Pipe location and size.
  private Pipe(int x, int y, int h, int indexOfPair) {
    this();
    this.x = x;
    this.y = y;
    this.h = h;
    if(indexOfPair % 2 == 0)
    {
      this.pipe = loadImage("assets/downTree.png");
      this.pipe.resize((int)this.w + 30, (int)this.h + 20);
    }
    else
    {
      this.pipe = loadImage("assets/upTree.png");
      this.pipe.resize((int)this.w + 30, (int)this.h + 20);
    }
  }

  // method to draw the Pipe.
  void drawMe() {
    // color the Pipe green.
    fill(0, 255, 0);
    // draw a rectangle according to the Pipe's dimensions.
    image(this.pipe, this.x, this.y);
  }

  // method to move the Pipe.
  void moveMe() {
    this.x += this.xVel;
    // if the Pipe goes off-screen, reset its position.
    if (this.x + this.w < 0) {
      this.respawn();
    }
  }

  // respawns the Pipe object.
  void respawn() {
    if (pipes.indexOf(this) % 2 == 0) {
      this.x = 1450;
      this.w = 50;
      this.h = 100 + (float)Math.random() * 300;
      this.y = 0;
      this.pipe.resize((int)this.w + 30, (int)this.h + 20);
    } else {
      this.x = 1450;
      this.w = 50;
      this.h = 700 - pipes.get(pipes.indexOf(this) - 1).h - 200;
      this.y = pipes.get(pipes.indexOf(this) - 1).h + 200;
      this.pipe.resize((int)this.w + 30, (int)this.h + 20);
    }
  }
}
