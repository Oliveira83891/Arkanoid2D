final color WHITE = color(255);
final color BLACK = color(0,0,0);
final color GREEN = color(0, 255, 0);
final color RED = color(255, 0, 0);
final color BLUE = color(0, 0, 255);
final color LIGHT_BLUE = color(0, 232, 255);
final color YELLOW = color(255, 220, 0);
final color PURPLE = color(160, 32, 240);
final color PINK = color(255, 182, 193);
final color ORANGE = color(255, 140, 0);
final color DARK_GREY = color(100, 100, 100);
final color GREY = color(191, 191, 191);

final int W_WIDTH = 420;
final int W_HEIGHT = 630;

PFont titleFont;
PFont scoreFont;
PFont lvlFont;
PFont GameOverFont;
int textOpacity = 255; // Opacidade inicial do texto

int startTime; // Tempo inicial para o desvanecimento do texto
boolean levelStarting = true; // Flag para indicar se o nível está começando

int lives = 3;


int time;
int value_global = 0;
int block_global = 0; 
int numColision[][] = new int[15][13];


Rectangle[] RectanglesLim = new Rectangle[3];
Pad Pad;
Blocos[][] blocos = new Blocos[15][13];


color[] cores = {0, WHITE, ORANGE, LIGHT_BLUE, GREEN, RED, BLUE, PURPLE, GREY, YELLOW};
int[][] grid = new int[15][13];
int currentLevel = 1;
int currentPoints = 0;

void settings()
{
  size(W_WIDTH,W_HEIGHT);
}

void setup()
{
  RectanglesLim[0] = new Rectangle(W_WIDTH*0.012f,W_HEIGHT*0.56f,W_WIDTH*0.02381f,W_HEIGHT*0.88f,0,YELLOW); //rect amarelo esquerdo
  RectanglesLim[1] = new Rectangle(W_WIDTH*0.99f,W_HEIGHT*0.56f,W_WIDTH*0.02381f,W_HEIGHT*0.88f,0,YELLOW); //rect amarelo direito
  RectanglesLim[2] = new Rectangle(W_WIDTH/2,W_HEIGHT/8,W_WIDTH*0.023f,W_WIDTH,PI/2,YELLOW); //rect amarelo cima
  
  Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW); //rect principal, que mexe
  
  
  titleFont = loadFont("GoudyStout-48.vlw");
  scoreFont = loadFont("ForteMT-48.vlw");
  lvlFont = loadFont("GoudyStout-48.vlw");
  GameOverFont = loadFont("SnapITC-Regular-48.vlw");
   
   loadLevel("level_1.lvl");
   
   float y = W_HEIGHT / 8 + W_WIDTH * 0.032f;
   float move_x = W_WIDTH * 0.073f;
   float move_y = W_WIDTH*0.040f;
   
   for (int i = 0; i < grid.length; i++) 
   {
     float x = W_WIDTH * 0.0626f;
    for (int j = 0; j < grid[i].length; j++) 
    {
      int value = grid[i][j];
      if (value != 0) 
      { 
        blocos[i][j] = new Blocos(x, y, W_WIDTH * 0.072f, cores[value]);
      }
       x += move_x;
    }
    y += move_y;
  } 
  
  startTime = millis(); // Inicializar o tempo de início

}

void createBlocks()
{
  
   float y = W_HEIGHT / 8 + W_WIDTH * 0.032f;
   float move_x = W_WIDTH * 0.073f;
   float move_y = W_WIDTH*0.040f;
   
   for (int i = 0; i < grid.length; i++) 
   {
     float x = W_WIDTH * 0.0626f;
    for (int j = 0; j < grid[i].length; j++) 
    {
      int value = grid[i][j];
      if (value != 0) 
      { 
        blocos[i][j] = new Blocos(x, y, W_WIDTH * 0.072f, cores[value]);
      }
       x += move_x;
    }
    y += move_y;
  } 
}

