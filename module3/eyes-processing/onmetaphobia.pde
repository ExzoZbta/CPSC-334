import hypermedia.net.*;
import java.util.ArrayList;

UDP udp;

PImage backgroundImage;

ArrayList<Eye> eyes = new ArrayList<Eye>();
String lightMessage = "";
String touchMessage = "";
int touchThreshold = 35;
int touchTimer = 0;
int maxEyes = 20;

void setup() {
  udp = new UDP(this, 4200);
  udp.log(true);
  udp.listen(true);

  size(640, 440);
  noStroke();
  eyes.add(new Eye(250, 16, 120)); // Add the initial eye

  // Load the background image from the data folder
  backgroundImage = loadImage("background.jpg"); // replace with your desired image
}

void draw() {
  background(102);

  image(backgroundImage, 0, 0);

  for (Eye eye : eyes) {
    eye.update();
    eye.display(extractLightValue(lightMessage));
  }

  // Extract the touch value from the received message
  if (eyes.size() < maxEyes) {
    int touchValue = extractTouchValue(touchMessage);

    if (touchValue < touchThreshold) {
      touchTimer++;
      if (touchTimer >= 3 * 60) { // 3 seconds (assuming 60 frames per second)
        Eye newEye = null; // Initialize newEye to null
        boolean canAddEye = true;
        while (canAddEye) {
          newEye = new Eye(int(random(50, width - 50)), int(random(50, height - 50)), int(random(50, 250)));
          canAddEye = checkCollision(newEye);
        }
        eyes.add(newEye);
        touchTimer = 0; // Reset the timer after creating a new eye
      }
    } else {
      touchTimer = 0;
    }
  }
}

class Eye {
  int x, y;
  int size;
  float angle = 0.0;
  float pupilX; // Current pupil X position
  float pupilY; // Current pupil Y position
  float t; // Time for pupil movement
  
  float eyelidTop; // Eyelid top position
  float eyelidBottom; // Eyelid bottom position
  
  Eye(int tx, int ty, int ts) {
    if (eyes.isEmpty()) {
      // If it's the first eye, place it in the middle of the screen
      x = width / 2;
      y = height / 2;
    } else {
      x = tx;
      y = ty;
    }
    
    size = ts;
    pupilX = random(-size / 6, size / 6); // Random initial pupil position
    pupilY = random(-size / 6, size / 6); // Random initial pupil position
    t = random(TWO_PI); // Random initial time for smooth movement
    
    eyelidTop = size / 4; // Initial eyelid position
    eyelidBottom = size / 4; // Initial eyelid position
  }

  void update() {
    // Simulate independent pupil movement using Perlin noise
    float noiseX = map(noise(t), 0, 1, -size / 6, size / 6);
    float noiseY = map(noise(t + 1000), 0, 1, -size / 6, size / 6);
    pupilX = lerp(pupilX, noiseX, 0.05);
    pupilY = lerp(pupilY, noiseY, 0.05);
    t += 0.01;
  }

  void display(int lightValue) {
    pushMatrix();
    translate(x, y);
    fill(0);
    ellipse(0, 0, size, size);

    // Eyelid
    fill(100); // Eyelid color
    ellipse(size / 4, 0, size, size / 2); // Draw eyelid
    
    // Calculate pupil size based on light value
    float pupilSize = map(lightValue, 0, 4095, size / 2.7, 0);
    fill(230); // pupil color
    ellipse(size / 4 + pupilX, pupilY, pupilSize, pupilSize); // draw pupil

    popMatrix();
  }
}

void receive(byte[] data, String ip, int port) {
  String message = new String(data);
  println("receive: \"" + message + "\" from " + ip + " on port " + port);

  // Check the message type and assign it to the appropriate variable
  if (message.startsWith("Light: ")) {
    lightMessage = message;
  } else if (message.startsWith("Touch Value: ")) {
    touchMessage = message;
  }
}

// Function to extract the light value from the message
int extractLightValue(String message) {
  String[] parts = splitTokens(message);
  if (parts.length >= 2) {
    return int(parts[1]);
  } else {
    return 0; // Default value
  }
}

// Function to extract the touch value from the message
int extractTouchValue(String message) {
  String[] parts = splitTokens(message);
  if (parts.length >= 2) {
    return int(parts[2]);
  } else {
    return 0; // Default value
  }
}

// Function to ensure eyes do not generate over one another
boolean checkCollision(Eye newEye) {
  for (Eye eye : eyes) {
    float distance = dist(newEye.x, newEye.y, eye.x, eye.y);

    // Calculate the maximum allowed distance between eyes
    float maxDistance = (newEye.size / 2 + eye.size / 2) + (newEye.eyelidTop / 2) + (eye.eyelidTop / 2);

    if (distance < maxDistance) {
      return true; // Collision detected
    }
  }
  return false; // No collision
}
