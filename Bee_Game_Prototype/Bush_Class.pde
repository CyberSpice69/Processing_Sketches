//Classes aren't as scary as they seem!
//It's like making your own object
//So like when we ask for rect(x,y,w,h)
//instead here we have made bush(x,y,s,i)
//that can be asked to be made in the code after we say what it is and how it can respond.

class BushClass {   //THE CLASS

  //Declare variables
  float bushX, bushY, bushS, bushR;
  int bushIndex;
  
  boolean touching = false;
  boolean prevTouching = false;


  //The class 'constructor'. This is where we can pass data in from outside.
  BushClass (float _x, float _y, float _s, int _i) {  //Temporary variables

    //Then we assign the permanent variables to the temp ones
    bushX = _x; 
    bushY = _y; 
    bushS = _s;
   
    bushIndex = _i;  //Each bush gets a unique index so we know which is which
    //println("bushIndex = " + bushIndex);
    //bushType = round((bushIndex+1)*0.5);    //Bushes are in pairs of type. This numbers each type of bush ie: 1,1,2,2,3,3
    //println("bushType = " + bushType);
    bushR = bushS;
  } 

  void update() {

    checkTouchingBee();    //Call this function (scroll down)

    if (touching == true) {  //If the bee is touching this bush

      bushR = bushS * 1.2;    //Make the bush bigger to know we're interacting with it
      
    } else {
      bushR = bushS;    //Otherwise keep it at normal size
     
    } 

   
    display();    //    VVV    //
  }

  void display() {    //Draw the type of bush in a specific place

   
    pushMatrix();    //Open transformations
    translate(bushX, bushY);    //Birth position
    rotate(sin(radians(frameCount*0.01)*30));    //Sway back and forth
    //translate(wiggleAmp/2-wiggleAmp*noise(radians(0.25*frameCount+2222)), wiggleAmp/2-wiggleAmp*noise(0.25*radians(frameCount+777)));
    //translate(wiggleAmp2/2-wiggleAmp2*noise(radians(0.9*frameCount+2222)), wiggleAmp2/2-wiggleAmp2*noise(2*radians(frameCount+777)));
noStroke();
fill(63,155,39);
ellipseMode(CENTER);
ellipse(0,0,bushR,bushR);

    popMatrix();
  }


  void checkTouchingBee() {    //Is the bee touching this bush?

    if (dist(beeX, beeY, bushX, bushY) < (beeS + bushR)*0.3) {   //Are they close enough?
      touching = true;    //yes
    
    } else {
      touching = false;    //no
     
    }
    prevTouching = touching;    //Update the previous state to the current state
    //This turns a switch into a button  //There is better ways to do this though!?
  }









 
}
