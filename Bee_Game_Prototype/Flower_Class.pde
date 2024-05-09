//Classes aren't as scary as they seem!
//It's like making your own object
//So like when we ask for rect(x,y,w,h)
//instead here we have made flower(x,y,s,i)
//that can be asked to be made in the code after we say what it is and how it can respond.

class FlowerClass {   //THE CLASS

  //Declare variables
  float flowerX, flowerY, flowerS, flowerW, flowerH;
  int flowerIndex, flowerType;
  int flowerNectar;
  long counterStart, counterEnd;    //Timers can become big numbers specially if installation is running 24/7. could fix with maths
  boolean touching = false;
  boolean prevTouching = false;
  boolean flowerActivated = false;
  boolean flowerPaired = false;

  //The class 'constructor'. This is where we can pass data in from outside.
  FlowerClass (float _x, float _y, float _s, int _i, int _n) {  //Temporary variables

    //Then we assign the permanent variables to the temp ones
    flowerX = _x; 
    flowerY = _y; 
    flowerS = _s;
    flowerW = flowerS;  //This is here in case we need it
    flowerH = flowerS;  //in future use square images
    flowerIndex = _i;  //Each flower gets a unique index so we know which is which
    //println("flowerIndex = " + flowerIndex);
    flowerType = round((flowerIndex+1)*0.33);    //Flowers are in pairs of type. This numbers each type of flower ie: 1,1,2,2,3,3
    //println("flowerType = " + flowerType);
    flowerNectar = _n;
  } 

  void update() {

    checkTouchingBee();    //Call this function (scroll down)
    giveBeeNectar();
    if (flowerNectar <= 0) {
      //flowerActivated = true;
      activateFlower();
    }

    if (touching == true) {  //If the bee is touching this flower
      flowerW = flowerS * 1.2;    //Make the flower bigger to know we're interacting with it
      flowerH = flowerW*0.8;
    } else {
      flowerW = flowerS;    //Otherwise keep it at normal size
      flowerH = flowerW*0.8;
    } 

    if (flowerActivated==true) {
      flowerW = flowerS*0.8;    //If it's been activated
      flowerH = flowerW*0.8;    //Scale down
    }
    display();    //    VVV    //
  }

  void display() {    //Draw the type of flower in a specific place

    if (flowerActivated==true) {    //If this flower has been visited (activated), or in a pair...
      tint(255, 80);    //Make it transparent
      if (flowerPaired != true) {    //If the flower is activated but not in a pair yet...
        //drawLineToBee();    //Draw a line from the flower to the Bee
      } else {    //If the flower is paired...
        //drawPairLine();    //Draw a line between them. Not the bee
      }
    } else {
      tint(255, 255);    //If the flower is not activated, make it 100% opacity
    }

    pushMatrix();    //Open transformations
    translate(flowerX, flowerY);    //Birth position
    rotate(sin(radians(frameCount*0.01)*30));    //Sway back and forth
    //translate(wiggleAmp/2-wiggleAmp*noise(radians(0.25*frameCount+2222)), wiggleAmp/2-wiggleAmp*noise(0.25*radians(frameCount+777)));
    //translate(wiggleAmp2/2-wiggleAmp2*noise(radians(0.9*frameCount+2222)), wiggleAmp2/2-wiggleAmp2*noise(2*radians(frameCount+777)));


    switch(flowerIndex) {    //Which breed of flower will it be?
    case 0:
      image(flower1, 0, 0, flowerW, flowerH);
      break;
    case 1:
      image(flower1, 0, 0, flowerW, flowerH);
      break;
    case 2:
      image(flower1, 0, 0, flowerW, flowerH);
      break;
    case 3:
      image(flower2, 0, 0, flowerW, flowerH);
      break;
    case 4:
      image(flower2, 0, 0, flowerW, flowerH);
      break;
    case 5:
      image(flower2, 0, 0, flowerW, flowerH);
      break;
    case 6:
      image(flower3, 0, 0, flowerW, flowerH);
      break;
    case 7:
      image(flower3, 0, 0, flowerW, flowerH);
      break;
    case 8:
      image(flower3, 0, 0, flowerW, flowerH);
      break;
    }
    popMatrix();
  }


