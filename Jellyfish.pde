class Jellyfish
{
  float xLoc,yLoc;
  
  float jellySize;
  
  float jellyHue;
  float saturOffset;
  
  float bobbing; 
  float bobbingAngle;
  float bobbingOffset;

  public Jellyfish(float a, float b)
  {    
    xLoc = a;
    yLoc = b;
    
    float x = random(0,10);
    if(x>9.6)
      jellySize = 1.8;
    else if (x>8)
      jellySize = 1.3;
    else if (x>4)
      jellySize = 1;      
    else
      jellySize = .6;
      
    jellyHue = 310+random(-12,12); 
    saturOffset = random(0,2*PI);
  }  
  
  public void showJellyfish()
  {
    bobbingAngle = xLoc/600;    
    bobbingOffset += .03;
    bobbing = 3*sin(bobbingAngle+bobbingOffset); 
    
    pushMatrix();
    translate (0,bobbing);     
    noStroke();
    fill(jellyHue,65+15*sin(saturOffset),90+5*sin(saturOffset));      
    arc(xLoc, yLoc, 34*jellySize, 25*jellySize, PI, 2*PI, CHORD);
    
    strokeWeight(2*jellySize);
    stroke(jellyHue,65+15*sin(saturOffset),90+5*sin(saturOffset));
    curve(xLoc-8*jellySize,yLoc-7*jellySize,xLoc-8*jellySize,yLoc,xLoc-8*jellySize+3*sin(bobbingOffset-.2)*jellySize,yLoc+21*jellySize,xLoc-6*jellySize+12*sin(bobbingOffset-.2)*jellySize,yLoc+28*jellySize);   
    curve(xLoc,yLoc-10*jellySize,xLoc,yLoc,xLoc+4*sin(bobbingOffset)*jellySize,yLoc+30*jellySize,xLoc+12*sin(bobbingOffset)*jellySize,yLoc+40*jellySize);
    curve(xLoc+8*jellySize,yLoc-7*jellySize,xLoc+8*jellySize,yLoc,xLoc+8*jellySize+3*sin(bobbingOffset+.2)*jellySize,yLoc+21*jellySize,xLoc+6*jellySize+12*sin(bobbingOffset+.2)*jellySize,yLoc+28*jellySize);      
            
    popMatrix();
    
    saturOffset+=.03;
  }
  
  public float getX()
  {
    return xLoc;
  }
  public float getY()
  {
    return yLoc;
  }
}
