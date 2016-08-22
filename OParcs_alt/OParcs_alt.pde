void setup(){
   size(1280, 720);
  image = loadImage("magma.jpg");
  print(image.width, image.height);
  background(0);
  for(int i = 0; i < numSnakes; i ++)
    snakes.add(new Snake(width/2, height/2, image));//random(width), random(height), image));
}
PImage image;
int numSnakes = 500;
ArrayList<Snake> snakes = new ArrayList<Snake>();
boolean makeSnakes = false;
void draw(){
  if (makeSnakes)
    snakes.add(new Snake(mouseX, mouseY, image));
  for(Snake snake : snakes)
    snake.move();
}
 
 
void mousePressed(){
  makeSnakes = true;
}
 
void mouseReleased(){
  makeSnakes = false;
}
 
void keyPressed(){
  switch(key){
    case ' ':
      snakes.clear();
      background(0);
      for(int i = 0; i < numSnakes; i ++)
    snakes.add(new Snake(width/2, height/2, image));//random(width), random(height), image));
      break;
  }
}
class Snake{
   
  PVector pos;
  PVector pivot;
  float arcLengthNum;
  float arcLengthDen;
  float arcRadius;
  float angle;
  float direction = 1;
  PImage picture;
   
  Snake(float x, float y, PImage img){
    pos = new PVector(x, y);
    pivot = new PVector(pos.x + random(-200, 200), pos.y + random(-200, 200));
    picture = img;
    picture.resize(width, height);
    setCourse();
  }
   
  void move(){
    if(abs(arcLengthNum) >= arcLengthDen)
      setCourse();
    else
    angle += 1/arcRadius * direction;
    arcLengthNum += 1/arcRadius * direction;
    pos.x = pivot.x + arcRadius * cos(angle);
    pos.y = pivot.y + arcRadius * sin(angle);
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      pos = new PVector(random(width), random(height));
      setCourse();
    }
     
    display();
  }
   
  void setCourse(){
    direction *= -1;
    PVector slope = new PVector(pos.x-pivot.x, pos.y-pivot.y);
    arcRadius = random(1, 50);
    arcLengthDen = random(0, 2*PI);// 2*PI - (PI - 2*PI/12);
    arcLengthNum = 0;
    if (arcRadius < 0)
      direction *= -1;
    slope.setMag(arcRadius);
    pivot.x = pos.x + slope.x;
    pivot.y = pos.y + slope.y;
    angle = atan((pos.y-pivot.y)/(pos.x-pivot.x));
    if (pos.x < pivot.x)
      angle = PI + angle;
  }
   
  void display(){
    color myColor = picture.get(int(pos.x), int(pos.y));
    stroke(myColor);
    point(pos.x, pos.y);
  }
   
}