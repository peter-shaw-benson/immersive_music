import oscP5.*;
import netP5.*;
OscP5 osc;
NetAddress receiver;
float pitch = 0;
float yaw = 0;
float roll = 0;
int maxIn = 0;
void setup() {
  size(500, 500, P3D);
  osc = new OscP5(this, 7400);


  ////FOR SENDING:
  //receiver = new NetAddress("10.0.0.238" , 9000);
  //OscMessage m = new OscMessage("/hello");
  //osc.send(m, receiver);
}
float xAccel = 0;
float yAccel = 0;
float zAccel = 0;
float accel_mag = 0;
float xVel = 0;
float yVel= 0;
float zVel = 0;
float xPos = 250;
float yPos= 250;
float zPos = 0;
int r = 50;
float xTheta = 0;
float yTheta = 0;
float zTheta = 0;
float p_xTheta = 0;
float p_yTheta = 0;
float p_zTheta = 0;
void draw() {
  background(0);

  //background(255);
  pushMatrix();
  //translate(xPos, yPos, zPos);
  translate(width/2,height/2,0);
  rotateY((yTheta+p_yTheta)/2);
  rotateX((xTheta+p_xTheta)/2);
  rotateZ((zTheta+p_zTheta)/2);
  box(100+accel_mag*100 + maxIn);
  popMatrix();



  //theta = -yaw;
  //translate(width/2, height/2);
  //line(cos(theta)*r, sin(theta)*r, - cos(theta)*r, -sin(theta)*r);
}

void oscEvent(OscMessage m) {
  //  if(m.checkAddrPattern("/sinosc")==true){
  //    println("recieved");
  //  }
  //println("recieved message");
  println(m);
  if (m.checkAddrPattern("/syntien/motion/1/scope2") == true) {
    //println("recieved motion scope 2: ");
    roll = m.get(0).floatValue();
    pitch = m.get(1).floatValue();
    yaw = m.get(2).floatValue();
    p_xTheta = xTheta;
    p_zTheta = zTheta;
    p_yTheta = yTheta;
    xTheta = -pitch;
    zTheta = -yaw;
    yTheta = roll;
    //print(m.get(0).floatValue() + " " + m.get(1).floatValue() + " " + m.get(2).floatValue() + "\n");
  }
  if (m.checkAddrPattern("/syntien/motion/1/scope1") == true) {
    xAccel = (float) round(m.get(0).floatValue()*2)/100;
    yAccel = (float) round(m.get(1).floatValue()*2)/100;
    zAccel = (float) round(m.get(2).floatValue()*2)/100;
    accel_mag =pow(pow(xAccel,2)+pow(yAccel,2)+pow(zAccel,2),.5);
    println(accel_mag);
    xVel += xAccel;
    //yVel += yAccel;
    //zVel += zAccel;

    
    //if (xVel>0){
    //  xAccel += -.005;
    //} else {
    //  xAccel += .005;
    //}
    
    xPos += xVel;
    yPos += yVel;
    //zPos += zVel;

    println("x: " + xAccel);
    println("y: " + yAccel);
    //println("z: " + zAccel);
  }
  if (m.checkAddrPattern("/max") == true) {
    maxIn = m.get(0).intValue();
    println(maxIn);
  }

  //println("addrpattern: " + m.addrPattern());
  //println("typetag: " + m.typetag());
  //println("timetag: " + m.timetag());
  //println(m.get(0).floatValue());
  //println(m.toString());
}
