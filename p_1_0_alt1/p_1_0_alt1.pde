//ALTERATIONS
//- switched color space from HSB to RGB
//- changed canvas size grom 730 to 512
//- changed the fill color and rectangle position
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

void setup() {
  size(512, 512);
  noCursor();
}

void draw(){
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  colorMode(RGB, 256, 0, 0);
  rectMode(CENTER);
  noStroke();
  background(mouseY/2, 100, 100);
  fill(256-mouseY/2, 0, 0);
  rect(0, 256, mouseX+1, mouseX+1);
  
  if (savePDF){
    savePDF = false;
    endRecord();
  }
}

void keyPressed(){
  if(key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if(key=='p' || key=='P') savePDF = true;
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}