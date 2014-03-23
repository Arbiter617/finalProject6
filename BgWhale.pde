class BgWhale
{
  float xLoc,yLoc;
  
  float xOffset, yOffset;
  
  public BgWhale(float x, float y)
  {
    xOffset = 0-x;
    yOffset = 50-y;
    
    xLoc = x;
    yLoc = y;
  }
  
  public void showBgWhale(Player a)
  {
    xLoc = (a.getX()-xOffset)*.6;
    yLoc = (a.getY()-yOffset)*.6;
    
    fill(20,20,20,40);
    ellipse(xLoc,yLoc,140,50);
  }
}
