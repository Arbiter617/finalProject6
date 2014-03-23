class Bubble
{
  float xLoc,yLoc;
  float diameter;
  
  float theta;
  
  // Used for bubble emitters.
  float speedX,speedY;
  
  public Bubble (float a, float b)
  {
    xLoc = a;
    yLoc = b;
    diameter = random (3,8);
    
    theta = random(0,2*PI);
    
    speedX = 0;
    speedY = 0;
  }
  
  // Arguments are for left, right, and bottom bound of where bubbles shall generate.
  public void showBubble (float l, float r, float b)
  {
    xLoc+= .05*diameter*sin(theta);
    
    if (yLoc < 1)
    {
      yLoc = b;
      xLoc = random (l,r);
    }
    noFill();
    strokeWeight(1);
    stroke(0,0,100,40-yLoc/150);
    ellipse(xLoc,yLoc,diameter,diameter);
    
    theta+=.01*diameter;
    yLoc-= 2.2 - .18*diameter;
    
    xLoc+=speedX;
    yLoc+=speedY;
  }
  
  // Slows down the speed of the bubbles during emission.
  public void drag()
  {
    speedX *= .98;
    speedY *= .98;
    if (abs(speedX)<.01)
      speedX=0;
    if (abs(speedY)<.01)
      speedY=0;      
  }
  
  
  public void setSpeedX(float a)
  {
    speedX = a;
  }
  public void setSpeedY(float a)
  {
    speedY = a;
  }  
  
}
