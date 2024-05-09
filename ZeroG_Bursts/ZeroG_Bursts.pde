//
//Randomly triggers clusters of colourful squares
//
//Immersive artwork Developed by Domme Ewan AKA Cyberspice
//for Soundplay Projects open day in Glasgow.
//


//import themidibus.*;
//import processing.sound.*;
//SoundFile[] file;
//int numsounds = 5;

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

color clusterPallette;

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
  box2d.setGravity(0, 0);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  //boundaries = new ArrayList<Boundary>();

  //file = new SoundFile[numsounds];
  //for (int i = 0; i < numsounds; i++) {
  //  file[i] = new SoundFile(this, (i+1) + ".aif");

  background(0);
}


void draw() {
  
   //filter(BLUR);
  //filter(DILATE);
   //filter(THRESHOLD,8);
  
  background(0);
  
  //  blendMode(MULTIPLY);
  //  fill(250);
  //noStroke();
  //rect(width/2, height/2, width, height);
  //blendMode(BLEND);

  //noStroke();
  //fill(0, 1);
  //rect(width/2, height/2, width, height);

  // We must always step through time!
  box2d.step();

  // When the mouse is clicked, add a new Box object
  //if (random(5) < 0.1) {
  //  shapeColour = color(random(128,255), random(128,255), random(255));
  //  Box p = new Box(random(width), height-60, shapeColour);
  //  boxes.add(p);
  //}

  //if (mousePressed) {
    for (Box b: boxes) {
     b.attract(width/2,height/2);
    }
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

  //fill(0);

  if (random(100)>99.6) {
    float clusterX = random(50, width-50);
    float clusterY = random(50, height-50);
    int clusterAmount = int(random(14));
    int clusterPalletteNum = int(random(8));

    spawnCluster(clusterX, clusterY, clusterAmount, clusterPalletteNum);
  }
  
  
 
    //filter(DILATE);
  //filter(ERODE);
 

}

void spawnCluster(float _clusterX, float _clusterY, int _clusterAmount, int _clusterPalletteNum) {

  
  
  for (int i=0; i< _clusterAmount; i++) {

    switch(_clusterPalletteNum) {
      case 0:
      clusterPallette = color(random(255*0.125*0, 255*0.125*0.3), random(160,240), random(210,255));
      break;
      case 1:
      clusterPallette = color(random(255*0.125*0.25,255*0.125*0.75), random(160,240), random(210,255));
      break;
      case 2:
      clusterPallette = color(random(255*0.125*0.8,255*0.125*1.1), random(160,240), random(210,255));
      break;
      case 3:
      clusterPallette = color(random(255*0.125*2.2,255*0.125*3), random(160,240), random(210,255));
      break;
      case 4:
      clusterPallette = color(random(255*0.125*3.4,255*0.125*4.8), random(160,240), random(210,255));
      break;
      case 5:
      clusterPallette = color(random(255*0.125*4.6,255*0.125*5.8), random(160,240), random(210,255));
      break;
      case 6:
      clusterPallette = color(random(255*0.125*5.5,255*0.125*7.1), random(160,240), random(210,255));
      break;
      case 7:
      clusterPallette = color(random(255*0.125*6.6,255*0.125*7.4), random(160,240), random(210,255));
      break;
      case 8:
      clusterPallette = color(random(255*0.125*7.6,255*0.125*8.4), random(160,240), random(210,255));
      break;
    }


    spawnAtPos(_clusterX + random(-30, 30), _clusterY + random(-30, 30), clusterPallette);
  }
}



void spawnAtPos(float _SpawnPosX, float _SpawnPosY, color _SpawnColour) {

  //shapeColour = color(random(128,255), random(128,255), random(255));
  Box p = new Box(_SpawnPosX, _SpawnPosY, _SpawnColour);
  boxes.add(p);
}
