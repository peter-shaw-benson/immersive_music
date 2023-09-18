function Turtle(xloc,yloc,angle){
  this.reset = function(xloc,yloc,angle){
    this.xloc = xloc;
    this.yloc = yloc;
    this.pxloc = xloc; 
    this.pyloc = yloc;
    this.angle = angle;
  }
  this.reset(xloc,yloc,angle);
}

Turtle.prototype.move = function(dist){
  this.pxloc = this.xloc;
  this.pyloc = this.yloc;
  this.xloc += noise(frameCount)*dist*cos(this.angle);
  this.yloc -= noise(frameCount)*dist*sin(this.angle);
  if (this.xloc >= width || this.xloc <= 0 || this.yloc <= 0 || this.yloc >= height) {
    this.angle += PI;
    this.xloc = this.pxloc;
    this.yloc = this.pyloc;
    // this.reset(width*noise(this.xloc),height*noise(this.yloc),random(TWO_PI));
  }
  this.display();
}
Turtle.prototype.turn = function(turn_angle){
  this.angle += turn_angle;
}
Turtle.prototype.display = function(){
  // ellipse(this.xloc,this.yloc,50,50);
  stroke(255,90);
  strokeWeight(map(INTENSITY,0,1, 20, 100));
  line(this.xloc,this.yloc,this.pxloc,this.pyloc);
}
// Turtle.prototype.reset = function(){
//   // ellipse(this.xloc,this.yloc,50,50);
//   line(this.xloc,this.yloc,this.pxloc,this.pyloc);
// }