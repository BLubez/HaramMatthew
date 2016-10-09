import processing.sound.*;


Harambe saviour;
HurricaneMatthew storm;
Florida f;
Banana b;
int state = 0;

SoundFile RIPHarambe;


int score = 0;

int frameCount = 0;





void setup() {
  size(800, 800);
  saviour = new Harambe();
  saviour.y=height/2;
  storm = new HurricaneMatthew();
  f = null;

  RIPHarambe = new SoundFile(this, "HarambeSong.mp3");

  background(0);
  fill(255, 255, 0);
  
  strokeWeight(10);
  stroke(255, 255, 255);
}
void draw() {


  frameCount = (frameCount + 1) % 240;
  if (frameCount == 69 && f == null) {
    f = new Florida(random(width), random(height));  
  }
  if (b == null && frameCount == 69) {
    b = new Banana(random(width), random(height));  
  }
  
  
  saviour.update();
  storm.update();
  
  
  if (f != null && dist(f.x,f.y, storm.x, storm.y) < 100) {

    f = null;
    if (!(storm.speed <= 1))
    {
      storm.speed--;
    }
    score -= 5;
  }
  if (f != null && dist(f.x,f.y, saviour.x, saviour.y) < 25) {
    f = null;
    if (!(saviour.speed <= 2))
    {
      saviour.speed--;
    }
    score += 5;
  }

  if (b != null && dist(b.x,b.y, storm.x, storm.y) < 100) {
    b = null;
    storm.speed++;
  }
  if (b != null && dist(b.x,b.y, saviour.x, saviour.y) < 25) {
    b = null;
    saviour.speed += 1;
    score += 1;
  }
  

  if (dist(saviour.x,saviour.y, storm.x, storm.y) < 100) {
    state = 1;
    RIPHarambe.play();
  }

  background(0);


  stroke(0, 0, 0);

  fill(255, 255, 0);
  strokeWeight(10);
  stroke(255, 255, 255);
  
  if (f != null) {
   f.display(); 
  }
  if (b != null) {
   b.display(); 
  }

 saviour.display();
 storm.display();

 if(state == 1) {
  background(0);
  
  PImage img = loadImage("rip.jpg");
  img.resize(600, 338);
  textAlign(CENTER);
  text("RIP Harambe", 400, 320);
  image(img, 400 - 300, 320  - 169);
  //println("Score: " + score);
  text("Score: " + score, 400, 600);
  noLoop();
}


}
class Florida {
  float x;
  float y;
  int size;
  
  PImage img;
  
  public Florida(float x, float y){
    size = 50;
    this.x = x;
    this.y = y;
    img = loadImage("florida.png");
    img.resize(size,size);
  }
  
  void display() {
    image(img, x - .5 * size, y  - .5 * size);
  }

  
}
class Banana {
  float x;
  float y;
  int size;
  
  PImage img;
  public Banana(float x, float y){
    size = 50;
    this.x = x;
    this.y = y;
    img = loadImage("banana.png");
    img.resize(size,size);
  }

  void display() {
    image(img, x - .5 * size, y  - .5 * size);
  }
}
class Harambe  {

  int size;
  float y;
  float x;
  float speed;

  PImage img;

  public Harambe () {
    size = 50;
    x = 100;
    speed = 7;

    img = loadImage("harambe.png");
    img.resize(size,size);
  }


  void display() {
    image(img, x - .5 * size, y  - .5 * size);
  }
  void update() {
    float angle;
    if(dist(mouseX, mouseY, x, y) > 7.5) {
      angle = get_angle(mouseX, mouseY, x, y);
      x += get_movement_x(angle, speed);
      y += get_movement_y(angle, speed);
    }
  }
}

class HurricaneMatthew {

  int size;
  float x;
  float y;
  float speed;

  PImage img; 

  float targetX;
  float targetY;

  public HurricaneMatthew () {
    size = 200;
    x = 500;
    y = 500;
    speed = 1;
    img = loadImage("hurricaneMatthew.png");
    img.resize(size,size);
    targetX = saviour.x;
    targetY = saviour.y;
  }

  void display() {
    image(img, x - .5 * size, y  - .5 * size);
  }
  void update() {
    if (f == null) {
      targetX = saviour.x;
      targetY = saviour.y;
    } else {
      targetX = f.x;
      targetY = f.y;
    }
    
    float angle;
    angle=get_angle(targetX, targetY, x, y);
    x += get_movement_x(angle, speed);
    y += get_movement_y(angle, speed);
  }

}



float get_angle(float a1, float a2, float b1, float b2) {
  //'''Location A is player position and locationB is where the enemy is'''
  float tempx1=a1;
  float tempy1=a2;
  float x2=b1-tempx1;
  float y2=b2-tempy1;
  float angle=atan2(y2, x2);
  return angle;
}
float get_movement_x(float theta, float speed) {
  float x=cos(theta)*speed;
  float speedx=-x;
  return speedx;
}
float get_movement_y(float theta, float  speed) {
  float y=sin(theta)*speed;
  float speedy=-y;
  return speedy;
}