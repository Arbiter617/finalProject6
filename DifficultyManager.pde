class DifficultyManager
{
  // 1 for Easy, 2 for Medium, 3 for Hard.
  short difficulty;
  
  public DifficultyManager(short a)
  {
    difficulty = a;
  }
  
  
  public void setDifficulty(short a)
  {
    difficulty = a;
  }  
  
  public short getDifficulty()
  {
    return difficulty;
  }
}
