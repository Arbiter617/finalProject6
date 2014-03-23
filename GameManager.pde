class GameManager
{
  // What state of the game you're in. 0 for in-game, 1 for main menu, 2 for controls.
  short state;
  
  DifficultyManager difficulty;
  
  boolean justClicked = false;
  boolean frameJustSaved = false;  
  boolean spaceJustPressed = false;
  
  Player myFish;;
  
  Map myMap;
  
  Bubble[] bubbleArray;
  
  public GameManager(int a, int b)
  {
    size (a,b);
    
    state = 1;
    
    // Defaults the difficulty to Medium.
    difficulty = new DifficultyManager((short)2);
    
    myMap = new Map();
    
    myFish = new Player(0,50);   
    
    bubbleArray = new Bubble[10];   
    for (int i = 0; i<bubbleArray.length; i++)
    {
      bubbleArray [i] = new Bubble(random(0,width),random(0,height));
    }  
  }  
  
  public void play()
  {    
    ///////////////////
    // GAME PLAYING - State 0
    ///////////////////
    if (state == 0)
    {        
      pushMatrix();
      // Translation for looking around  
      translate(width/2 - (constrain(mouseX-width/2,-width/2,width/2))*0.4-myFish.getX(),
                height/2 - (constrain(mouseY-height/2,-height/2,height/2))*0.4 -myFish.getY());
      
      myMap.renderMap(myFish);  
      
      
      if (myFish.health>0)
      {      
        // Controlling movement.   
        if (mousePressed || myFish.getY()<0){
          myFish.swim();
        } 
        else if (myFish.getSpeed() > 0){
          myFish.deaccelerate();
        }       
                       
        myMap.fishReact(myFish);    
        
        if (keyPressed && key == ' ' && !spaceJustPressed)
        {  
          myMap.eatFish(myFish);          
          spaceJustPressed=true;
        }
      }
      myMap.sharkReact(myFish);  
      
      myFish.showPlayer(); 
      
      if (myFish.health>0)
      {      
        if(myMap.jellyDamage(myFish)){
          myFish.damageJelly();
        }
      }   
      
      popMatrix();
         
      textAlign(LEFT);
      textSize(16);
      fill(0,0,0,50);
      text("Health: "+(int) myFish.getHealth(),51,51);  
      text("Depth: "+(int) myFish.getY()/100+"m",51,81); 
      text("Fish: "+ myFish.getSchoolSize(),51,111);        
      fill(0,0,100);
      text("Health: "+(int) myFish.getHealth(),50,50);  
      text("Depth: "+(int) myFish.getY()/100+"m",50,80); 
      text("Fish: "+ myFish.getSchoolSize(),50,110);   
       
      textAlign(RIGHT);       
      fill(0,0,0);
      text("FPS: "+(int)frameRate,width-20,25); 
              
      if (keyPressed && key == 'q'){
        state = 3;
      }
      if (keyPressed && !frameJustSaved && key == 'e'){
        save("MySavedImage.png");
        println("Image saved successfully!");
        frameJustSaved = true;
      }      
      
    }
    ///////////////////
    // MAIN MENU - State 1
    ///////////////////
    else if (state == 1)
    {
      background (210,75,100);
      textAlign(CENTER);
      textSize(40);
      fill(0);
      text("FISH GAME",width/2,height/2-20); 
      
      textSize(18);    
      if(abs(mouseX-width/2)<45 && abs(mouseY-height/2-24)<10){
        fill(0,0,100);
        if (mousePressed){
          state = 0;
        }
      }
      else {
        fill (0);
      }  
      text("Play Game",width/2,height/2+30);  
      
      if(abs(mouseX-width/2)<35 && abs(mouseY-height/2- 54)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          state = 2;
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("Controls",width/2,height/2+60); 

      if(abs(mouseX-width/2)<40 && abs(mouseY-height/2- 84)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          state = 4;
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("Difficulty",width/2,height/2+90); 
      
      for (int b = 0; b<bubbleArray.length; b++)
      {
        bubbleArray [b].showBubble(0,width,height);
      } 
      
      fill(0,0,0,20);
      textAlign(RIGHT);
      textSize(15);
      text("David Zoellner",width-10,height-10); 
    }
    ///////////////////
    // CONTROLS MENU - State 2
    ///////////////////
    else if (state == 2)
    {
      background (210,75,100);
      textAlign(CENTER);
  
      textSize(18);    
      fill(360);
      text("Move mouse to look around.",width/2,height/2-30); 
      text("Hold left click to swim.",width/2,height/2);  
      text("Space Bar to eat smaller fish.",width/2,height/2+30);     
      
      if(abs(mouseX-width/2)<30 && abs(mouseY-height/2- 54)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          state = 1;
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("Return",width/2,height/2+60); 
  
      for (int b = 0; b<bubbleArray.length; b++)
      {
        bubbleArray [b].showBubble(0,width,height);
      } 
      
      fill(0,0,0,20);
      textAlign(RIGHT);
      textSize(15);
      text("David Zoellner",width-10,height-10);   
  
    }
    ///////////////////
    // INGAME MENU - State 3
    ///////////////////
    else if (state == 3)
    {
      background (210,75,100);
      
      textAlign(CENTER);
  
      textSize(18);    
      if(abs(mouseX-width/2)<40 && abs(mouseY-height/2+30)<10){
        fill(0,0,100);
        if (mousePressed){
          state = 1;
        }
      }
      else {
        fill (0);
      }    
      text("Main Menu",width/2,height/2-30);  
      
      if(abs(mouseX-width/2)<40 && abs(mouseY-height/2)<10){
        fill(0,0,100);
        if (mousePressed){
          state = 2;
        }
      }
      else {
        fill (0);
      }        
      text("Controls",width/2,height/2);   
      
      if(abs(mouseX-width/2)<40 && abs(mouseY-height/2- 30)<10){
        fill(0,0,100);
        if (mousePressed){
          state = 0;
        }
      }
      else {
        fill (0);
      }     
      text("Resume Game",width/2,height/2+30); 
      
      for (int b = 0; b<bubbleArray.length; b++)
      {
        bubbleArray [b].showBubble(0,width,height);
      } 
      
      fill(0,0,0,20);
      textAlign(RIGHT);
      textSize(15);
      text("David Zoellner",width-10,height-10);       
          
    }
    ///////////////////
    // DIFFICULTY MENU - State 4
    ///////////////////
    else if (state == 4)
    {
      background (210,75,100);
      
      textSize(18);        

      textAlign(RIGHT); 
      fill(0,0,100);
      text("><>",width/2-30,height/2+30*difficulty.getDifficulty()-31);  
       
      textAlign(LEFT); 
      if(abs(mouseX-width/2-1)<25 && abs(mouseY-height/2+6)<10){
        fill(0,0,100);
        if (mousePressed){
          difficulty.setDifficulty((short)1);
          justClicked = true;          
        }
      }
      else {
        fill (0);
      }  
      text("EASY",width/2-20,height/2);  
      
      if(abs(mouseX-width/2-14)<40 && abs(mouseY-height/2- 24)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          difficulty.setDifficulty((short)2);
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("MEDIUM",width/2-20,height/2+30); 

      if(abs(mouseX-width/2-2)<26 && abs(mouseY-height/2- 54)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          difficulty.setDifficulty((short)3);
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("HARD",width/2-20,height/2+60); 

      
      textAlign(CENTER);
      textSize(18);      
      if(abs(mouseX-width/2)<30 && abs(mouseY-height/2- 84)<10){
        fill(0,0,100);
        if (mousePressed && !justClicked){
          state = 1;
          justClicked = true;
        }
      }
      else {
        fill (0);
      }     
      text("Return",width/2,height/2+90);    

      for (int b = 0; b<bubbleArray.length; b++)
      {
        bubbleArray [b].showBubble(0,width,height);
      } 
      
      fill(0,0,0,20);
      textAlign(RIGHT);
      textSize(15);
      text("David Zoellner",width-10,height-10);           
    }
  }
}


