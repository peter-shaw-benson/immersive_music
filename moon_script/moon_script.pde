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
int numimgs = 2; 
int first_image_number = 1;

// declare intensity variables
float INTENSITY = 0;
float accumINTENSITY = 0;
boolean SHOWIMG = false;
// let PRESET = 0;

// Declare turtle variables 
int size = 24; 

// note: this also shouldn't be very high.
int numTurtles = 15; 
Turtle[] turtles = new Turtle[numTurtles];
int turtleSpeed = 5;

// note: this shouldn't be very high. 
int turtleTrailLength = 50;
// controls lines vs curves – lines might save CPU
// nvm, curves are better lol
boolean turtleLines = false;


PImage[] imgs = new PImage[numimgs];
int currentImgIndex = 0;

AudioIn mic;
Amplitude amp;

PImage currentImage;

void setup() {
  // full screen start
  //fullScreen();
  size(600, 600);
  background(0);
  
  for (int i = 0; i < numTurtles; i++){
    // create all the turtles
    turtles[i] = new Turtle(random(width-10),
                            random(height-10),
                            random(TWO_PI),
                            turtleTrailLength,
                            turtleLines);
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
  
    
  //  Current Image. Starts as the first image.
  currentImage = imgs[0];
}

int period = 200, slowestPeriod = 250, fastestPeriod = 5;
float INTENSITY_SENSITIVITY = 1.5;
float showThreshhold = 0.5;
int showIndex = 0;

void draw() {
  background(0,10);
  
  // The problem is that after it loops again, the image is reset. 
  // need to "hold" an image. 

   // scaled to the sensitivity.
   INTENSITY = amp.analyze() * INTENSITY_SENSITIVITY;
   
   // displays the current image
   if (SHOWIMG) {
     image(currentImage,0,0,width,height);
   }
   
   
   //the following is used for real-time image speed reactions. These change the index of the Current Image.
   if (INTENSITY >= 0.8) {
     displayIMG(2);
   } else if (INTENSITY > 0.6) {
     displayIMG(5);
   } else if (INTENSITY > 0.2) {
     //print("high intensity");
     displayIMG(10);
   } else {
     displayIMG(30);
   }
   
   
   // draw turtles last, in front
   drawCracks(); 
}


void drawCracks(){
  // if (PRESET == 0){
    for (int i = 0; i < turtles.length; i++){
      turtles[i].turn(random(-PI/12,PI/12));
      turtles[i].move(random(map(INTENSITY,0,1,0,100))*turtleSpeed+2);
    }
  // }
}

// used for drawing many cracks in one frame
void turtleShape(int turtleLength){
  // if (PRESET ==1){
    for (int i = 0; i < turtles.length; i++){
      drawCracks();
    }
  // }
}

void displayIMG(int period) {
  if (SHOWIMG){
    // stroke(255,90);
    // strokeWeight(5);
    if (frameCount % period == 0){
      if (currentImgIndex >= numimgs - 1) {
        currentImgIndex = 0;
      }
      
      tint(255, map(period, 200, 10, 0, 255));
      
      currentImgIndex++;
      
      currentImage = imgs[currentImgIndex];
    }
  }
}

void keyPressed(){
  if (keyCode == DOWN) {
    background(0);
    SHOWIMG = false;
  }
  if (keyCode == UP) {
    SHOWIMG = true;
    displayIMG(20);
    firstUP = true;
    
    print("showing");
  }
  
  // add or subtract turtles
  if (keyCode == RIGHT) {
    // add turtles
    Turtle newTurt = new Turtle(random(width-10),
                                random(height-10),
                                random(TWO_PI),
                                turtleTrailLength,
                                turtleLines);
    
    turtles = (Turtle[]) append(turtles, newTurt);
  } 
  
  if (keyCode == LEFT) {
    // removes one turtle from the end
    turtles = (Turtle[]) shorten(turtles);
  }
}
