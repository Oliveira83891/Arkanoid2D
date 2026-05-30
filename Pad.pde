class Pad
{
  float x;
  float y;
  float width;
  float height;
  float angle;
  color c;
  
  int speed;
  
  Ball Ball;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  
  boolean isMovingBall;
  
  int countTime;
  
  float lim_baixo_cima = 0;
  float lim_laterais = 0;
  float angle_inicial = 0;

   
  float velocidade = 5;
   
  float anguloRadianos = radians(45);
   
  float velX = velocidade * sin(anguloRadianos);
  float velY = velocidade * cos(anguloRadianos);
   
  Pad (float x, float y, float width, float height, float angle, color c)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.angle = angle;
    this.c = c;
    this.speed = 400;
    
    this.isMovingLeft = false;
    this.isMovingRight = false;
    this.isMovingBall = false;   
    
  }
  
  void move(float deltaT)
  {
   
    if(isMovingLeft == true)
    {
      this.x -= speed * deltaT;
    }
    
    if(isMovingRight == true)
    {
      this.x += speed * deltaT;
    }
     
  }
  
  void createBall() {
    
    if(value_global == 0)
    {
      this.Ball = new Ball(this.x, this.y - 14, 8, GREY);
    }
    else
    { 
      this.Ball = new Ball(this.Ball.x, this.Ball.y, 8, GREY);
    }
}
  
 
  void MoveBall() {
  if (isMovingBall == true) {
    
    if(angle_inicial == 0)
    {
      if(this.x < W_WIDTH/2){
      velX *= -1;
      angle_inicial = 1;
      }
      else if(this.x == W_WIDTH/2){
       velX = 0;
       angle_inicial = 1;
      } 
    }
        
    this.Ball.x += velX; 
    this.Ball.y -= velY; 
  
    if (this.Ball.x >= W_WIDTH*0.96f || this.Ball.x <= W_WIDTH*0.033f){ 
    lim_laterais = 1;
    
    }
  
    if (this.Ball.y <= W_HEIGHT*0.134f) { 
    lim_baixo_cima = 1;     
    }  
    
    if (this.Ball.y > W_HEIGHT) { 
      lives--; 
      if(lives != 0){
        isMovingBall = false; // Para o movimento da bola
        value_global = 0;
        //this.x = W_WIDTH / 2; Colocar o pad na posição inicial
      
      }
      else
      {
        isMovingBall = false; // Para o movimento da bola
        countTime = millis();
        
      }
    }
  }
}

  void collisionDetection()
  {     
        float contact_X;
        float verify_left_X = 0;
        float verify_right_X = 0;
        
        contact_X = this.Ball.x;
    
        if(contact_X < this.x - this.height/2) 
        {
          contact_X = this.x - this.height/2;
          verify_left_X = 1;
          
        }
        else if(contact_X > this.x + this.height/2)
        {
          contact_X = this.x + this.height/2;
          verify_right_X = 1;
        }
        
        if(verify_left_X == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, this.x - this.height/2, this.y - this.width/2);
              if(d <= this.Ball.radius)
              {
                float novo_angulo = radians(-45);
                velX = velocidade * sin(novo_angulo);
                velY = velocidade * cos(novo_angulo);
              }
        }
        
        if(verify_right_X == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, this.x + this.height/2, this.y - this.width/2);
              if(d <= this.Ball.radius)
              {
                float novo_angulo = radians(45);
                velX = velocidade * sin(novo_angulo);
                velY = velocidade * cos(novo_angulo);
              }
        }
        
        if(contact_X > this.x && contact_X < this.x + this.height/2)
        {
            float d = dist(this.Ball.x, this.Ball.y, contact_X, this.y - this.width/2);
            if(d <= this.Ball.radius)
              {
                float novo_angulo = radians(22.5);
                velX = velocidade * sin(novo_angulo);
                velY = velocidade * cos(novo_angulo);
              }
        }
        else if(contact_X < this.x && contact_X > this.x - this.height/2)
        {
            float d = dist(this.Ball.x, this.Ball.y, contact_X, this.y - this.width/2);
            if(d <= this.Ball.radius)
              {
                float novo_angulo = radians(-22.5);
                velX = velocidade * sin(novo_angulo);
                velY = velocidade * cos(novo_angulo);
              }
        }
        else if(contact_X == this.x)
        {
          float d = dist(this.Ball.x, this.Ball.y, contact_X, this.y - this.width/2);
          if(d <= this.Ball.radius)
          {
            float novo_angulo = radians(0);     
            velX = velocidade * sin(novo_angulo);
            velY = velocidade * cos(novo_angulo);
          }
        }
      
  }
  
 void collisionDetectionBlock(float blockX_ini, float blockX_final, float blockY_cima, float blockY_baixo)
  {
    
    float contactX, contactY;
    float verify_left_X = 0;
    float verify_right_X = 0;
    float verify_cima = 0;
    float verify_baixo = 0;
        
    if(isMovingBall == true)
    {
        contactX = this.Ball.x;
        contactY = this.Ball.y;
        
        if(contactX < blockX_ini) 
        {
          contactX = blockX_ini;
          verify_left_X = 1;
          
        }
        else if(contactX > blockX_final)
        {
          contactX = blockX_final;
          verify_right_X = 1;
        }
        
        if(contactY < blockY_cima)
        {
          contactY = blockY_cima;
          verify_cima = 1;
        }
        else if(contactY > blockY_baixo)
        {
          contactY = blockY_baixo;
          verify_baixo = 1;
        }
        
        if(verify_left_X == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, contactX, contactY);
          if(d <= this.Ball.radius)
          {
              velX *= -1;
              block_global = 1;    
          }
        }
        else if(verify_right_X == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, contactX, contactY);
          if(d <= this.Ball.radius)
          {
              velX *= -1;
              block_global = 1;    
          }
        }
        
        if(verify_cima == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, contactX, contactY);
          if(d <= this.Ball.radius)
          {
              velY *= -1;
              block_global = 1;    
          }
        }
        else if(verify_baixo == 1)
        {
          float d = dist(this.Ball.x, this.Ball.y, contactX, contactY);
          if(d <= this.Ball.radius)
          {
              velY *= -1;
              block_global = 1;    
          }
        }
    }
    
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
   
   
    createBall();
    MoveBall();   
    
    if(lim_laterais == 1)
    {
      velX *= -1;
      this.Ball.x += velX; 
      lim_laterais = 0;
    }
    
    if(lim_baixo_cima == 1)
    {
      velY *= -1;
      this.Ball.y -= velY;
      lim_baixo_cima = 0;
      
    }
    
    this.Ball.draw();
    collisionDetection();
    //strokeWeight(1); 
    //stroke(0);
    
    if (lives == 0) {
    int elapsedTime = millis() - countTime;
    if (elapsedTime < 4000) 
    { // Desvanecer ao longo de 4 segundos
      textOpacity = int(map(elapsedTime, 0, 4000, 255, 0));
    } else 
    {
      textOpacity = 0;
      levelStarting = false; // Parar de desvanecer após 4 segundos
    }
  
  textFont(GameOverFont, 45);
  fill(LIGHT_BLUE, textOpacity);
  textAlign(CENTER);
  text("GAME OVER!", W_WIDTH/2, W_HEIGHT/2);
  }
    
    
    
  }
}
