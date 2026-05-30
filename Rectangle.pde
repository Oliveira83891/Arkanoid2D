class Rectangle
{
  float x;
  float y;
  float width;
  float height;
  float angle;
  color c;
  
  
  Rectangle (float x, float y, float width, float height, float angle, color c)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.angle = angle;
    this.c = c;

    
  }
  
  void draw()
  {
    fill(c);
    pushMatrix();
    translate(this.x, this.y);
    rotate(this.angle);
    rectMode(CENTER);
    rect(0,0,this.width,this.height);
    popMatrix();
      
    
  }
}
