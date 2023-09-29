class Turtle {
  float xloc;
  float yloc;
  float angle;
  
  // number of previous points to store, and array inits
  int numPrevious = 0;
  float[] previousX;
  float[] previousY;
  
  Turtle(float xloc, float yloc, float angle, int numPrevious) {
    this.xloc = xloc;
    this.yloc = yloc;
    this.angle = angle;
    this.numPrevious = numPrevious;
    
    //print("\n", numPrevious);
    
    previousX = new float[numPrevious];
    previousY = new float[numPrevious];
    
    //print("\n", this.previousX.length);
    
    for (int i = 0; i < numPrevious; i++) {
      previousX[i] = xloc;
      previousY[i] = yloc;
    }  
    
    //print(previousX[numPrevious-1]);
  }
  
  void pushStack() {
    //print("pushing stack");
    
    previousX = (float[]) splice(previousX, this.xloc, 0);
    previousY = (float[]) splice(previousY, this.yloc, 0);
    
    previousX = (float[]) shorten(previousX);
    previousY = (float[]) shorten(previousY);

  }

  void move(float dist) {
    
    // log previous location.
    pushStack();
    
    this.xloc += noise(frameCount)*dist*cos(this.angle);
    this.yloc -= noise(frameCount)*dist*sin(this.angle);
    
    if (this.xloc >= width || this.xloc <= 0 || this.yloc <= 0 || this.yloc >= height) {
      this.angle += PI;
      
      // the previous location. 
      this.xloc = this.previousX[0];
      this.yloc = this.previousY[0];
      // this.reset(width*noise(this.xloc),height*noise(this.yloc),random(TWO_PI));
    }
    
    this.display();
  }
  
  void turn(float turn_angle) {
    this.angle += turn_angle;
  }
  
  void display() {
    
    // take 2 with curves
    // draw a point 
    stroke(255, 230);
    strokeWeight(map(INTENSITY,0,1, 12, 36));
    point(this.xloc, this.yloc);
    
    noFill();
    beginShape();
    
    stroke(255,180);
    
    float tempStrokeWeight = map(INTENSITY,0,1, 10, 30); 
    
    strokeWeight(tempStrokeWeight);
    
    curveVertex(this.xloc, this.yloc);
    
    for (int i = 0; i < numPrevious; i++) {
      
      curveVertex(this.previousX[i], this.previousY[i]);
    }
    
    endShape();
  }
  
}
