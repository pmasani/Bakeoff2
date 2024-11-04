import java.util.ArrayList;
import java.util.Collections;

int index = 0;
float border = 0;
int trialCount = 12;
int trialIndex = 0;
int errorCount = 0;
float errorPenalty = 0.5f;
int startTime = 0;
int finishTime = 0;
boolean userDone = false;
final int screenPPI = 72;

float logoX = 500;
float logoY = 500;
float logoZ = 50f;
float logoRotation = 0;
int mode = 0; // 0 = Translation, 1 = Rotation, 2 = Scaling

int lastClickTime = 0;
boolean isDragging = false;
int holdStartTime = 0;
final int holdDuration = 500; // Duration in milliseconds for hold detection
float initialMouseX, initialMouseY;

ArrayList<Destination> destinations = new ArrayList<Destination>();

private class Destination {
  float x = 0;
  float y = 0;
  float rotation = 0;
  float z = 0;
}

void setup() {
  size(1000, 800);
  rectMode(CENTER);
  textFont(createFont("Arial", inchToPix(.3f)));
  textAlign(CENTER);
  border = inchToPix(2f);

  for (int i = 0; i < trialCount; i++) {
    Destination d = new Destination();
    d.x = random(border, width - border);
    d.y = random(border, height - border);
    d.rotation = random(0, 360);
    int j = (int)random(20);
    d.z = ((j % 12) + 1) * inchToPix(.25f);
    destinations.add(d);
  }

  Collections.shuffle(destinations);
}

void draw() {
  background(40);
  fill(200);
  noStroke();

  if (userDone) {
    text("User completed " + trialCount + " trials", width / 2, inchToPix(.4f));
    text("User had " + errorCount + " error(s)", width / 2, inchToPix(.4f) * 2);
    text("User took " + (finishTime - startTime) / 1000f / trialCount + " sec per destination", width / 2, inchToPix(.4f) * 3);
    text("User took " + ((finishTime - startTime) / 1000f / trialCount + (errorCount * errorPenalty)) + " sec per destination inc. penalty", width / 2, inchToPix(.4f) * 4);
    return;
  }

  String modeText = (mode == 0) ? "Mode: Translation" : (mode == 1) ? "Mode: Rotation" : "Mode: Scaling";
  fill(255);
  text(modeText, width / 2, inchToPix(.4f));

  // Draw destination squares
  for (int i = trialIndex; i < trialCount; i++) {
    pushMatrix();
    Destination d = destinations.get(i);
    translate(d.x, d.y);
    rotate(radians(d.rotation));
    noFill();
    strokeWeight(3f);
    if (trialIndex == i) stroke(255, 0, 0, 192);
    else stroke(128, 128, 128, 128);
    rect(0, 0, d.z, d.z);
    popMatrix();
  }

  // Draw logo square
  pushMatrix();
  translate(logoX, logoY);
  rotate(radians(logoRotation));
  noStroke();
  fill(200); // Default fill color
  rect(0, 0, logoZ, logoZ);
  popMatrix();

  text("Trial " + (trialIndex + 1) + " of " + trialCount, width / 2, inchToPix(.8f));
}

void mousePressed() {
  int currentTime = millis();
  if (startTime == 0) {
    startTime = currentTime;
  }

  if (currentTime - lastClickTime < 300) {
    mode = 2; // Double click detected, switch to Scaling mode
  } else {
    holdStartTime = currentTime;
  }

  initialMouseX = mouseX;
  initialMouseY = mouseY;
  isDragging = true;
  lastClickTime = currentTime;
}

void mouseReleased() {
  isDragging = false;

  if (millis() - holdStartTime >= holdDuration) {
    mode = 1; // Hold detected, switch to Rotation mode
  } else if (mode != 2) {
    mode = 0; // Default to Translation mode if not Scaling
  }

  if (dist(width / 2, height / 2, mouseX, mouseY) < inchToPix(3f)) {
    if (!userDone && !checkForSuccess()) {
      errorCount++;
    }
    trialIndex++;
    if (trialIndex == trialCount && !userDone) {
      userDone = true;
      finishTime = millis();
    }
  }
}

void mouseDragged() {
  if (isDragging) {
    switch (mode) {
      case 0: // Translation
        logoX += mouseX - pmouseX;
        logoY += mouseY - pmouseY;
        break;
      case 1: // Rotation
        float dx = mouseX - logoX;
        float dy = mouseY - logoY;
        float angle = atan2(dy, dx);
        logoRotation = degrees(angle);
        break;
      case 2: // Scaling
        logoZ += (mouseY - pmouseY) * 0.1;
        logoZ = constrain(logoZ, inchToPix(.25f), inchToPix(4f));
        break;
    }
  }
}

public boolean checkForSuccess() {
  Destination d = destinations.get(trialIndex);
  boolean closeDist = dist(d.x, d.y, logoX, logoY) < inchToPix(.05f);
  boolean closeRotation = calculateDifferenceBetweenAngles(d.rotation, logoRotation) <= 5;
  boolean closeZ = abs(d.z - logoZ) < inchToPix(.1f);

  return closeDist && closeRotation && closeZ;
}

double calculateDifferenceBetweenAngles(float a1, float a2) {
  double diff = abs(a1 - a2) % 90;
  return (diff > 45) ? 90 - diff : diff;
}

float inchToPix(float inch) {
  return inch * screenPPI;
}
