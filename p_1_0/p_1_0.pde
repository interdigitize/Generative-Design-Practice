import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

void setup() {
  size(720, 720);
  noCursor();
}

void draw(){
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  noStroke();
  background(mouseY/2, 100, 100);
  fill(360-mouseY/2, 100, 100);
  rect(360, 360, mouseX+1, mouseX+1);
  
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