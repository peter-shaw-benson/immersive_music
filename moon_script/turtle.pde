class Turtle {
  float xloc;
  float yloc;
  float pxloc;
  float pyloc;
  float angle;
  
  Turtle(float xloc, float yloc, float angle) {
    this.xloc = xloc;
    this.yloc = yloc;
    this.pxloc = xloc; 
    this.pyloc = yloc;
    this.angle = angle;
  }

  void move(float dist) {
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
  
  void turn(float turn_angle) {
    this.angle += turn_angle;
  }
  
  void display() {
    stroke(255,200);
    strokeWeight(map(INTENSITY,0,1, 10, 30));
    line(this.xloc,this.yloc,this.pxloc,this.pyloc);
  }
  
}
