private float x;
private float y;
private float vx;
private float vy;

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
  
  // Create other methods to simplify the code in draw(), this is necessary for game draw().
  ellipseMoving();
}

public void reset()
{
  //player position reset
  x = 280;
  y = 80;
  vx = 0;
  vy = 0;
}

public void ellipseMoving()
{
  x += vx;
  y += vy;
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
      vx = 0;
    }
    if (keyCode==DOWN) 
    {
      vy = 10;
      vx = 0;
    }
    if (keyCode==LEFT) 
    {
      vx = -10;
      vy = 0;
    }
    if (keyCode==RIGHT) 
    {
      vx = 10;
      vy = 0;
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
