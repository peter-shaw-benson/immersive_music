function keyPressed(){
  if (keyCode === DOWN_ARROW) {
    background(0);
    SHOWIMG = false;
  }
  if (keyCode === UP_ARROW) {
    SHOWIMG = true;
    displayIMG(1);
    firstUP = true;
  }
  if (keyCode === RIGHT_ARROW) {
    turtles.push(new Turtle(random(width-10),random(height-10),random(TWO_PI)));
    numTurtles++;
  }
  if (keyCode === LEFT_ARROW) {
    turtles.pop();
    numTurtles--;
  }
  
}

function mousePressed() {
  userStartAudio();
}