void removeBlocks()
{
   
   for (int i = 0; i < grid.length; i++) 
   {
    for (int j = 0; j < grid[i].length; j++) 
    {
      int value = grid[i][j];
      if (value != 0) 
      { 
        blocos[i][j] = null;
      }
    }
  } 
}


void loadLevel(String filename) {
  String[] lines = loadStrings(filename);
  for (int i = 0; i < lines.length; i++) {
    String[] values = lines[i].split(",");
    for (int j = 0; j < values.length; j++) {
      grid[i][j] = int(values[j].trim());
    }
  }
}

void update()
{
  int oldTime = this.time;
  this.time = millis();
  float deltaT = (this.time - oldTime)/1000.0f; 
  update(deltaT);
  
}



void update(float deltaT)
{
    Pad.move(deltaT);
}

void collisionDetection()
{
  if(Pad.x - 34 <= RectanglesLim[0].x) 
  {
    Pad.isMovingLeft = false;
  }
  if(Pad.x >= RectanglesLim[1].x - 34)
  {    
    Pad.isMovingRight = false;
  }
  
  
}

void collisionDetectionBlocks()
{
  for(int i = 0; i < 15; i++)
  {
    for(int j = 0; j < 13; j++)
    {
      
      block_global = 0;
      if(blocos[i][j] != null)
      {
        Pad.collisionDetectionBlock(blocos[i][j].x - (W_WIDTH * 0.072f/2),blocos[i][j].x + (W_WIDTH * 0.072f/2), blocos[i][j].y - (W_WIDTH * 0.072f/4), blocos[i][j].y + (W_WIDTH * 0.072f/4));
        if(block_global == 1)
        {
          if(grid[i][j] == 1)
          {
             blocos[i][j] = null;
             currentPoints += 50;
          }
          else if(grid[i][j] == 2)
          {
            blocos[i][j] = null;
            currentPoints += 60;
          }
          else if(grid[i][j] == 3)
          {
            blocos[i][j] = null;
            currentPoints += 70;
          }
          else if(grid[i][j] == 4)
          {
             blocos[i][j] = null;
             currentPoints += 80;
          }
          else if(grid[i][j] == 5)
          {
             blocos[i][j] = null;
             currentPoints += 90;
          }
          else if(grid[i][j] == 6)
          {
             blocos[i][j] = null;
             currentPoints += 100;
          }
          else if(grid[i][j] == 7)
          {
             blocos[i][j] = null;
             currentPoints += 110;
          }
          else if(grid[i][j] == 8)
          {
              numColision[i][j] += 1;
              if(numColision[i][j] == 2)
              {
                blocos[i][j] = null;
                currentPoints += 200;
                
              }
          }
          
          float result = 0;
          for(int a = 0; a < 15; a++)
          {
            for(int b = 0; b < 13; b++)
            {
              if(blocos[a][b] != null && a != 9)
              {
                result = 1;
              }
            }
          }
          if(result == 0)
          {
            int nextLevel = currentLevel + 1;
            String nextLevelFilename = "level_" + nextLevel + ".lvl";
            if (nextLevel <= 5) 
            { 
              removeBlocks();
              loadLevel(nextLevelFilename);
              createBlocks();
              Pad = new Pad(W_WIDTH/2, W_HEIGHT*0.9f, W_WIDTH*0.023f, W_WIDTH/8, PI/2, YELLOW);
              value_global = 0;
              levelStarting = true;
              startTime = millis();
              currentLevel = nextLevel;
              currentPoints = 0;
              lives = 3;
            }
            else 
            {
              
            }
          }
          
        }
      }
    }
  }
  
}

