// Variables for shape, appearance, and movement of blob1 and blob2
let centerX1, centerY1, centerX2, centerY2; // Center coordinates of the two blobs
let radius = 45; // Radius of the blobs
let velocityX1, velocityY1, velocityX2, velocityY2; // Velocities for blob1 and blob2
let nodes = 20; // Number of nodes in the blob shapes
let nodeStartX1 = [],
  nodeStartY1 = [],
  nodeStartX2 = [],
  nodeStartY2 = []; // Arrays to store initial node positions
let nodeX1 = [],
  nodeY1 = [],
  nodeX2 = [],
  nodeY2 = []; // Arrays to store current node positions
let angle1 = [],
  angle2 = []; // Arrays to store angles for node movement
let frequency1 = [],
  frequency2 = []; // Arrays to store frequency of node movement
let organicConstant = 0.5; // Adjusted for smoother motion of blob shapes

// Variables for the trail
let trail1 = []; // Trail for blob1
let trail2 = []; // Trail for blob2
let trailLength = 200; // Maximum length of the trails
let trailThickness = 1; // Thickness of the trail lines
let blobColor1, blobColor2, trailColor1, trailColor2; // Colors for blob1, blob2, and their trails

function setup() {
  createCanvas(windowWidth, windowHeight);

  // Initialize properties for blob1
  centerX1 = random(radius, width - radius);
  centerY1 = random(radius, height - radius);
  velocityX1 = random(1, 3) * 6;
  velocityY1 = random(1, 3) * 6;
  for (let i = 0; i < nodes; i++) {
    nodeStartX1[i] = 0;
    nodeStartY1[i] = 0;
    nodeX1[i] = 0;
    nodeY1[i] = 0;
    angle1[i] = 0;
    frequency1[i] = random(1, 3);
  }
  let randomColor1 = color(random(255), random(255), random(255));
  blobColor1 = randomColor1;
  trailColor1 = randomColor1;

  // Initialize properties for blob2
  centerX2 = random(radius, width - radius);
  centerY2 = random(radius, height - radius);
  velocityX2 = random(1, 3) * 6;
  velocityY2 = random(1, 3) * 6;
  for (let i = 0; i < nodes; i++) {
    nodeStartX2[i] = 0;
    nodeStartY2[i] = 0;
    nodeX2[i] = 0;
    nodeY2[i] = 0;
    angle2[i] = 0;
    frequency2[i] = random(1, 3);
  }
  let randomColor2 = color(random(255), random(255), random(255));
  blobColor2 = randomColor2;
  trailColor2 = randomColor2;

  noStroke();
  frameRate(30);
}

function draw() {
  background(0);

  // Update properties for blob1 and handle collisions
  centerX1 += velocityX1;
  centerY1 += velocityY1;

  // Collision with window edge check for blob1
  if (centerX1 - radius < 0 || centerX1 + radius > width) {
    velocityX1 *= -1;
  }
  if (centerY1 - radius < 0 || centerY1 + radius > height) {
    velocityY1 *= -1;
  }

  // blob1 animation
  for (let i = 0; i < nodes; i++) {
    let angleStep = TWO_PI / nodes;
    let currentAngle = i * angleStep;
    nodeStartX1[i] = centerX1 + cos(currentAngle) * radius;
    nodeStartY1[i] = centerY1 + sin(currentAngle) * radius;
  }

  // blob1 animation
  for (let i = 0; i < nodes; i++) {
    nodeX1[i] = nodeStartX1[i] + sin(radians(angle1[i])) * velocityX1;
    nodeY1[i] = nodeStartY1[i] + sin(radians(angle1[i])) * velocityY1;
    angle1[i] += frequency1[i];
  }

  // Update the trail for blob1
  trail1.push({ x: centerX1, y: centerY1 });

  // Update properties for blob2 and handle collisions
  centerX2 += velocityX2;
  centerY2 += velocityY2;

  // Collision with window edge check for blob2
  if (centerX2 - radius < 0 || centerX2 + radius > width) {
    velocityX2 *= -1;
  }
  if (centerY2 - radius < 0 || centerY2 + radius > height) {
    velocityY2 *= -1;
  }

  // blob2 animation
  for (let i = 0; i < nodes; i++) {
    let angleStep = TWO_PI / nodes;
    let currentAngle = i * angleStep;
    nodeStartX2[i] = centerX2 + cos(currentAngle) * radius;
    nodeStartY2[i] = centerY2 + sin(currentAngle) * radius;
  }

  // blob2 animation
  for (let i = 0; i < nodes; i++) {
    nodeX2[i] = nodeStartX2[i] + sin(radians(angle2[i])) * velocityX2;
    nodeY2[i] = nodeStartY2[i] + sin(radians(angle2[i])) * velocityY2;
    angle2[i] += frequency2[i];
  }

  // Update the trail for blob2
  trail2.push({ x: centerX2, y: centerY2 });

  // Draw blob1
  stroke(blobColor1);
  fill(blobColor1);
  drawBlob(nodeX1, nodeY1);

  // Draw blob2
  stroke(blobColor2);
  fill(blobColor2);
  drawBlob(nodeX2, nodeY2);

  // Draw the trails for both blobs
  drawTrail(trail1, trailColor1);
  drawTrail(trail2, trailColor2);
}

function drawBlob(nodeX, nodeY) {
  curveTightness(organicConstant);
  beginShape();
  for (let i = 0; i < nodes; i++) {
    curveVertex(nodeX[i], nodeY[i]);
  }
  for (let i = 0; i < nodes - 1; i++) {
    curveVertex(nodeX[i], nodeY[i]);
  }
  endShape(CLOSE);
}

function drawTrail(trail, trailColor) {
  if (trail.length > 1) {
    stroke(trailColor);
    strokeWeight(trailThickness);
    noFill();
    beginShape();
    for (let i = 0; i < trail.length; i++) {
      vertex(trail[i].x, trail[i].y);
    }
    endShape();
  }
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);

  // Recalculate blob positions based on the new canvas size
  centerX1 = random(radius, width - radius);
  centerY1 = random(radius, height - radius);
  centerX2 = random(radius, width - radius);
  centerY2 = random(radius, height - radius);

  // Adjust blob velocities based on canvas size
  let speedFactor = min(width, height) / min(windowWidth, windowHeight);
  velocityX1 = random(1, 3) * 6 * speedFactor;
  velocityY1 = random(1, 3) * 6 * speedFactor;
  velocityX2 = random(1, 3) * 6 * speedFactor;
  velocityY2 = random(1, 3) * 6 * speedFactor;

  // Clear the trail arrays
  trail1 = [];
  trail2 = [];
}
