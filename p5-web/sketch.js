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
let firstUP = false;
let numimgs = 0; 
let first_image_number = 1;

let INTENSITY = 0;
let accumINTENSITY = 0;
let SHOWIMG = false;
// let PRESET = 0;
const note = {currentNote: 0};

//Code starts here (play around with it if you want lol): 
var turtles = []; let size = 24; let numTurtles = 5; let turtleSpeed = 4; 
let imgs = [], currentImgIndex = 0; 
function preload(){
  for (let i = first_image_number; i <= first_image_number+numimgs-1; i++){
    imgs.push(loadImage(`./images/${i}.jpg`));
  }
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(0);
  for (let i = 0; i < numTurtles; i++){
    turtles[i] = new Turtle(random(width-10),random(height-10),random(TWO_PI));
  }
  mic = new p5.AudioIn();
  mic.start();
}
let period = 200, slowestPeriod = 250, fastestPeriod = 5;
INTENSITY_SENSITIVITY = 0.1
let showThreshhold = 0.5;
let showIndex = 0;

function draw() {
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

  INTENSITY = mic.getLevel();
  
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


function drawCracks(){
  // if (PRESET == 0){
    for (let i = 0; i < numTurtles; i++){
      turtles[i].turn(random(-PI/12,PI/12));
      turtles[i].move(random(map(INTENSITY,0,1,0,100))*turtleSpeed+2);
    }
  // }
}

// used for drawing many cracks in one frame
function turtleShape(length){
  // if (PRESET ==1){
    for (let i = 0; i < length; i++){
      drawCracks();
    }
  // }
}

function noiseShape(){
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

function displayIMG(period){
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
