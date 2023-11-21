import processing.serial.*;

int splatterSize = 30; // Size of each splatter
Serial myPort;  // Create an object from Serial class
String val;
int motor1Position;  // Initialize motor 1 position
String lightVal;
int int_lightval;
PImage backgroundImage;  // Background image

boolean drawSplatterFlag = true; // Flag to control whether to draw a splatter

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100); // Use HSB color mode
  
  // replace with the actual file name)
  backgroundImage = loadImage("canvas.jpg");
  backgroundImage.resize(width, height);
  
  // Set the background image
  image(backgroundImage, 0, 0);

  // Replace "COM3" with the esp32 port
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  while (myPort.available() > 0) {  // If data is available,
    String inBuffer = myPort.readStringUntil('\n');
    if (inBuffer != null) {
      String[] data = split(inBuffer, ',');
      print(data);
      if (data.length == 3) {
        motor1Position = int(data[1]);
        lightVal = (data[2].trim());
        println("lightval:");
        int_lightval = int(lightVal);
        println(int_lightval);
        drawSplatterFlag = true;
      } else if (data.length == 2) {
        clearCanvas();
        motor1Position = int(random(width));
        int_lightval = int(random(0, 255));
        drawSplatterFlag = false;
      } else {
        motor1Position = int(random(width));
        int_lightval = int(random(0, 255));
        drawSplatterFlag = false;
      }

      float splatterX = map(motor1Position, -2048, 2048, 0, width);
      float splatterY = generateSplatterY(); 

      if (drawSplatterFlag) {
        drawSplatter(splatterX, splatterY, splatterSize, int_lightval);
        drawSplatterFlag = false;
      }
    }
  }
}

float generateSplatterY() {
  // Perlin noise for splatterY position
  float noiseVal = noise(millis() * 0.01); // scale
  return noiseVal * height;
}

void drawSplatter(float x, float y, float size, int light) {
  // light value to hue range
  float mappedHue = map(light, 0, 4095, 200, 0); // hue values

  // HSB values with adjusted brightness
  fill(mappedHue, 100, map(light, 0, 4095, 50, 100), 150);
  
  // no outline
  noStroke();

  // Draw a group of random splats of paint on the clap position
  int numSplatGroups = (int) random(3, 8);
  for (int i = 0; i < numSplatGroups; i++) {
    drawSplatGroup(x, y, size);
  }
}

void drawSplatGroup(float x, float y, float size) {
  // Draw a group of irregular shapes 
  int numSplats = (int) random(3, 8);
  float groupSpacing = size * 2.5; // spacing between splat groups
  for (int i = 0; i < numSplats; i++) {
    // Generate random sizes for each splat in the group
    float randomSize = random(size * 0.3, size * 0.7);
    drawSplat(x + random(-groupSpacing, groupSpacing), y + random(-groupSpacing, groupSpacing), randomSize);
  }
}

void drawSplat(float x, float y, float size) {
  // Custom blob-like shape for the splatter
  beginShape();
  int numPoints = 10; // # of points, can adjust
  for (int i = 0; i < numPoints; i++) {
    float angle = map(i, 0, numPoints, 0, TWO_PI);
    float radius = size * random(0.5, 1.5);
    float sx = x + cos(angle) * radius;
    float sy = y + sin(angle) * radius;
    curveVertex(sx, sy);
  }
  endShape(CLOSE);
}

void clearCanvas() {
  image(backgroundImage, 0, 0);
}
