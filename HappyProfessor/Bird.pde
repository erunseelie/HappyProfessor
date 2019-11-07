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

    // load the sprite image for the Bird.
    this.sprite = loadImage("assets/owl.png");
    // resize the sprite image to the required boundaries.
    this.sprite.resize((int)this.w, (int)this.h);
  }

  // method to draw the Bird.
  void drawMe() {

    // color the Bird white.
    fill(255);

    //rect(this.x, this.y, this.w, this.h);
    image(this.sprite, this.x, this.y);
  }

  // method to move the Bird.
  void moveMe() {

    // apply "gravity" force, before adjusting the bird's height.
    this.yVel += this.yAcc;

    // move the Bird with any relevant modifiers.
    this.x += this.xVel;
    this.y += this.yVel;
  }

  boolean border() {
    if (this.y < 0) {
      this.yVel = 0; 
      this.y += 1; 
      return true;
    } else if (this.y > height || this.x < 0) {
      // TODO: this.die() method
      return true;
    } else return false;
  }
  
  //
  boolean checkCollision(GameEntity e) {
    if (e instanceof Pipe) {
      // A) detecting when the Bird is in a position that intersects with the vertical side of a Pipe.
      if (((this.x + this.w) >= e.x) && ((this.x + this.w) <= (e.x + 10)) && ((this.y + this.h) > e.y) && (this.y <= (e.y + e.h))) {
        this.xVel = -3;
        return true;
      }
      // B) detecting when the Bird is in a position that intersects with a downwards Pipe.
      else if (((this.x + this.w) >= e.x) && (this.x <= (e.x + e.w)) && ((this.y + this.h) > e.y) && ((this.y + this.h) <= (e.y + 20))) {
        this.y -= 1;
        this.yVel = 0;
        this.yAcc = 0;
        return true;
      } else if (((this.x + this.w) >= e.x) && (this.x <= (e.x + e.w)) && ((this.y < (e.y + e.h)) && (this.y >= (e.y + e.h - 20)))) {
        this.yVel = 0;
        return true;
      } else {
        // there is no collision, and we reset the bird's y-velocity and y-acceleration to their default values.
        this.xVel = (this.x < 300) ? 3 : 0;
        if (!isBeginning) this.yAcc = 0.5;
        return false;
      }
    }
    // if the Bird didn't hit a Pipe, did it hit the Item?
    else if (e instanceof Item) {
      if (((this.x + this.w) >= e.x) && ((this.x + this.w) <= (e.x + 10)) && ((this.y + this.h) > e.y) && (this.y <= (e.y + e.h))) {
        itemRespawn();
        return true;
      } else if (((this.x + this.w) >= e.x) && (this.x <= (e.x + e.w)) && ((this.y + this.h) > e.y) && ((this.y + this.h) <= (e.y + 20))) {

        itemRespawn();
        return true;
      } else if (((this.x + this.w) >= e.x) && (this.x <= (e.x + e.w)) && ((this.y < (e.y + e.h)) && (this.y >= (e.y + e.h - 20)))) {
        itemRespawn();
        return true;
      } else return false;
    }
    return false;
  }
}
