import processing.serial.*;

Serial esp32;

String[] emotions = {"Joy", "Sadness", "Anger", "Surprise"};
int currentEmotionIndex = 0;  // Index of the currently selected emotion

boolean lastButtonState = true;  // Keep track of the last button state (initially set to released)
boolean lastSwitchState = false; // Last state of the switch

boolean displayEmotionsScreen = true; // Control the display of the emotion selection screen
float emotionBoxSize = 200; // Initial size of the emotion box
float zoomFactor = 0.1; // Zoom factor for the emotion text
float curvyLineFactor = 50; // Factor for adjusting the curvy line

boolean switchOn = false; // Variable to track switch state

PVector joystickPos; // Current joystick position


void setup() {
  size(640, 360);
  // Connect to the Arduino serial port (change the port name as needed)
  String portName = "/dev/cu.usbserial-10"; // Replace with your correct port name
  esp32 = new Serial(this, portName, 9600);
  esp32.bufferUntil('\n');  // Set a newline character as the data delimiter
  
  joystickPos = new PVector(width / 2, height / 2); // Initialize joystick position at the center
}

float xoff = 0.0; // 1st dimension of perlin noise
float yoff = 0.0; // 2nd dimension of perlin noise
float xoffMultiplier = 0.02; // Adjust this multiplier for xoff (increased)
float yoffMultiplier = 0.02; // Adjust this multiplier for yoff (increased)

void draw() {
  if (switchOn) {
    // If the switch is on, set the canvas to black
    background(10);
    displayEmotionsScreen = false;

    color wave_color = color(255); // Default to white
    
    String currentEmotion = emotions[currentEmotionIndex];

    float xoff = joystickPos.x * xoffMultiplier; // Use joystick's x value to control xoff
    float yoff = joystickPos.y * yoffMultiplier; // Initialize yoff
    
    if (currentEmotion.equals("Joy")) {
      wave_color = color(255, 255, 0);
      xoffMultiplier = 0.02; // Adjust this for Joy (jumpy but not aggressive)
      yoffMultiplier = 0.02;
    } else if (currentEmotion.equals("Sadness")) {
      wave_color = color(0, 0, 255);
      xoffMultiplier = 0; // Adjust this for Sadness (slower and more gentle)
      yoffMultiplier = 0.01;
    } else if (currentEmotion.equals("Anger")) {
      wave_color = color(255, 0, 0);
      xoffMultiplier = 0.08; // Adjust this for Anger (more severe and rapid)
      yoffMultiplier = 0.04;
    } else if (currentEmotion.equals("Surprise")) {
      wave_color = color(255, 128, 0);
      xoffMultiplier = 0.0; // Adjust this for Surprise (very ecstatic and instant)
      yoffMultiplier = 0.08;
    }

    // Set the fill color based on wave_color
    fill(wave_color);
    // Draw the wave
    beginShape(); 
    
    // Iterate over horizontal pixels
    for (float x = 0; x <= width; x += 10) {
      // the noise generator using joystick's x and y values
      float y = map(noise(xoff, yoff), 0, 1, 200, 300); 
      
      // Set the vertex
      vertex(x, y); 
      // Increment x dimension for noise
      xoff += xoffMultiplier;
      // Increment y dimension for noise
      yoff += yoffMultiplier;
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  
  } else {
    background(255);
    displayEmotionsScreen = true;
    
    if (displayEmotionsScreen) {
      // Zoom-in effect for the emotion text
      zoomFactor += 0.02;
      if (zoomFactor >= 1.0) {
        zoomFactor = 1.0;
      }

       drawEmotionsScreen();
    }
  }
}

void drawEmotionsScreen() {
  // Add the static text at the top of the screen
  textSize(16);
  textAlign(CENTER);
  fill(0);
  text("Select the most prominent emotion you've felt recently", width / 2, 30);

  // Add the curvy line below the text label with adjusted factor
  stroke(0);
  noFill();
  beginShape();
  float yOff = curvyLineFactor;  // Adjust the curve's vertical position with factor
  for (int x = 0; x <= width; x += 10 * zoomFactor) {
    float y = yOff + sin(radians(x)) * 10 * zoomFactor; // Adjust the curve's shape and amplitude with zoomFactor
    vertex(x, y);
  }
  endShape();

  // Display the instruction text at the bottom
  textSize(20);
  textAlign(CENTER, TOP);
  text("Cycle through the emotions with a button press", width / 2, (height - 50));

  // Update emotionBox size based on zoom factor
  float displayedSize = emotionBoxSize * zoomFactor;

  // Draw the abstract emotionBox based on the currently selected emotion
  drawEmotionBox(emotions[currentEmotionIndex], displayedSize);
}

void drawEmotionBox(String emotion, float size) {
  // Customize the emotionBox based on the selected emotion

  // Define colors for each emotion
  color joyColor = color(255, 255, 0);      // Yellow for Joy
  color sadnessColor = color(0, 0, 255);   // Blue for Sadness
  color angerColor = color(255, 0, 0);     // Red for Anger
  color surpriseColor = color(255, 128, 0); // Orange for Surprise

  // Set the fill color based on the current emotion
  if (emotion.equals("Joy")) {
    fill(joyColor);
  } else if (emotion.equals("Sadness")) {
    fill(sadnessColor);
  } else if (emotion.equals("Anger")) {
    fill(angerColor);
  } else if (emotion.equals("Surprise")) {
    fill(surpriseColor);
  }

  // Draw a colored box with the emotion text
  rectMode(CENTER);
  rect(width / 2, height / 2, size, size);

  // Draw the emotion text on top of the colored box with zoomFactor
  textSize(32 * zoomFactor);
  textAlign(CENTER, CENTER);
  fill(0);
  text(emotion, width / 2, height / 2);
}

float joystick_min = 0;
float joystick_max = 4095;
float map_min = 0;

// esp32 data reader
void serialEvent(Serial p) { 
  String serialEvent = p.readString(); 
  if (serialEvent.startsWith("VRX:")) {
    int x_value = int(serialEvent.substring(5).trim());
    println("Joystick X-value: " + x_value);
    
    // Map the joystick X-value to the canvas width
    joystickPos.x = map(x_value, joystick_min, joystick_max, map_min, width);
  } else if (serialEvent.startsWith("VRY:")) {
    int y_value = int(serialEvent.substring(5).trim());
    println("Joystick Y-value: " + y_value);
    
    // Map the joystick Y-value to the canvas height
    joystickPos.y = map(y_value, joystick_min, joystick_max, map_min, height);
  } else if (serialEvent.startsWith("SWITCH:")) {
    int switch_value = int(serialEvent.substring(8).trim());

    if (switch_value == 0) {
      switchOn = false;
    } else if (switch_value == 1) {
      println("Switch State: 1");  
      switchOn = true;
    }     
  } else if (serialEvent.startsWith("BUTTON:")) {
    int button_value = int(serialEvent.substring(8).trim());
    
    if (button_value == 1) {
      println("Button State: 1");
      currentEmotionIndex = (currentEmotionIndex + 1) % emotions.length;
      zoomFactor = 0.1; // Reset zoom factor for zoom-out effect
    }
  }
}

