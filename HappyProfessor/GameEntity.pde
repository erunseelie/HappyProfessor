private abstract class GameEntity {
  float x, xVel, y;
  float w, h;
  protected abstract void drawMe();
  protected abstract void moveMe();
}
