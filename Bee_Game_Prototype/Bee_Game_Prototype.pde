import processing.sound.*;
SoundFile BGsoundLoop, flowerSound1, hiveSound1;


int numberOfFlowers = 9;  //How many flowers in the Array
int numberOfBushes = 6; 
//int FlowerClassCount;
FlowerClass[] flowerArray;  //Creating an array of the flower class(2nd tab)
BushClass[] bushArray;  //Creating an array of the flower class(2nd tab)
HiveClass Hive;

int beeNectar = 0;  //How many flowers activated
int beeNectarMax = 20;  //How many flowers activated
int hiveStartNectar = 0;
int hiveNectarMax = 100;

boolean gameIntro = true;
boolean gameRunning = false;
boolean gameOver = false;

int gameBeginTime;
int gameDuration = 30;
//int time = 30;
int gameTimer = 30;
//int tickLength = 600;
//boolean isGameTick = false;
//int gameTickCount = 0;

PImage bee;
PImage flower1, flower2, flower3;  //this could become an array

float beeX = 1280/2;
float beeY = 720/2;//Global variables (accessible anywhere) for bee Position
float beeS = 60;  //Bee Size
float beeEasing = 0.03;

float flowerSize = 120;  //Flower Size
float bushSize = 80;  //Flower Size


void setup() {
  size(1280, 720);  //16:9 aspect ratio but not too big to fill the screen
  smooth(16);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(30);

  loadImages();  //Calling our custom function (scroll down to find it) to load images in
  loadSounds();

  initialiseFlowerArray();  //Another custom function (scroll)
  initialiseBushArray(); 
  // This 'creates' each flower object in an array
  initialiseHive();
  //noCursor();
}


void draw() {

  if (gameIntro == true) {
    GameIntro();
  }

  if (gameRunning == true) {
    drawBG();

    flowerUpdate(); 
    bushUpdate(); 
    Hive.update();
    beeUpdate();   

    beeDisplay();    

    gameTimerUpdate();
    drawGUI();
  }

  if (gameOver == true) {
    GameOver();
  }
}

void gameTimerUpdate() {

  if (gameTimer > 0) {
    gameTimer = gameDuration - (millis() - gameBeginTime)/1000;
  } else {
    gameRunning = false;
    gameOver = true;
  }
}

//void awardNectar() {    //When bee has been on flower long enough and leaves- 1 Point is added

//  if (beeNectar < beeNectarMax) {
//    beeNectar+= 1;
//    println("Nectar Collected! Nectar:" + beeNectar);
//  }
//}

//void deductNectar() {

//  if (frameCount%60==0) {
//    beeNectar--;
//  }

//  if (beeNectar<=0) {
//    beeNectar=0;
//  }
//}

void beeUpdate() {    //Currently just the Position Control

  float targetX = mouseX;
  float dx = targetX - beeX;
  beeX += dx * beeEasing;

  float targetY = mouseY;
  float dy = targetY - beeY;
  beeY += dy * beeEasing;

  //beeX = mouseX;
  //beeY = mouseY;

  //deductNectar();
}


void beeDisplay() {    //Transformations and drawing the Bee image
  tint(255, 255);

  pushMatrix();    //Open transformation
  translate(beeX, beeY);    //move (0,0) point to where bee shold be drawn
  //rotation will go here
  image(bee, 0, 0, beeS, beeS);    //Draw bee at (0,0)
  popMatrix();    //Close transformation
}

void loadImages() {    //We have put this here to keep the code clean and chunked up

  bee = loadImage("bee.png");
  flower1 = loadImage("flower1.png");
  flower2 = loadImage("flower2.png");
  flower3 = loadImage("flower3.png");
  imageMode(CENTER);    //Centre drawing more for images to properly rotate around 0,0
}

void loadSounds() {

  // Load a soundfile from the /data folder of the sketch and play it back
  BGsoundLoop = new SoundFile(this, "BGsoundLoop.mp3");
  BGsoundLoop.loop();

  flowerSound1 = new SoundFile(this, "flowerSound1.wav");
  //flowerSound1.loop();
  hiveSound1 = new SoundFile(this, "hiveSound1.wav");
}


void initialiseFlowerArray() {    //This is where we 'spawn' each flower in setup()

  flowerArray = new FlowerClass[numberOfFlowers] ;    //Creating the Array

  //int index = 0;
  for (int i = 0; i < numberOfFlowers; i++) {    //For every flower we want...
    // ..Add a new flower // FlowerClass(X position, Y position, Scale, Index) // CHECK OTHER TAB
    flowerArray[i] = new FlowerClass(random(flowerSize/2, 1280-flowerSize/2), random(flowerSize/2, 720-flowerSize/2), flowerSize, i, int(random(2, 8)));
  }
}

void initialiseBushArray() {    //This is where we 'spawn' each flower in setup()

  bushArray = new BushClass[numberOfBushes] ;    //Creating the Array

  //int index = 0;
  for (int i = 0; i < numberOfBushes; i++) {    //For every flower we want...
    // ..Add a new flower // FlowerClass(X position, Y position, Scale, Index) // CHECK OTHER TAB
    bushArray[i] = new BushClass(random(bushSize/2, 1280-bushSize/2), random(bushSize/2, 720-bushSize/2), bushSize, i);
  }
}

