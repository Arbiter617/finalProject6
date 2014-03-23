GameManager game;

void setup()
{
  colorMode(HSB,360,100,100,100);
  
  game = new GameManager (1280,720);
}


void draw()
{
  game.play();
}


void mouseReleased()
{
  if (!mousePressed)
  {
    game.justClicked = false;
  }
}

void keyReleased()
{
  game.spaceJustPressed = false;
  game.frameJustSaved = false;
}
