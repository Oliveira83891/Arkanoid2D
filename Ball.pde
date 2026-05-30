class Ball
{
  float x;
  float y;
  float radius;
  float diameter;
  color c;
  
  
  Ball (float x, float y, float radius, color c)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.diameter = radius*2;
    this.c = c;
    
  }
  
  
  
  void draw()
  {
    fill(c);
    circle(this.x,this.y,this.diameter);
    
  }
  
  
}
