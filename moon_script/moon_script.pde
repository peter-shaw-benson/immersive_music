/* // TO UPLOAD YOUR OWN IMAGES:
0. click on arrow on top left of screen to look at directory of files
1. click on the arrow next to images folder and delete the whole folder 
2. press the arrow next to 'Sketch Files' and create a new folder named 'images'
3. click on the arrow next to your empty images folder and upload files
VERY IMPORTANT: Make sure your file names are in this format: moon_#.jpg
   and you can change the value for #
   Also -- make sure your imgae numbers go up consecutively (don't skip any numbers)
4. Based on what you uploaded, update the number of images and the number of your first image with the two variables below
*/
import processing.sound.*;

// declare image variables
boolean firstUP = false;
int numimgs = 50; 
int first_image_number = 1;

// declare intensity variables
float INTENSITY = 0;
float accumINTENSITY = 0;
boolean SHOWIMG = false;
// let PRESET = 0;

// Declare turtle variables 
int size = 24; 
int numTurtles = 5; 
Turtle[] turtles = new Turtle[numTurtles];
int turtleSpeed = 4;


PImage[] imgs = new PImage[numimgs];
int currentImgIndex = 0;

AudioIn mic;
Amplitude amp;

void preload() {
  for (int i = first_image_number; i <= first_image_number+numimgs-1; i++){
    imgs[i-1] = loadImage("./images/moon_${i}.jpg");
  }
}

void setup() {
  // full screen start
  fullScreen();
  background(0);
  
  for (int i = 0; i < numTurtles; i++){
    turtles[i] = new Turtle(random(width-10),random(height-10),random(TWO_PI));
  }
  
  // create a new "mic"
  mic = new AudioIn(this, 0);
  mic.start();
  
  // need to create a dedicated audio analyzer
  amp = new Amplitude(this);
  amp.input(mic);
  
  // load in the images
  for (int i = first_image_number; i <= first_image_number+numimgs-1; i++){
    String filename = "./images/moon_" + i + ".jpg";
    
    imgs[i-1] = loadImage(filename);
    
    print("\nLoaded:\n");
    print(filename);
  }
}

int period = 200, slowestPeriod = 250, fastestPeriod = 5;
float INTENSITY_SENSITIVITY = 0.1;
float showThreshhold = 0.5;
int showIndex = 0;

void draw() {
  background(0,10);
  drawCracks(); 
  /* the following is used for real-time image speed reactions:
  // if (INTENSITY >= 0.8) {
  //   displayIMG(2);
  // } else if (INTENSITY > 0.6) {
  //   displayIMG(5);
  // } else if (INTENSITY > 0.2) {
  //   displayIMG(10);
  //   if (firstUP){
  //     SHOWIMG = true;
  //   }
  // }
  */

  noiseShape(); // that big spiky thing

  INTENSITY = amp.analyze();
  
  accumINTENSITY += INTENSITY/50;
  showIndex += INTENSITY/50;
    if (accumINTENSITY > INTENSITY_SENSITIVITY && SHOWIMG) {
      if (period > fastestPeriod+11){
        // SHOWIMG = true;
        period -= 10;
      }
      accumINTENSITY = 0;
    }
}


void drawCracks(){
  // if (PRESET == 0){
    for (int i = 0; i < numTurtles; i++){
      turtles[i].turn(random(-PI/12,PI/12));
      turtles[i].move(random(map(INTENSITY,0,1,0,100))*turtleSpeed+2);
    }
  // }
}

// used for drawing many cracks in one frame
void turtleShape(int turtleLength){
  // if (PRESET ==1){
    for (int i = 0; i < turtleLength; i++){
      drawCracks();
    }
  // }
}

void noiseShape(){
  // if (PRESET == 2){
    stroke(255, 15);
    strokeWeight(1);
    fill(255,100);
    translate(width/2, height/2);
    beginShape();
    for (var i = 0; i < 200; i++) {
      var ang = map(i, 0, 200, 0, TWO_PI);
      var rad = noise(i,frameCount)*400;
      var x = rad * cos(ang);
      var y = rad * sin(ang);
      curveVertex(x, y);
    }
    endShape(CLOSE);
    translate(0, 0);
  // }
}

void displayIMG(float period) {
  if (SHOWIMG){
    // stroke(255,90);
    // strokeWeight(5);
    if (frameCount%(round(period)) == 0){
      if (currentImgIndex > numimgs - 1) {
        currentImgIndex = 0;
      }
      tint(255, map(period, 200, 10, 0, 255));
      image(imgs[currentImgIndex],0,0,width,height);
      
      currentImgIndex++;
    }
  }
}