class Electricity
{
  int points = 12;
   
  float []xLocs,yLocs;
  
  public Electricity()
  {   
    xLocs = new float[points];
    yLocs = new float[points];   
  }
  
  public void render(float a, float b, float c, float d)
  {
    float xDist = a-c;
    for (int i = 0; i<xLocs.length;i++)
    {
      xLocs[i] = c + (1.0/(points-1))*xDist*i;    
    } 
    
    float yDist = b-d;
    for (int i = 0; i<yLocs.length;i++)
    {
      yLocs[i] = d + (1.0/(points-1))*yDist*i;
    } 
    
    for (int i = 1; i<xLocs.length-1;i++)
    {
      xLocs[i]+=random(-1*abs(yDist*.04),1*abs(yDist*.04));
      yLocs[i]+=random(-1*abs(xDist*.04),1*abs(xDist*.04));
    }        
    
    for (int i = 0; i<xLocs.length-1;i++)
    {      
      stroke(200,15,100);
      strokeWeight(1);
      line(xLocs[i],yLocs[i],xLocs[i+1],yLocs[i+1]);      
    } 
  }
}
