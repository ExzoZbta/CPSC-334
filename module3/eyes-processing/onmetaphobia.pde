import hypermedia.net.*;
import java.util.ArrayList;

UDP udp;

PImage backgroundImage;

ArrayList<Eye> eyes = new ArrayList<Eye>();
String lightMessage = "";
String touchMessage = "";
String touch2_Message = "";
int touchThreshold = 54;
int touchTimer = 0;
int maxEyes = 20;
int eyeRemovalInterval = 60 * 60; // 60 seconds
int lastEyeRemovalTime = 0;

void setup() {
  udp = new UDP(this, 4200);
  udp.log(true);
  udp.listen(true);

  size(640, 440);
  noStroke();
  eyes.add(new Eye(250, 16, 120)); // Add the initial eye

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
  int touchValue = extractTouchValue(touchMessage);
  int touch2Value = extractTouchValue(touch2_Message);

  if (eyes.size() < maxEyes) {
    if (touchValue < touchThreshold && touch2Value > touchThreshold) {
      touchTimer++;
      if (touchTimer >= 3 * 60) { // 3 seconds 
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
  
  if (touch2Value < touchThreshold && touchValue < touchThreshold) {
    for (Eye eye : eyes) {
      eye.cryTearsOfBlood();
    }
  }

  // Check for eye removal
  if (frameCount - lastEyeRemovalTime >= eyeRemovalInterval && eyes.size() > 1) {
    // Remove an eye
    eyes.remove(0); 
    lastEyeRemovalTime = frameCount;
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

  boolean cryingTearsOfBlood = false;
  int cryStartTime = 0;

  Eye(int tx, int ty, int ts) {
    if (eyes.isEmpty()) {
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

    if (cryingTearsOfBlood == true) {
      int cryDuration = 2 * 60; // 2 seconds
      if (millis() - cryStartTime >= cryDuration) {
        cryingTearsOfBlood = false;
      }
    }
  }

  ArrayList<BloodDrop> bloodDrops = new ArrayList<BloodDrop>();
  
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

    if (cryingTearsOfBlood) {
      // Calculate the number of blood drops based on eye size
      int numBloodDrops = int(map(size, 50, 250, 5, 15));

      // Simulate blood drops
      for (int i = 0; i < numBloodDrops; i++) {
        if (random(1) < 0.1) {
          float bloodX = random(-size / 7, size / 2); // Random position near the eye
          float bloodY = size / 10 + size / 8; // Centered below the pupil
          float bloodSize = map(size, 50, 250, 5, 15); // Size of blood drops proportional to eye size
          float bloodSpeed = random(1, 3); // Random speed for gravity effect

          BloodDrop bloodDrop = new BloodDrop(bloodX, bloodY, bloodSize, bloodSpeed);
          bloodDrops.add(bloodDrop);
        }
      }

      // Update and display blood drops
      for (int i = bloodDrops.size() - 1; i >= 0; i--) {
        BloodDrop drop = bloodDrops.get(i);
        drop.update();
        drop.display();
        if (drop.isOffScreen()) {
          bloodDrops.remove(i);
        }
      }
    }

    popMatrix();
  }


    void cryTearsOfBlood() {
    cryingTearsOfBlood = true;
    cryStartTime = millis();
  }
}

class BloodDrop {
  float x, y;
  float size;
  float speed;

  BloodDrop(float x, float y, float size, float speed) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
  }

  void update() {
    y += speed; // Apply gravity
  }

  void display() {
    noStroke();
    fill(255, 0, 0); // Red color for tears of blood
    beginShape();
    vertex(x, y);
    bezierVertex(x - size * 2, y - size * 2, x + size * 2, y - size * 2, x, y); // Tear drop shape
    endShape(CLOSE);
  }

  boolean isOffScreen() {
    return y > height; // Check if the drop has fallen off the screen
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
  } else if (message.startsWith("Touch#2 Value: ")) {
    touch2_Message = message;
  }
}

// Function to extract the light value from the message
int extractLightValue(String message) {
  String[] parts = splitTokens(message);
  if (parts.length >= 2) {
    return int(parts[1]);
  } else {
    return 0;
  }
}

// Function to extract the touch value from the message
int extractTouchValue(String message) {
  String[] parts = splitTokens(message);
  if (parts.length >= 2) {
    return int(parts[2]);
  } else {
    return 0;
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
