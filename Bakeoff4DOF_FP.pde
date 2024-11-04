import java.util.ArrayList;
import java.util.Collections;

// Variables
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

// Logo position and properties
float logoX = 500;
float logoY = 500;
float logoZ = 50f;
float logoRotation = 0;

private class Destination {
    float x = 0;
    float y = 0;
    float rotation = 0;
    float z = 0;
}

ArrayList<Destination> destinations = new ArrayList<Destination>();

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
        println("created target with " + d.x + "," + d.y + "," + d.rotation + "," + d.z);
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

    // Draw destination squares
    for (int i = trialIndex; i < trialCount; i++) {
        pushMatrix();
        Destination d = destinations.get(i);
        translate(d.x, d.y);
        rotate(radians(d.rotation));
        noFill();
        strokeWeight(3f);
        if (trialIndex == i)
            stroke(255, 0, 0, 192);
        else
            stroke(128, 128, 128, 128);
        rect(0, 0, d.z, d.z);
        popMatrix();
    }

    // Draw logo square
    pushMatrix();
    translate(logoX, logoY);
    rotate(radians(logoRotation));
    noStroke();
    fill(60, 60, 192, 192);
    rect(0, 0, logoZ, logoZ);
    popMatrix();

    // Draw mirrored box control
    drawMirroredBox();
    drawControls();

    text("Trial " + (trialIndex + 1) + " of " + trialCount, width / 2, inchToPix(.8f));
}

void drawMirroredBox() {
    // Define mirrored box properties
    float mirroredWidth = width * 0.3f;
    float mirroredHeight = height * 0.1f;
    float mirroredX = width / 2 - mirroredWidth / 2;
    float mirroredY = height - mirroredHeight - inchToPix(0.5f);

    // Draw the mirrored box
    fill(80);
    stroke(255);
    rect(mirroredX + mirroredWidth / 2, mirroredY + mirroredHeight / 2, mirroredWidth, mirroredHeight);

    // Map logo position to mirrored box position
    float logoPosXInMirror = map(logoX, 0, width, mirroredX, mirroredX + mirroredWidth);
    float logoPosYInMirror = map(logoY, 0, height, mirroredY, mirroredY + mirroredHeight);

    // Draw the logo inside mirrored box
    fill(60, 60, 192, 192);
    rect(logoPosXInMirror, logoPosYInMirror, 10, 10); // Small square representing the logo position
}

void drawControls() {
    // Control buttons at the bottom-right corner
    float controlY = height - inchToPix(0.8f); // Y position for the buttons
    float buttonSize = inchToPix(0.6f); // Size of each button
    float controlX = width - inchToPix(2.5f); // Starting X position for the first button

    // Draw and handle "+" button for increasing size
    fill(200);
    rect(controlX, controlY, buttonSize, buttonSize);
    fill(0);
    text("+", controlX, controlY + buttonSize / 4);
    if (mousePressed && mouseX > controlX - buttonSize / 2 && mouseX < controlX + buttonSize / 2 &&
        mouseY > controlY - buttonSize / 2 && mouseY < controlY + buttonSize / 2) {
        logoZ = constrain(logoZ + inchToPix(0.005f), 0.01, inchToPix(4f));
    }

    // Draw and handle "-" button for decreasing size
    fill(200);
    rect(controlX + buttonSize * 1.2f, controlY, buttonSize, buttonSize);
    fill(0);
    text("-", controlX + buttonSize * 1.2f, controlY + buttonSize / 4);
    if (mousePressed && mouseX > controlX + buttonSize * 1.2f - buttonSize / 2 &&
        mouseX < controlX + buttonSize * 1.2f + buttonSize / 2 &&
        mouseY > controlY - buttonSize / 2 && mouseY < controlY + buttonSize / 2) {
        logoZ = constrain(logoZ - inchToPix(0.005f), 0.01, inchToPix(4f));
    }

    // Draw and handle "CW" button for clockwise rotation
    fill(200);
    rect(controlX + buttonSize * 2.4f, controlY, buttonSize, buttonSize);
    fill(0);
    text("CW", controlX + buttonSize * 2.4f, controlY + buttonSize / 4);
    if (mousePressed && mouseX > controlX + buttonSize * 2.4f - buttonSize / 2 &&
        mouseX < controlX + buttonSize * 2.4f + buttonSize / 2 &&
        mouseY > controlY - buttonSize / 2 && mouseY < controlY + buttonSize / 2) {
        logoRotation+=0.5;
    }

    // Draw and handle "CCW" button for counterclockwise rotation
    fill(200);
    rect(controlX + buttonSize * 3.6f, controlY, buttonSize, buttonSize);
    fill(0);
    text("CCW", controlX + buttonSize * 3.6f, controlY + buttonSize / 4);
    if (mousePressed && mouseX > controlX + buttonSize * 3.6f - buttonSize / 2 &&
        mouseX < controlX + buttonSize * 3.6f + buttonSize / 2 &&
        mouseY > controlY - buttonSize / 2 && mouseY < controlY + buttonSize / 2) {
        logoRotation-=0.5;
    }
}



void mousePressed() {
    if (startTime == 0) {
        startTime = millis();
        println("time started!");
    }
}

void mouseDragged() {
    // Get mirrored box properties
    float mirroredWidth = width * 0.3f;
    float mirroredHeight = height * 0.1f;
    float mirroredX = width / 2 - mirroredWidth / 2;
    float mirroredY = height - mirroredHeight - inchToPix(0.5f);

    // Check if the drag is within the mirrored box
    if (mouseX > mirroredX && mouseX < mirroredX + mirroredWidth && mouseY > mirroredY && mouseY < mirroredY + mirroredHeight) {
        // Map mouse position in mirrored box to logo position on the main screen
        logoX = map(mouseX, mirroredX, mirroredX + mirroredWidth, 0, width);
        logoY = map(mouseY, mirroredY, mirroredY + mirroredHeight, 0, height);
    }
}

void mouseReleased()
{
  //check to see if user clicked middle of screen within 3 inches, which this code uses as a submit button
  if (dist(width/2, height/2, mouseX, mouseY)<inchToPix(3f))
  {
    if (userDone==false && !checkForSuccess())
      errorCount++;

    trialIndex++; //and move on to next trial

    if (trialIndex==trialCount && userDone==false)
    {
      userDone = true;
      finishTime = millis();
    }
  }
}

// Check if user has completed the trial successfully
public boolean checkForSuccess() {
    Destination d = destinations.get(trialIndex);
    boolean closeDist = dist(d.x, d.y, logoX, logoY) < inchToPix(.05f);
    boolean closeRotation = calculateDifferenceBetweenAngles(d.rotation, logoRotation) <= 5;
    boolean closeZ = abs(d.z - logoZ) < inchToPix(.1f);

    println("Close Enough Distance: " + closeDist + " (logo X/Y = " + d.x + "/" + d.y + ", destination X/Y = " + logoX + "/" + logoY + ")");
    println("Close Enough Rotation: " + closeRotation + " (rot dist=" + calculateDifferenceBetweenAngles(d.rotation, logoRotation) + ")");
    println("Close Enough Z: " + closeZ + " (logo Z = " + d.z + ", destination Z = " + logoZ + ")");
    println("Close enough all: " + (closeDist && closeRotation && closeZ));

    return closeDist && closeRotation && closeZ;
}

double calculateDifferenceBetweenAngles(float a1, float a2) {
    double diff = abs(a1 - a2);
    diff %= 90;
    if (diff > 45)
        return 90 - diff;
    else
        return diff;
}

float inchToPix(float inch) {
    return inch * screenPPI;
}
