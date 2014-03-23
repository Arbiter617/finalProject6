class BubbleEmitter
{
  int bubblesPerEmission;  
  int maxBubblesAllowed;
  
  Bubble [] bubbles;
  float [] xLoc,yLoc;
    
  int currentIndex = 0;
  
  public BubbleEmitter(int a, int b)
  {
    bubblesPerEmission = a;  
    maxBubblesAllowed  = b;    
    bubbles = new Bubble[maxBubblesAllowed];
  }
  
  public void emit(float x, float y, Player a)
  {
    int p = bubblesPerEmission;
    while (p>0)
    {
      if (currentIndex==bubbles.length)
        currentIndex = 0;
        
      bubbles[currentIndex] = new Bubble (x, y);
      bubbles[currentIndex].setSpeedX(0.7*a.speedX + random(-2,2));
      bubbles[currentIndex].setSpeedY(0.7*a.speedY + random(-2,2)); 
      
      currentIndex++;
      p--;     
    }
  }
  
  public void renderEmitter()
  {
    for (int i = 0; i<bubbles.length; i++)
    {
      if (bubbles[i] != null)
      {
        bubbles[i].showBubble(-3000,3000,8000);
        bubbles[i].drag();
      }
    }
  }
    
}

