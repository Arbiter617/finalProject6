class Fish
{
  float xLoc, yLoc;
  float speedX,speedY;
  float speed;  
  float theta;
  
  // 0 Red, 1 Orange, 2 Yellow, 3 Green, 4 Blue, 5 Pink/Purple, 6 Black, 7 White
  int species;
  color fishColor;
  
  float bobbing; 
  float bobbingAngle;
  float bobbingOffset;
  float idleOffset;
  
  //-1 for left, 1 for right.
  short direction;
  
  int evadeTime;
  // -1 for counterclockwise, 1 for clockwise
  int evadeDirection;
  
  //0 for small, 1 for mid, 2 for large.
  float fishSize;
  
  //true for alive, false for dead.
  boolean isAlive;
  
  //true if it is part of the player's school.
  boolean inSchool;
  //which fish in the school.
  int schoolNumber;
  //which layer of the school the fish is in.
  int schoolLayer;
  
  public Fish (float a, float b)
  {
    xLoc = a;
    yLoc = b;
    direction = 1;
    evadeTime = 0;
    evadeDirection = 2*(int)random(0,2)-1;

    species = (int)random(0,8);
    
    if(species==0){
      fishColor = color(random(350,370)%360,random(80,100),random(80,100));}
    else if(species==1){
      fishColor = color(random(35,45),random(80,100),random(80,100));}    
    else if(species==2){
      fishColor = color(random(50,70),random(80,100),random(80,100));}    
    else if(species==3){
      fishColor = color(random(100,140),random(70,100),random(70,100));}   
    else if(species==4){
      fishColor = color(random(230,270),random(70,100),random(70,100));}         
     else if(species==5){
      fishColor = color(random(290,320),random(70,100),random(70,100));}    
    else if(species==6){
      fishColor = color(0,0,random(0,35));}       
    else if(species==7){
      fishColor = color(0,0,random(65,100));}   
      
    bobbingAngle = xLoc/600;
    
    float x = random(0,10);
    if(x>9)
      fishSize = 1.5;
    else if (x>4)
      fishSize = 1;
    else
      fishSize = .6;
      
    isAlive = true;
    
    idleOffset = random(0,2*PI);
    
  }
  
  public void showFish(Player a)
  {    
    swim(a);
    
    bobbingAngle = xLoc/600;    
    bobbingOffset += .03;
    bobbing = (6-3*fishSize)*sin(bobbingAngle+bobbingOffset); 
    
    pushMatrix();
    translate (0,bobbing); 
    
    noStroke();
    fill(fishColor);
    ellipse(xLoc,yLoc,33*fishSize,12*fishSize); 
    if (direction == -1)
    {    
      triangle(xLoc,yLoc,xLoc+20*fishSize,yLoc+10*fishSize,xLoc+20*fishSize,yLoc-10*fishSize);
      fill(0);
      ellipse(xLoc-8*fishSize,yLoc-2*fishSize,3*fishSize,3*fishSize);
    }  
    else if (direction == 1)
    {
      triangle(xLoc,yLoc,xLoc-20*fishSize,yLoc+10*fishSize,xLoc-20*fishSize,yLoc-10*fishSize);
      fill(0);
      ellipse(xLoc+8*fishSize,yLoc-2*fishSize,3*fishSize,3*fishSize);
    }  
    popMatrix();
  }
  
  public void swim(Player a)
  {
    if (isAlive)
    {  
      //Above ocean surface.
      if (yLoc<0)
      {
        speedY+=.15+.04*fishSize;
       
        xLoc += speedX;
        yLoc += speedY;        
      }      
      //Following player.
      else if (inSchool)
      {
        float targetX = a.getX() + 50*(schoolLayer) * sin(PI/(4*schoolLayer) * schoolNumber);
        float dx = targetX - xLoc;
        float targetY = a.getY() + 40*(schoolLayer) * cos(PI/(4*schoolLayer) * schoolNumber);        
        float dy = targetY - yLoc;                  
        
        if (targetX > xLoc)
          direction = 1;
        else if (targetX < xLoc)
          direction = -1;
          
        if (abs(dx) > 1)
          xLoc += dx * (0.2 + 0.01*a.getSpeed() - .1*fishSize);         
        if (abs(dy) > 1)
          yLoc += dy * (0.2 + 0.01*a.getSpeed() - .1*fishSize);  
      
        speedX = a.getSpeedX();
        speedY = a.getSpeedY();        
      }
      //Evading player.
      else if (evadeTime > 0)
      { 
        if(dist(xLoc,yLoc,a.xLoc,a.yLoc)<50)
        {        
          theta = atan2(xLoc-a.getX(),yLoc-a.getY()) + evadeDirection*PI/2; 
        }
        else
        {         
          theta = atan2(xLoc-a.getX(),yLoc-a.getY()); 
        }
        
        speedX += .2*sin(theta);
        speedY += .2*cos(theta);
        speedX = constrain(speedX,-4.5,4.5);
        speedY = constrain(speedY,-3.5,3.5);   
        
        xLoc += speedX;
        yLoc += speedY;
      
        evadeTime--;    
        
        if (speedX > 0)
          direction = 1;
        else if (speedX < 0)
          direction = -1;
      }
      //Swimming idly.
      else
      {
        if (abs(speedX)>.05||abs(speedY)>.05)
        {
          speedX *= .95;
          speedY *= .95;
        }
        else
        {
          speedX = 0;
          speedY = 0;
        }
          
        xLoc += speedX;
        yLoc += speedY;
        
        if (sin(idleOffset)>0)
          direction = 1;
        else
          direction = -1;
        xLoc += .5*fishSize*sin(idleOffset);
        idleOffset+= .02-(.01*fishSize);
      }
      xLoc = constrain(xLoc,-4000,4000);
    }
  }  
  
  public void follow(Player a){
    inSchool = true;
    if (schoolNumber <= 8)
      schoolLayer = 1;
    else  if (schoolNumber <= 24) 
      schoolLayer = 2;
    else  
      schoolLayer = 3;      
      
  }
  
  public void evade(Player a){
    evadeTime = 100;    
  }    
  
  public boolean isAlive(){
    return isAlive;}
  
  public void kill() {
    isAlive = false;}
  
  public float getX(){
    return xLoc;}
  
  public float getY(){
    return yLoc;}  
  
  public float getSize(){
    return fishSize;}
  
  public color getColor(){
    return fishColor;}
  
  public boolean inSchool(){
    return inSchool;}
  
}