void keyPressed()
{
  if(key == ' ')
     {
       Pad.isMovingBall = true;
       value_global = 1;
       
     }
  if(key == '1')
  {
    removeBlocks();
    loadLevel("level_1.lvl");
    createBlocks();
    Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW);
    value_global = 0;
    levelStarting = true;
    startTime = millis();
    currentLevel = 1;
    currentPoints = 0;
    lives = 3;
    
  }
  else if(key == '2')
  {
    removeBlocks();
    loadLevel("level_2.lvl");
    createBlocks();
    Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW);
    value_global = 0;
    levelStarting = true;
    startTime = millis();
    currentLevel = 2;
    currentPoints = 0;
    lives = 3;
 
  }
  else if(key == '3')
  {
    removeBlocks();
    loadLevel("level_3.lvl");
    createBlocks();
    Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW);
    value_global = 0;
    levelStarting = true;
    startTime = millis();
    currentLevel = 3;
    currentPoints = 0;
    lives = 3;
 
  }
  else if(key == '4')
  {
    removeBlocks();
    loadLevel("level_4.lvl");
    createBlocks();
    Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW);
    value_global = 0;
    levelStarting = true;
    startTime = millis();
    currentLevel = 4;
    currentPoints = 0;
    lives = 3;
 
  }
  else if(key == '5')
  {
    removeBlocks();
    loadLevel("level_5.lvl");
    createBlocks();
    Pad = new Pad(W_WIDTH/2,W_HEIGHT*0.9f,W_WIDTH*0.023f,W_WIDTH/8,PI/2,YELLOW);
    value_global = 0;
    levelStarting = true;
    startTime = millis();
    currentLevel = 5;
    currentPoints = 0;
    lives = 3;
 
  }
  
  if (key == CODED) 
    { 
      if(keyCode == RIGHT)
     {  
        if(Pad.x <= RectanglesLim[1].x - 34)
        {    
          Pad.isMovingRight = true;
        }  
     }
     if(keyCode == LEFT)
     {
         if(Pad.x - 34 >= RectanglesLim[0].x)
        {    
          Pad.isMovingLeft = true;
        }
     }
  }
}

void keyReleased()
{
  
  if (key == CODED) 
    { 
      if(keyCode == RIGHT)
    {
      Pad.isMovingRight = false;
    }
     if(keyCode == LEFT)
     {
       Pad.isMovingLeft = false;
     }
     
  }
}

void drawBanner() 
{ 

  textFont(titleFont, 30);
  fill(LIGHT_BLUE);
  textAlign(CENTER);
  text("UALGANOID",W_WIDTH/2,W_HEIGHT/17);
  textFont(scoreFont, 24);
  fill(WHITE);
  text("Score: " + currentPoints, W_WIDTH/6, W_HEIGHT/9);
  textFont(scoreFont, 24);
  fill(WHITE);
  text("Lives: " + lives, W_WIDTH * 0.82f, W_HEIGHT/9);
}

void drawLevel()
{
  if (levelStarting) 
  {
    int elapsedTime = millis() - startTime;
    if (elapsedTime < 2000) 
    { // Desvanecer ao longo de 2 segundos
      textOpacity = int(map(elapsedTime, 0, 2000, 255, 0));
    } else 
    {
      textOpacity = 0;
      levelStarting = false; // Parar de desvanecer após 2 segundos
    }
  
  textFont(lvlFont, 35);
  fill(LIGHT_BLUE, textOpacity);
  textAlign(CENTER);
  text("LEVEL " + currentLevel, W_WIDTH/2, W_HEIGHT/2);
  
  }
}

void draw()
{
  background(BLACK);
  drawBanner();
  update();
  collisionDetection();
  strokeWeight(1); 
  stroke(0);
    
  for(int i = 0; i < 15; i++)
  {
    for(int j = 0; j < 13; j++)
    {
      if (blocos[i][j] != null) {
        blocos[i][j].draw();
      }
    }
  }
  
  drawLevel();
  
  for(int i = 0; i < RectanglesLim.length; i++)
  {
    RectanglesLim[i].draw();
  }
  Pad.draw(); 
  collisionDetectionBlocks();
}
