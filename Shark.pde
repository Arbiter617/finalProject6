class Shark
{
  float xLoc,yLoc;
  
  // -1 for left, 1 for right.
  int direction;
  
  float speedX,speedY;
  float idleSpeed;
  
  float patrolMaxTime;
  float patrolTimer;
  
  float theta;
  
  int attackTimer;
  
  public Shark (float a, float b)
  {
    xLoc = a;
    yLoc = b;
    
    patrolMaxTime = (int) random(300,500);
    patrolTimer = (int) random(0,patrolMaxTime);
    
    speedX = random(1,2);
    idleSpeed = speedX;
    
    attackTimer = 0;
  }
  
  public void showShark()
  {
    if (speedX > 0)
    {
      direction = 1;
    }
    if (speedX < 0)
    {
      direction = -1;
    }
    
    fill(0,0,30);
    ellipseMode(CENTER);
    ellipse(xLoc,yLoc,300,63);
    if (direction == -1)
    {
      // Caudal fin upper 
      triangle(xLoc+120,yLoc,xLoc+165,yLoc,xLoc+195,yLoc-53);  
      // Caudal fin lower
      triangle(xLoc+120,yLoc-2,xLoc+165,yLoc-2,xLoc+180,yLoc+48);        
      // Dorsal fin
      triangle(xLoc-56,yLoc,xLoc+18,yLoc-70,xLoc+45,yLoc); 
      // Pectoral fin
      triangle(xLoc-83,yLoc,xLoc,yLoc+75,xLoc-8,yLoc);    
      // Eye  
      fill(0);
      ellipse(xLoc-113,yLoc-7,4,4);  
    }
    else if (direction == 1)
    {
      // Caudal fin upper 
      triangle(xLoc-120,yLoc,xLoc-165,yLoc,xLoc-195,yLoc-53);  
      // Caudal fin lower
      triangle(xLoc-120,yLoc-2,xLoc-165,yLoc-2,xLoc-180,yLoc+48);        
      // Dorsal fin
      triangle(xLoc+56,yLoc,xLoc-18,yLoc-70,xLoc-45,yLoc); 
      // Pectoral fin
      triangle(xLoc+83,yLoc,xLoc,yLoc+75,xLoc+8,yLoc);    
      // Eye  
      fill(0);
      ellipse(xLoc+113,yLoc-7,4,4);        
    }
    
    swim(); 
  }
  
  public void swim()
  {   
    // IDLE
    if (attackTimer == 0)
    {
      if (patrolTimer == 0)
      {
        speedX *= -1;
        patrolTimer = patrolMaxTime;
      }
      patrolTimer--;
         
      if (abs(speedY) > 0)
      {
        speedY *= .99;
        if (abs(speedY) < 0.05)
        {
          speedY = 0;
        }
      }
      if (abs(speedX) > idleSpeed)
      {
        speedX *= .99;
        if (abs(speedX) < 0.05)
        {
          speedY = 0;
        }
      }
    }
    // ATTACKING
    else
    {
      attackTimer--;
      patrolTimer = patrolMaxTime;
    }   
    xLoc+=speedX;  
    yLoc+=speedY;     
  }
  
  public void attack(Player a)
  {
    theta = atan2(a.xLoc - xLoc, a.yLoc - yLoc); 
    
    speedX += .2*sin(theta);
    speedY += .2*cos(theta);
        
    attackTimer = 30;             
  }
  
}  