  void checkTouchingBee() {    //Is the bee touching this flower?

    if (dist(beeX, beeY, flowerX, flowerY) < (beeS + flowerW)*0.3) {   //Are they close enough?
      touching = true;    //yes
      //triggerTimerStart();    //Call timer start function
      //suckNectar();
    } else {
      touching = false;    //no
      //triggerTimerEnd();    //Dont play the timer
    }
    prevTouching = touching;    //Update the previous state to the current state
    //This turns a switch into a button  //There is better ways to do this though!?
  }

  //void suckNectar() {

  //  if (touching==true && flowerActivated==false && flowerNectar > 0 && frameCount%10==0) {
  //    flowerNectar--;

  //    awardNectar();  //CALL AWARD POINT IN MAIN CODE -- This isn't neccecary. We could update the points here. The points mean nothing anyway!

  //    if (flowerNectar==0) {    
  //      activateFlower();
  //    }
  //  }
  //}


  //void triggerTimerStart() {
  //  if (touching==true && touching != prevTouching && flowerActivated==false) {    //Double check touching, And is this a new event?
  //    counterStart = millis();    //If this is a new event, note the time it began
  //    println("counterStart:" + counterStart);


  //  }
  //}


  //void triggerTimerEnd() {    //We are not touching
  //  if (touching==false && touching != prevTouching) {    //We are not touching but we just were
  //    counterEnd = millis();    //What time did we stop touching?
  //    println("counterEnd:" + counterEnd);

  //    if (counterEnd - counterStart > 2750) {    //Were we touching long enough?

  //      activateFlower();    //The bee has successfully visited the Flower, Activating it.
  //      //println("A point was added");
  //    }
  //  }
  //}

  //void resetActivation() {
  //  println("Resetting Flower!");
  //  flowerActivated = false;
  //  flowerPaired = false;
  //}

  void activateFlower() {

    if ( flowerActivated == false ) {
      println("Activating Flower!");
      flowerActivated = true;
      //checkOtherActivatedFlowers();    //What other flowers are already activated?
      playFlowerSound();
    }
  }

  //void checkOtherActivatedFlowers() {    //Check what other flowers are already activated

  //  for (int i = 0; i < numberOfFlowers; i++) {    //For each Flower in the Array
  //    //is it Activated + is it not the same flower we've just been at + is it the same 'type' of flower?
  //    if (flowerArray[i].flowerActivated==true && i != flowerIndex && flowerArray[i].flowerType == flowerType) {
  //      pairFlowers();     //If so pair this flower with that one
  //      flowerArray[i].pairFlowers();    //And pair that flower with this
  //    } 
  //    if (flowerArray[i].flowerType != flowerType) {    //If the newly activated flower is not the same type as the last
  //      flowerArray[i].resetActivation();    //Reset all flower's activations
  //    }
  //  }
  //  flowerActivated=true;    //Now activate this flower
  //}

  //void pairFlowers() {
  //  println("You Paired the Flowers !");
  //  flowerPaired = true;    //Set pairing boole
  //}



  //void drawLineToBee() {
  //  //if (flowerActivated == true && flowerPaired != true){
  //  stroke(255, 80);
  //  strokeWeight(15);
  //  strokeCap(ROUND);
  //  line(flowerX, flowerY, beeX, beeY);    //Draw a line from this flower to the Bee
  //}

  //void drawPairLine() {    //If 2 flowers are paired
  //  for (int i = 0; i < numberOfFlowers; i++) {    //Check through all the flowers. We could do a smaller check to save processing power
  //    if (flowerArray[i].flowerType == flowerType) {    //Find the paired flower of the same type
  //      strokeCap(ROUND);
  //      stroke(255, 40);
  //      strokeWeight(15);
  //      line(flowerX, flowerY, flowerArray[i].flowerX, flowerArray[i].flowerY);    //Draw a line between these two flowers
  //    }
  //  }
  //}

  void giveBeeNectar() {

    if (frameCount % 30 == 0 && touching == true && flowerActivated == false && flowerNectar > 0 && beeNectar < beeNectarMax) {
      beeNectar++;
      flowerNectar--;
    }
  }
}
