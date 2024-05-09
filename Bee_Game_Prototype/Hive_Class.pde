//Classes aren't as scary as they seem!
//It's like making your own object
//So like when we ask for rect(x,y,w,h)
//instead here we have made flower(x,y,s,i)
//that can be asked to be made in the code after we say what it is and how it can respond.

class HiveClass {   //THE CLASS

  //Declare variables
  float hiveX, hiveY;
  int hiveNectar;
  boolean touching = false;
  boolean prevTouching = false;


  //The class 'constructor'. This is where we can pass data in from outside.
  HiveClass (float _x, float _y, int _n) {  //Temporary variables

    //Then we assign the permanent variables to the temp ones
    hiveX = _x; 
    hiveY = _y; 
    hiveNectar = _n;
  } 

  void update() {

    checkTouchingBee();    //Call this function (scroll down)
    getNectarFromBee();
    

    display();    //    VVV    //
  }

  void display() {    //Draw the type of flower in a specific place

    pushMatrix();    //Open transformations
    translate(hiveX, hiveY);    //Birth position
    noStroke();
    fill(124, 95, 49);
    rectMode(CENTER);
    rect(0, 0, 80, 60);

    popMatrix();
  }


  void checkTouchingBee() {   

    if (dist(beeX, beeY, hiveX, hiveY) < (beeS + 30)) {   //Are they close enough?
      touching = true;    //yes
      //depositNectar();
    } else {
      touching = false;    //no
    }
    playHiveSound();
    prevTouching = touching;
  }


void getNectarFromBee() {

  if (frameCount % 30 == 0 && touching == true && hiveNectar < hiveNectarMax && beeNectar > 0) {

    beeNectar--;
    hiveNectar++;
  }
}


}
