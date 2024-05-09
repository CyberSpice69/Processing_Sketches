//
//Use Keyboard keys A - L to launch musical squares
//
//Concept for interactive artwork either on touchscreen,
//with midi, or projected using drum pads
//
//Developed by Domme Ewan AKA Cyberspice
//thanks to support from Soundplay Projects in Glasgow.
//

import themidibus.*;
import processing.sound.*;
SoundFile[] file;
int numsounds = 5;

// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of falling rectangles

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
//ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

//int spawnID = 0;
color shapeColour;
//int shapeColourID = 0;
//float xSpawnPos = 0;
//float SpawnPosX = 0;




//boolean spawnAllowed = false;

void setup() {
  //size(1280,720);
  fullScreen();
  smooth();
  colorMode(HSB);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  //boundaries = new ArrayList<Boundary>();

  file = new SoundFile[numsounds];
  for (int i = 0; i < numsounds; i++) {
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }
}

void draw() {
  background(0);

  // We must always step through time!
  box2d.step();

  // When the mouse is clicked, add a new Box object
  //if (random(5) < 0.1) {
  //  shapeColour = color(random(128,255), random(128,255), random(255));
  //  Box p = new Box(random(width), height-60, shapeColour);
  //  boxes.add(p);
  //}

  //if (mousePressed) {
  //  for (Box b: boxes) {
  //   b.attract(mouseX,mouseY);
  //  }
  //}

  // Display all the boundaries
  //for (Boundary wall: boundaries) {
  //  wall.display();
  //}

  // Display all the boxes
  for (Box b : boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }

  fill(0);
  text("Click mouse to attract boxes", 20, 20);
}

void keyPressed() {
  //spawnAllowed = false;
  switch(key) {
  case 'a':
    println("a");
    spawnAtPos(width * 0.1 * 1, color(random(255*0.125*0,255*0.125*0.3), random(160,240), random(210,255)));
     file[0].play(random(0.35,0.65), 1.0);
    //xSpawnPos = width * 0.1 * 1;
    //spawnAllowed = true;
    break;
  case 's':
    println("s");
    spawnAtPos(width * 0.1 * 2, color(random(255*0.125*0.25,255*0.125*0.75), random(160,240), random(210,255)));
     file[1].play(random(0.35,0.65), 1.0);
    //xSpawnPos = width * 0.1 * 2;
    //spawnAllowed = true;
    break;
  case 'd':
    println("d");
    spawnAtPos(width * 0.1 * 3, color(random(255*0.125*0.8,255*0.125*1.1), random(160,240), random(210,255)));
     file[2].play(random(0.35,0.65), 1.0);
    //xSpawnPos = width * 0.1 * 3;
    //spawnAllowed = true;
    break;
  case 'f':
    println("f");
    spawnAtPos(width * 0.1 * 4, color(random(255*0.125*2.2,255*0.125*3), random(160,240), random(210,255)));
     file[3].play(random(0.35,0.65), 1.0);
    //xSpawnPos = width * 0.1 * 4;
    //spawnAllowed = true;
    break;
  case 'g':
    println("g");
    spawnAtPos(width * 0.1 * 5, color(random(255*0.125*3.4,255*0.125*4.8), random(160,240), random(210,255)));
     file[4].play(random(0.35,0.65), 1.0);
    //xSpawnPos = width * 0.1 * 5;
    //spawnAllowed = true;
    break;
  case 'h':
    println("h");
    spawnAtPos(width * 0.1 * 6, color(random(255*0.125*4.6,255*0.125*5.8), random(160,240), random(210,255)));
     file[0].play(random(0.85,1.15), 1.0);
    //xSpawnPos = width * 0.1 * 6;
    //spawnAllowed = true;
    break;
  case 'j':
    println("j");
    spawnAtPos(width * 0.1 * 7, color(random(255*0.125*5.5,255*0.125*7.1), random(160,240), random(210,255)));
     file[1].play(random(0.85,1.15), 1.0);
    //xSpawnPos = width * 0.1 * 7;
    //spawnAllowed = true;
    break;
  case 'k':
    println("k");
    spawnAtPos(width * 0.1 * 8, color(random(255*0.125*6.6,255*0.125*7.4), random(160,240), random(210,255)));
     file[2].play(random(0.85,1.15), 1.0);
    //xSpawnPos = width * 0.1 * 8;
    //spawnAllowed = true;
    break;
  case 'l':
    println("l");
    spawnAtPos(width * 0.1 * 9, color(random(255*0.125*7.6,255*0.125*8.4), random(160,240), random(210,255)));
     file[3].play(random(0.85,1.15), 1.0);
    //xSpawnPos = width * 0.1 * 9;
    //spawnAllowed = true;
    break;
  }
  //if (spawnAllowed){
  //spawnID = frameCount;
  //shapeColourSeed = randomSeed(spawnID);
  //shapeColour = color(random(128,255), random(128,255), random(255));
  //Box p = new Box(xSpawnPos, height-10, shapeColourID);
  //boxes.add(p);
  //}
}

void spawnAtPos(float _SpawnPosX, color _SpawnColour) {

  //shapeColour = color(random(128,255), random(128,255), random(255));
  Box p = new Box(_SpawnPosX, height-1, _SpawnColour);
  boxes.add(p);
}
