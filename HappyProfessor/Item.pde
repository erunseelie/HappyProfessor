private class Item extends GameEntity {
  private Item() {
    this.x = 1000;
    this.y = 350;
    this.w = 30;
    this.h = 30;
    this.xVel = 0;
  }

  private Item(float x, float y) {
    this.x = x;
    this.y = y;
    this.w = 30;
    this.h = 30;
    this.xVel = 0;
  }
  
  void drawMe() {
    // color the Pipe green.
    fill(255, 0, 0);
    rect(this.x, this.y, this.w, this.h);
  }
  
  void moveMe() {
    this.x += this.xVel;
  }
  
}
