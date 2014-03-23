class Map
{
  final int MAP_WIDTH = 4000;
  final int MAP_DEPTH = 8000;
   
  int fishAmount = 400;
  int jellyAmount = 200;
  int sharkAmount = 2;
  int bubbleAmount = 300;
  
  Jellyfish[] jellyArray;
  Fish[] fishArray;
  Shark[] sharkArray;
  
  Bubble[] bubbleArray;
  BubbleEmitter bubEmit;
  
  BgWhale whale;
   
  Electricity e;

  PImage lavaVent;
  
  public Map ()
  {       
    //Initializes fishAmount fish randomly placed between -1000 and 1000 x and y.
    fishArray = new Fish[fishAmount];   
    for (int f = 0; f<fishArray.length; f++)
    {
      fishArray [f] = new Fish(random(-MAP_WIDTH,MAP_WIDTH),random(50,3500));
    }
       
    //Initializes jellyAmount jelly fish randomly placed between -1000 and 1000 x and y.
    jellyArray = new Jellyfish[jellyAmount];   
    for (int j = 0; j<jellyArray.length; j++)
    {
      jellyArray [j] = new Jellyfish(random(-MAP_WIDTH,MAP_WIDTH),random(4000,7500));
    }
    
    //Initializes 5 sharks randomly placed between -1000 and 1000 x and y.
    sharkArray = new Shark[sharkAmount];   
    for (int s = 0; s<sharkArray.length; s++)
    {
      sharkArray [s] = new Shark(random(-MAP_WIDTH,MAP_WIDTH),random(1000,3000));
    }  
  
    //Initializes bubbleAmount bubbles randomly placed which will float up repeatedly.
    bubbleArray = new Bubble[bubbleAmount];   
    for (int b = 0; b<bubbleArray.length; b++)
    {
      bubbleArray [b] = new Bubble(random(-MAP_WIDTH,MAP_WIDTH),random(50,8000));
    }  
    
    bubEmit = new BubbleEmitter(20,160);
    e = new Electricity();
    
    whale = new BgWhale(140,2000);

    lavaVent = loadImage("lavaVent.png");
  }
  
  public void renderMap(Player a)
  {
    // Blue water
    background (0,0,0);
    
    // White sky
    fill(0,0,100);
    rect(-MAP_WIDTH,-1000,MAP_WIDTH*2,1000);      
    
    // Yellow sun
    fill(60,100,100);    
    ellipse(0,-250,40,40);
    
    
    //Water darkness
    for (int i=0;i<200;i++) 
    { 
      noStroke();
      fill(210,75+0.5*i,100-0.5*i);  
      rectMode(CORNER);   
      rect(-MAP_WIDTH,i*40,MAP_WIDTH*2,41);
    }         
        
    //Left-side gradient
    for (int i=0;i<100;i++) 
    { 
      stroke(0,0,0,100-i);    
      line(-MAP_WIDTH+i,-500,-MAP_WIDTH+i,8000);
      line( MAP_WIDTH-i,-500, MAP_WIDTH-i,8000);
    } 
    
    image(lavaVent,0,9000);
    
    whale.showBgWhale(a);    
    
    for (int j = 0; j<jellyArray.length; j++)
    {
      jellyArray[j].showJellyfish();
    }
    for (int f = 0; f<fishArray.length; f++)
    {
      if(fishArray[f].isAlive())
        fishArray[f].showFish(a);
    }
    for (int s = 0; s<sharkArray.length; s++)
    {
      sharkArray[s].showShark();
    }    
    
    
    for (int b = 0; b<bubbleArray.length; b++)
    {
      bubbleArray [b].showBubble(-MAP_WIDTH,MAP_WIDTH,8000);
    }  
    
    bubEmit.renderEmitter();
  }
  
  
  public void fishReact(Player a)
  {
    for (int f = 0; f<fishArray.length; f++)
    {
      Fish fish = fishArray[f];
      if (!fish.inSchool() && dist(fish.getX(),fish.getY(),a.getX(),a.getY()) < 80 && a.sameSpecies(fish.species)) 
      {
        a.addFish(fish);
        fish.follow(a);
      }
      
      if (dist(fish.getX(),fish.getY(),a.getX(),a.getY()) < 180 && !a.sameSpecies(fish.species) && fish.getSize() == .6) 
      {
        fish.evade(a);
      }     
      else if (dist(fish.getX(),fish.getY(),a.getX(),a.getY()) < 180 && !a.sameSpecies(fish.species) && a.bigFish && fish.getSize() == 1)
      {
        fish.evade(a);
      }
    }
  }
  
  
  public void sharkReact(Player a)
  {
    for (int s = 0; s<sharkArray.length; s++)
    {
      Shark shark = sharkArray[s];
      if ((abs(shark.yLoc - a.yLoc) < 300) && (abs(shark.xLoc - a.xLoc) < 1000))
      {
        if (a.health>100)
        {
          float theta = atan2(a.xLoc - shark.xLoc, a.yLoc - shark.yLoc); 
          
          if (abs(theta)>1.1 && abs(theta)<2.04)
          {      
            // If the shark is facing left and the player is on its left.
            if (shark.direction == -1 && shark.xLoc - a.xLoc > 0)
            {
              shark.attack(a);      
            }
            // If the shark is facing right and the player is on its right.
            else if (shark.direction == 1 && shark.xLoc - a.xLoc < 0)
            {
              shark.attack(a);
            } 
          }  
     
          if (shark.attackTimer>0 && abs(shark.xLoc-a.xLoc)<150 && abs(shark.yLoc-a.yLoc)<60 && a.health>0)
             a.setHealth(0);
        }
          
        for (int i = 0; i<a.schoolSize; i++)
        {
          if (a.schoolArray[i]!=null && shark.attackTimer>0 && abs(shark.xLoc-a.schoolArray[i].xLoc)<150 && abs(shark.yLoc-a.schoolArray[i].yLoc)<60)
          {
            bubEmit.emit(a.schoolArray[i].xLoc,a.schoolArray[i].yLoc,a); 
            a.schoolArray[i].kill();        
            a.schoolArray[i]=null;
            a.schoolSize--;
          }        
        }        
      }   
    }
  }
  
  public void eatFish(Player a)
  {
    for (int f = 0; f<fishArray.length; f++)
    {
      Fish fish = fishArray[f];
      if (!a.sameSpecies(fish.species) && fish.isAlive()) 
      {
        if (abs(a.xLoc-fish.xLoc) < 22 && abs(a.yLoc-fish.yLoc) < 15 && fish.getSize() == .6)
        {
          fish.kill();
          bubEmit.emit(fish.xLoc,fish.yLoc,a);
          a.health+=10;
        }
        else
        {
          for (int i = 1; i<a.schoolSize;i++)
          {
            if(a.schoolArray[i]!=null)
            {
              Fish schoolFish = a.schoolArray[i];
              if (schoolFish.fishSize > fish.fishSize && abs(schoolFish.xLoc-fish.xLoc) < 22*schoolFish.fishSize && abs(schoolFish.yLoc-fish.yLoc) < 15*schoolFish.fishSize)
              {
                fish.kill();
                bubEmit.emit(fish.xLoc,fish.yLoc,a);
                a.health+=10;
              }
            }
          }
        }
      }
    } 
  }
  
  
  public boolean jellyDamage(Player a)
  {
    boolean temp = false;
    for (int j = 0; j<jellyArray.length; j++)
    {
      if (dist(jellyArray[j].getX(),jellyArray[j].getY(),a.getX(),a.getY()) < 140*jellyArray[j].jellySize) 
      {       
        e.render(a.getX(),a.getY(),jellyArray[j].getX(),jellyArray[j].getY());
        temp = true;
      }
      for (int i = 1; i<a.getSchoolSize();i++)
      {
        if (a.schoolArray[i]!=null && dist(jellyArray[j].getX(),jellyArray[j].getY(),a.schoolArray[i].getX(),a.schoolArray[i].getY()) < 140*jellyArray[j].jellySize) 
        {       
          e.render(a.schoolArray[i].getX(),a.schoolArray[i].getY(),jellyArray[j].getX(),jellyArray[j].getY());
          temp = true;
        }
      }      
    }
    return temp; 
  }
}
  
  
