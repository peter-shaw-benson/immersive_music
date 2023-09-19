import oscP5.*;
//OSC receive
OscP5 oscP5;
// This value is set by the OSC event handler
float amplitude = 0;
// Declare a scaling factor
float scale=6;
// Declare a smooth factor
float smooth_factor=0.1;
// Used for smoothing
float sum;
// set by the Bang message
boolean red = false;

boolean square = true;
float squareX = 0;
float squareY = 0;
float touchIntensity = 0;

void setup() {
    //fullScreen();
    size(600,600);
    
    // SET THIS PORT ON THE PHONE. MAKE SURE THEY MATCH.
    // also make sure you know the computer's IP address on the LOCAL NETWORK. 
    // Initialize an instance listening to port 57120
    oscP5 = new OscP5(this,57120);
}
void draw() {
    background(0);
    // smooth the amplitude data by the smoothing factor
    sum += (amplitude - sum) * smooth_factor;
    // scaled to height/2 and then multiplied by a scale factor
    float amp_scaled=sum*(height/2)*scale;
    
    float mappedColor = map(amplitude * scale, 0, 1, 0, 255);
    
    if (red) {
      fill(255, mappedColor, 0);
    } else {
      fill(0, mappedColor, 255);
    }
    ellipse(width/2, height/2, amp_scaled / 2, amp_scaled / 2);
    
    // check for super basic button thingy
    if (square) {
      fill(touchIntensity, 0, 0);
      square(squareX, squareY, 200);
    }
}

void oscEvent(OscMessage message) {
  
    //print(message);
    
    if (message.checkAddrPattern("/bang")) {
      // the bang should flip the circle color to red.
        red = !red;
        //print("flipped red\n");
    }
    
    if (message.checkAddrPattern("/syntien/basic/1/button1")) {
      //print("receiving from phone\n");
      //print(theOscMessage, "\n");
     
      print(message);
      
      if (message.get(0).intValue() == 0) {
        square = !square;
      }
    }
    
    if (message.checkAddrPattern("/syntien/basic/1/slider1")) {
      //print("receiving from phone\n");
      //print(message.get(0).floatValue(), "\n");
      
      float sliderValue = message.get(0).floatValue();
      
      // scale to the width. 
      squareX = (int) (sliderValue * 600);
      print(squareX);
    }
    
    if (message.checkAddrPattern("/syntien/basic/1/slider2")) {
      //print("receiving from phone\n");
      //print(theOscMessage, "\n");
      
      float sliderValue = message.get(0).floatValue();
      
      // scale to the width. 
      squareY = (int) (sliderValue * 600);
    }
    
    // touch messages
    if (message.checkAddrPattern("/syntien/basic/1/touchpad1/press")) {
      //print("receiving from phone\n");
      //print(theOscMessage, "\n");
      
      float touchX = message.get(0).floatValue();
      float touchY = message.get(1).floatValue();
      
      float touch = message.get(2).floatValue();
      
      squareX = map(touchX, 0, 1, 0, width);
      squareY = map(touchY, 0, 1, height, 0);
      
      if (touch > 0) {
        touchIntensity = map(touch, 0, 6.66, 100, 255);
      }
      
    }
    
    // accelerometer processing
    // roll, pitch, yaw (in radians); largest is pi, smallest is -pi. 
    if (message.checkAddrPattern("/syntien/motion/1/scope2")) {
      //print("receiving from phone\n");
      //print(theOscMessage, "\n");
      
      float roll = message.get(0).floatValue();
      float pitch = message.get(1).floatValue();
      
      float yaw = message.get(2).floatValue();
      
      squareX = map(roll, -1, 1, 0, width);
      squareY = map(pitch, -0.5, 1, 0, height);
      
      touchIntensity = map(yaw, 0.5, -0.5, 100, 255);
      
    }
    
    // accelerometer processing
    // this is acceleration
    // roll, pitch, yaw (in radians); largest is pi, smallest is -pi. 
    if (message.checkAddrPattern("/syntien/motion/1/scope1")) {
      //print("receiving from phone\n");
      //print(theOscMessage, "\n");
      
      float roll = message.get(0).floatValue();
      float pitch = message.get(1).floatValue();
      
      float yaw = message.get(2).floatValue();
      
      float totalAcceleration = roll + pitch + yaw;
      // you can basically do anything here – use these to set a new thing? 
      // probably best to sum this over a period of time
    }
    
    
    if (message.checkAddrPattern("/amp")) {
        float value = message.get(0).floatValue();
        if (value > 0.4) {
            amplitude = value;
        } else {
            amplitude = 0.0;
        }
        
        if (value > 0.7) {
          red = !red;
        }
    }
}