void initialiseHive() {    

  Hive = new HiveClass(width/2, height/2, hiveStartNectar) ;
}


void flowerUpdate() {    //Run the Update Function in the Flower Class

  //int index = 0;
  for (int i = 0; i < numberOfFlowers; i++) {
    flowerArray[i].update();
  }
}

void bushUpdate() {    //Run the Update Function in the Flower Class

  //int index = 0;
  for (int i = 0; i < numberOfBushes; i++) {
    bushArray[i].update();
  }
}


void keyPressed() {

  setup();    //Lazy reset
}

void drawBG() {

  //background(199, 234, 252);
  background(118, 203, 95);
  //fill(75,165,96);
  //noStroke();
  //rect(0,height-45,width,height-45);
}

void drawGUI() {

  //fill(239,230,240);
  //rect(width-60,200,30,400,15);
  //stroke(239,230,240);

  fill(0, 0, 0, 100);


  // Bee Nectar Bar Left
  strokeWeight(40);
  stroke(0, 0, 0, 50);
  line(60, height-200, 60, 200);

  strokeWeight(37);
  stroke(0, 0, 0, 50);
  line(60, height-200, 60, 200);

  strokeWeight(40);
  stroke(77, 70, 14, 200);
  line(60, height-200, 60, height-200-map(beeNectar, 0, beeNectarMax, 0, height-400));

  strokeWeight(37);
  stroke(255, 231, 46);
  line(60, height-200, 60, height-200-map(beeNectar, 0, beeNectarMax, 0, height-400));

  text(beeNectar, 60, height-203-map(beeNectar, 0, beeNectarMax, 0, height-400));
  text("Bee Nectar", 60, height-140, 100, 150);

  // Hive Nectar Bar Right
  strokeWeight(40);
  stroke(0, 0, 0, 50);
  line(width-60, height-200, width-60, 200);

  strokeWeight(37);
  stroke(0, 0, 0, 50);
  line(width-60, height-200, width-60, 200);

  strokeWeight(40);
  stroke(77, 70, 14, 200);
  line(width-60, height-200, width-60, height-200-map(Hive.hiveNectar, 0, hiveNectarMax, 0, height-400));

  strokeWeight(37);
  stroke(255, 231, 46);
  line(width-60, height-200, width-60, height-200-map(Hive.hiveNectar, 0, hiveNectarMax, 0, height-400));

  textAlign(CENTER, CENTER);
  text(Hive.hiveNectar, width-60, height-203-map(Hive.hiveNectar, 0, hiveNectarMax, 0, height-400));
  text("Honey Points", width-60, height-140, 100, 150);

  // Game Timer
  noStroke();
  fill(255, 231, 46);
  ellipse(60, 60, 60, 60);

  textAlign(CENTER, CENTER);
  fill(0, 0, 0, 200);
  textSize(30);
  text(gameTimer, 60, 60);
  noFill();
  stroke(0, 0, 0, 100);
  strokeWeight(3);
  arc(60, 60, 60, 60, -HALF_PI-radians(gameTimer*12), -HALF_PI);
}

void depositNectar() {
}

void getFlowerNectar() {
}


void GameIntro() {

  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Bees are awesome", width/2, height*0.333);

  int startButtonX = width/2;
  int startButtonY = int(height*0.666);
  int startButtonW = 200;
  int startButtonH = 80;

  fill(255, 231, 46);
  rect(startButtonX, startButtonY, startButtonW, startButtonH);
  fill(0);
  text("START GAME", startButtonX, startButtonY);

  if (mouseX > startButtonX - startButtonW * 0.5 && mouseX < startButtonX + startButtonW * 0.5 && mouseY > startButtonY - startButtonH * 0.5 && mouseY < startButtonY + startButtonH * 0.5) {
    startButtonW = 220;
    startButtonH = 100;

    if (mousePressed == true) {
      gameIntro = false;
      gameRunning = true;

      setup();
      gameBeginTime = millis();
      gameTimer = 30;
      beeNectar = 0;
      Hive.hiveNectar = 0;
    }
  }
}

void GameOver() {

  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  text("GAME OVER!", width/2, height*0.333);

  int replayButtonX = width/2;
  int replayButtonY = int(height*0.666);
  int replayButtonW = 200;
  int replayButtonH = 80;

  fill(255, 231, 46);
  rect(replayButtonX, replayButtonY, replayButtonW, replayButtonH);
  fill(0);
  text("PLAY AGAIN", replayButtonX, replayButtonY);

  if (mouseX > replayButtonX - replayButtonW * 0.5 && mouseX < replayButtonX + replayButtonW * 0.5 && mouseY > replayButtonY - replayButtonH * 0.5 && mouseY < replayButtonY + replayButtonH * 0.5) {
    replayButtonW = 220;
    replayButtonH = 100;

    if (mousePressed == true) {
      gameOver = false;
      gameIntro = true;
    }
  }
}


void playFlowerSound() {

  flowerSound1.play();
}

void playHiveSound() {

  if (Hive.touching != Hive.prevTouching && beeNectar > 0) {
    hiveSound1.play();
  }
}
