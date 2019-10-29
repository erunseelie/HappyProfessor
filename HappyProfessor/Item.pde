private class Item extends GameEntity {

  // default constructor.
  private Item() {
    super(width, 350, 30, 30);
    this.xVel = -1 * gameMoveSpeed;
  }

  // constructor with specified location.
  private Item(int x, int y) {
    this();
    this.r.placeMe(x, y);
  }

  // method to draw the Item.
  void drawMe() {
    
    // color the Item red.
    fill(255, 0, 0);
    rect(this.r.getX(), this.r.getY(), this.r.getW(), this.r.getH());
    
    //this.r.drawMe();
  }
  
  void moveMe() {
    this.r.moveMe(this.xVel, 0);
    if (this.r.getX() < 0) this.respawnMe();
  }

  // method to respawn the Item after it has been collected or moved off-screen.
  void respawnMe() {
    itemSpawnPositionIndex += 8;
    if (itemSpawnPositionIndex >= 12) {
      itemSpawnPositionIndex %= 12;
      this.r.placeMe(pipes.get(itemSpawnPositionIndex).r.getX() + 10, pipes.get(itemSpawnPositionIndex).r.getH() + 100);
      System.out.println("Item respawn success. Position of item is : (" + this.r.getX() + ", " + this.r.getY() + ").");
    }
  }
}
