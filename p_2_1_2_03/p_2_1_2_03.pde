
import processing.opengl.*;
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
int maxwaves = 4;   // total # of waves to add together

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // Height of wave
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)

void setup() {
  size(1920, 1080);
  frameRate(60);
  colorMode(RGB, 255, 255, 255, 100);
  w = width + 16;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10,50);
    float period = random(100,500); // How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
}

void draw() {
  background(RGB, 0, 77, 211);
  calcWave();
  renderWave();
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.01;

  // Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }
 
  // Accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      // Every other wave is cosine instead of sine
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  noStroke();
  fill(0, 93, 265, 50);
  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing,height/3+yvalues[x],7,7);
  }


  if (savePDF) {
    savePDF = false;
    endRaw();
  }
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}