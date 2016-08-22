// Draw the color spectrum by moving the mouse
// mouse position == the resolution
// right and left (x) controls the color block width and quantity
// up and down (y) controls the color block height and quantity

//ALTERATIONS
//I like the fundamental concept of this program, but wanted to make it starburst-like so I added rotate to the inner for loop. 
//I also played with translating it so the circle origin is in the middle of the canvas, but commented it out because I prefer former.  


//KEYS
// s: save png
// p: save pdf

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int stepX;
int stepY;

void setup(){
  size(1280, 720);
  background(0);
}

void draw(){
  if(savePDF) beginRecord(PDF, timestamp()+".pdf");
  noStroke();
  colorMode(HSB, width, height, 100);
  translate(400, 200);

  
  stepX = mouseX+2;
  stepY = mouseY+2;
  for( int gridY=0; gridY<height; gridY+=stepY){
    for(int gridX=0; gridX<width; gridX+=stepX){
      rotate(.5);
      fill(gridX, height-gridY, 100);
      rect(gridX, gridY, stepX, stepY);
    }
  }
  
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyPressed(){
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;
}

String timestamp(){
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}