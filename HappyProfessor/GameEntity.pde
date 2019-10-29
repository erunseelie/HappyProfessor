// abstract GameEntity class to be implemented by subclasses.
public abstract class GameEntity {

  protected GameRectangle r;

  // horizontal velocity.
  protected int xVel;

  // the Object's in-game image.
  protected PImage sprite;

  protected GameEntity(int x, int y, int w, int h) {
    this.r = new GameRectangle(x, y, w, h);
    this.xVel = 0;
    HappyProfessor.entities.add(this);
  }
  
  // checks whether this entity will collide with any other.
  // returns the GameEntity if so.
  protected Pair<GameEntity, Character> checkCollision() {
    for (GameEntity e : HappyProfessor.entities) {
      for (BoundingBox bOther : e.r.boxes) {
        for (BoundingBox bMine : this.r.boxes) {
          if (bMine.intersects(bOther)) {
            return new Pair<GameEntity, Character>(e, bOther.getSide());
          }
        }
      }
    }
    return null;
  }

  public String toString() {
    return this.getClass().getName();
  }
}

protected class GameRectangle {

  // the basic boundary rectangle.
  Rectangle r;
  // the 4 bounding-box 'walls' of the rectangle.
  BoundingBox wallB, wallL, wallR, wallT;
  // the width of the bounding-boxes.
  private final int bbWidth = 3;
  // and, the list to contain them for iteration procedures.
  ArrayList<BoundingBox> boxes;

  // constructs a new rectangle object and boundary rects.
  public GameRectangle(int x, int y, int w, int h) {

    this.r = new Rectangle(x, y, w, h);

    // create new empty list to hold the bounding boxes for the Pipe.
    this.boxes = new ArrayList<BoundingBox>();
    // then, fill it with the BB's.
    this.wallB = new BoundingBox('b', new Rectangle(this.getX(), this.getY()+this.getH()-bbWidth, this.getW(), bbWidth));
    boxes.add(this.wallB);
    this.wallL = new BoundingBox('l', new Rectangle(this.getX(), this.getY(), bbWidth, this.getH()));
    boxes.add(this.wallL);
    this.wallR = new BoundingBox('r', new Rectangle(this.getX()+this.getW()-bbWidth, this.getY(), bbWidth, this.getH()));
    boxes.add(this.wallR);
    this.wallT = new BoundingBox('t', new Rectangle(this.getX(), this.getY(), this.getW(), bbWidth));
    boxes.add(this.wallT);
  }

  // getters for bounding-box location and dimensions.
  public int getX() {
    return (int) this.r.getX();
  }
  public int getY() {
    return (int) this.r.getY();
  }
  public int getW() {
    return (int) this.r.getWidth();
  }
  public int getH() {
    return (int) this.r.getHeight();
  }

  // method to translate the GameRectangle and its BoundingBoxes.
  public GameRectangle moveMe(int x, int y) {
    this.r.translate(x, y);
    for (BoundingBox b : boxes) {
      b.move(x, y);
    }
    return this;
  }

  // setter for position.
  public GameRectangle placeMe(int x, int y) {
    this.r.setLocation(x, y);
    this.wallB.place(x, this.getH() + y);
    this.wallL.place(x, y);
    this.wallR.place(this.getW() + x, y);
    this.wallT.place(x, y);
    return this;
  }

  // resizes this object and moves its boundary objects accordingly.
  public GameRectangle resizeMe(int h) {
    this.r.setSize(this.getW(), h);
    this.wallB.place(this.getX(), this.getY() + this.getH());
    this.wallL.resize(h);
    this.wallL.place(this.getX(), this.getY());
    this.wallR.resize(h);
    this.wallR.place(this.getX() + this.getW(), this.getY());
    this.wallT.place(this.getX(), this.getY());
    return this;
  }

  public void drawMe() {
    // fill and draw the basic rectangle bounds.
    fill(0, 255, 0);
    rect(getX(), getY(), getW(), getH());
    // then, draw the bounding-boxes atop that.
    for (BoundingBox b : boxes) {
      b.drawMe();
    }
  }
}

// rectangles that will be placed on the borders of the GameEntity rectangles.
// used to detect collision.
private class BoundingBox {
  private Rectangle r;
  private char side;

  public BoundingBox(char side, Rectangle r) {
    this.side = side;
    this.r = r;
  }

  public Rectangle getBox() {
    return this.r;
  }

  public char getSide() {
    return this.side;
  }

  public boolean intersects(BoundingBox b) {
    return this.r.intersects(b.r);
  }

  public void drawMe() {
    fill(255, 255, 0, 200);
    rect((float) r.getX(), (float) r.getY(), (float) r.getWidth(), (float) r.getHeight());
  }

  public BoundingBox place(int x, int y) {
    this.r.setLocation(x, y);
    return this;
  }

  public BoundingBox move(int x, int y) {
    this.r.translate(x, y);
    return this;
  }
  
  public BoundingBox resize(int h) {
    this.r.setSize((int) this.r.getWidth(), h);
    return this;
  }
}
