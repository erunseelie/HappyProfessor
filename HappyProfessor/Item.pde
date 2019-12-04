private class Item extends GameEntity {
  
  PImage item;
  
  private Item() {
    this.x = 1000;
    this.y = 350;
    this.w = 50;
    this.h = 50;
    this.xVel = 0;
    this.item = loadImage("assets/crab.png");
    this.item.resize((int)this.w, (int)this.h);
  }

  private Item(float x, float y) {
    this.x = x;
    this.y = y;
    this.w = 50;
    this.h = 50;
    this.xVel = 0;
  }
  
  void drawMe() {
    // color the Pipe green.
    fill(255, 0, 0);
    image(this.item, this.x, this.y);
  }
  
  void moveMe() {
    this.x += this.xVel;
  }
  
}
