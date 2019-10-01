/* Things need to do
*  1. create rect(pipe) as an array.
*  2. create UI page.
*  3. create item as an array.
*  ************ FOR PIPE AND ITEM USE RANDOM DATA*******
*  4. find out where we can use loop || some other concepts.
*/


private int score;

private float x;
private float y;
private float vx;
private float vy;
private float ay;

private float pipeX, pipeY;
private float pipeVx;

/* Processing always starts with two methods: 
*  setup(): Initilize once the app is opened( Only once).
*  draw(): Update.
*  reset(): For game restart purpose, we always use reset() to reset data.
*/
public void setup() 
{
  reset(); 
  
  // Initilize the window size in setup().
  size(1048, 1024);
  
  // Disable the layer.
  noStroke();
}
  
  
/* A method that will keep running and updating the changes itself.
*  Img moving code part should be in here.
*  Img use the rule of stack. First img will be at the bottom of other img.
*/
public void draw() 
{ 
  background(51);
  
  // Set the following shape(s) to be filled with white. (fill can be used more than once to make each shape different color)
  fill(255);  
  rect(x, y, 50, 50);
  rect(pipeX,pipeY,50,400);
  
  // Create other methods to simplify the code in draw(), this is necessary for game draw().
  ellipseMoving();
  rectMoving();
  checkForCollision();
  updateScore();
  statBoard();
}

public void reset()
{
  //stats reset
  score = 0;
  
  //player position reset
  x = 280;
  y = 80;
  vx = 0;
  vy = 0;
  ay = 0.5;
  
  //rect position reset
  pipeX = 1000;
  pipeY = 400;
  pipeVx = -3;
}

public void ellipseMoving()
{
  x += vx;
  vy += ay;
  y += vy;
}

public void rectMoving()
{
  pipeX += pipeVx;
}

public void checkForCollision()
{
  if(((x + 50) >= pipeX && x <= (pipeX + 50)) && ((y + 50) > pipeY && y <= (pipeY + 400)))
  {
    vx = -3;
  }
  if(((x + 50) > pipeX && (y + 50) > pipeY) && (x < (pipeX + 50) && (y + 50) > pipeY))
  {
    //vy = 0;
    //ay = 0;
  }
  else recover();
}

public void recover()
{
  if(x < 280)
  {
    vx = 3;
  }
  else 
  {
    vx = 0;
    ay = 0.5;
  }
}

public void updateScore()
{
  //item: score += 100;
  score += 1;
}

public void statBoard()
{
  textSize(32);
  
  fill(204, 102, 0);
  text("X: " + x, 10, 30); 
  
  fill(0, 102, 153);
  text("Y: " + y, 10, 60);
  
  fill(204, 102, 0);
  text("Score: " + score, 10, 90);
}
  
  
/* Basic input that will update the data.
*  Only variables should be changed in side this method.
*  Img moving should be in draw() method.
*  If you want to update img outside draw(), you can use redraw().
*/
public void keyPressed() 
{ 
  if (key ==TAB || key== ENTER) 
  {
    reset();
  }
  if (key==CODED) 
  {
    if (keyCode==UP) 
    {
      vy = -10;
    }
  }
}

void keyReleased() 
{
  if (keyCode == UP || keyCode == DOWN) 
  {
    //
  }
}
