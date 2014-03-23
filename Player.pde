class Player
{
  float xLoc,yLoc;
  float speedX,speedY;
  float speed;
  
  //-1 for left, 1 for right.
  short direction;
  
  // 0 Red, 1 Orange, 2 Yellow, 3 Green, 4 Blue, 5 Pink/Purple, 6 Grey/Black
  int species;  
  color fishColor;

  float bobbing; 
  float bobbingAngle;
  float bobbingOffset;
  
  //Angle of mouse relative to center.
  float theta;
    
  //If the user clicks closer to the fish, the speed factor takes effect so the fish moves more slowly.
  float speedFactor;
    
  //Edit these for fun fish effects!
  float maxSpeed = 6;
  float acceleration = .15;
  
  Fish[] schoolArray;
  int schoolSize;
  boolean bigFish = false;
  
  float health;
  boolean died = false;
  
  //Damage given by Jellyfish per frame.
  float dmgJelly = 1;
  
  BubbleEmitter deathEmitter;
  
  public Player(int a, int b)
  {
    xLoc = a;
    yLoc = b;
    speed = 0;
    
    direction = 1;
    
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
    
    schoolArray = new Fish[100];
    schoolSize = 1;
    
    health = 100;
  }
  

  public void showPlayer()
  {
    if (health > 0)
    {
      bobbingAngle = xLoc/600;    
      bobbingOffset += .03;
      bobbing = (5-(speed*3/maxSpeed))*sin(bobbingAngle+bobbingOffset); 
      
      pushMatrix();
      translate (0,bobbing); 
      noStroke();     
      fill(fishColor);
      ellipse(xLoc,yLoc,33,12); 
  
      if (mouseX > width/2) {     
        direction = 1; }
      if (mouseX < width/2) {     
        direction = -1; } 
           
      if (direction == -1)
      {    
        triangle(xLoc,yLoc,xLoc+20,yLoc+10,xLoc+20,yLoc-10);
        fill(0);
        ellipse(xLoc-8,yLoc-2,3,3);
      }  
      else if (direction == 1)
      {
        triangle(xLoc,yLoc,xLoc-20,yLoc+10,xLoc-20,yLoc-10);
        fill(0);
        ellipse(xLoc+8,yLoc-2,3,3);
      }             
      popMatrix();
    }
    else
    {      
      if (died == false)
      {
        deathEmitter = new BubbleEmitter(20,20);
        deathEmitter.emit(xLoc,yLoc,this);
        died = true;
      }
      deathEmitter.renderEmitter();
    }
  }
  
  public void swim()
  {    
    theta = atan2(mouseX - width/2,mouseY - height/2); 
    speedFactor = constrain(sqrt(pow(mouseX-width/2,2)+pow(mouseY-height/2,2))/150,0,1);
      
    speed = sqrt(pow(speedX,2)+pow(speedY,2));
    //Above ocean surface.
    if (yLoc<0)
    {
      speedY+=.2;       
    }        
    else if (speed < speedFactor*maxSpeed)
    {
      speed += acceleration;
      speed = constrain (speed+acceleration,0,maxSpeed);
      speedX = sin(theta)*speed;
      speedY = cos(theta)*speed;
    }
    else
    {
      speedX = sin(theta)*speedFactor*maxSpeed;
      speedY = cos(theta)*speedFactor*maxSpeed;
    }
   
    xLoc+=speedX;
    yLoc+=speedY;
    
    xLoc = constrain(xLoc,-4000,4000);    
  }
  
  public void deaccelerate()
  {
    speed = sqrt(pow(speedX,2)+pow(speedY,2));        
    theta = atan2(mouseX - width/2,mouseY - height/2); 
    
    if (speed <.01)
    {
      speed = 0;
    }
    
    speedX *=.95;
    speedY *=.95; 
 
    xLoc+=speedX;
    yLoc+=speedY;      
  }
  

  
  public void addFish(Fish a)
  {
    int i = 1;
    while(schoolArray[i]!=null)
    {
      i++;
    }
    schoolArray[i] = a;
    a.schoolNumber = i;
    schoolSize++;
    health+=a.fishSize*100; 
    
    if(a.fishSize==1.5)
      bigFish = true;
  } 
     
  
  public void damageJelly()
  {
    health -= dmgJelly;   
  }
   

  
  public float getHealth(){
    return health;}
    
  public void setHealth(float a){
    health = a;}    
  
  public float getX(){
    return xLoc;}
  
  public float getY(){
    return yLoc;}  
  
  public float getSpeed(){    
    return speed;}
    
  public float getSpeedX(){    
    return speedX;}
    
  public float getSpeedY(){    
    return speedY;}  
    
  public int getSchoolSize(){
    return schoolSize;}
    
    
  
  public boolean sameSpecies(int a)
  {   
    if (a==species)
    {
      return true;
    }
    else
      return false;
  }    
}  
