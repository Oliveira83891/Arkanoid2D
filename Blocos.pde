class Blocos
{
  float x;
  float y;
  float width;
  float height;
  color c;
  
  Blocos (float x, float y, float width, color c)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = width / 2;
    this.c = c;
 
  }
  
  
  void draw()
  {
  
    fill(c);
    pushMatrix();
    stroke(0); 
    strokeWeight(3);
    translate(this.x, this.y);
    rectMode(CENTER);
    rect(0,0, this.width, this.height, 3);
    popMatrix();
    strokeWeight(1); 
    stroke(0);

  }
}
