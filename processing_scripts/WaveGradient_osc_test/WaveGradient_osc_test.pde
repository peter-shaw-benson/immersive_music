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
void setup() {
    //fullScreen();
    size(600,600);
    
    // Initialize an instance listening to port 12000
    oscP5 = new OscP5(this,12000);
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
}

void oscEvent(OscMessage theOscMessage) {
    
    if (theOscMessage.checkAddrPattern("/bang")) {
      // the bang should flip the circle color to red.
        red = !red;
        //print("flipped red\n");
    }
    
    if (theOscMessage.checkAddrPattern("/amp")) {
        float value = theOscMessage.get(0).floatValue();
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
