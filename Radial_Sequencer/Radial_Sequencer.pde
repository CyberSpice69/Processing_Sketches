//
//Click circles to trigger drum samples
//
//Inspired by "Play With Your Music" project by
//NYU musedlab and Ethan Hein's visualisations of
//Circular Rhythms: www.youtube.com/watch?v=tm2BgO1VaRY 
//
//Developed by Domme Ewan AKA Cyberspice at
//Glasgow School of Art - Interaction Design Department
//
//
// things to implement:
//
// Shift -1 or +1 per instrument - rotate the patterns
// swing ??
// user interface ! - bpm, instrument tuning & selection, step count


import processing.opengl.*;

/**
 * This sketch is a more involved use of AudioSamples to create a simple drum machine. 
 * Click on the buttons to toggle them on and off. The buttons that are on will trigger 
 * samples when the beat marker passes over their column. You can change the tempo by 
 * clicking in the BPM box and dragging the mouse up and down.
 * <p>
 * We achieve the timing by using AudioOutput's playNote method and a cleverly written Instrument.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/
 */

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;

Sampler     kick;
Sampler     snare;
Sampler     hat;

boolean[] hatRow = new boolean[16];
boolean[] snrRow = new boolean[16];
boolean[] kikRow = new boolean[16];

ArrayList<Rect> buttons = new ArrayList<Rect>();

int bpm = 150;

int beat; // which beat we're on

//float dx,dy;

// here's an Instrument implementation that we use 
// to trigger Samplers every sixteenth note. 
// Notice how we get away with using only one instance
// of this class to have endless beat making by 
// having the class schedule itself to be played
// at the end of its noteOff method. 
class Tick implements Instrument
{
  void noteOn( float dur )
  {
    if ( hatRow[beat] ) hat.trigger();
    if ( snrRow[beat] ) snare.trigger();
    if ( kikRow[beat] ) kick.trigger();
  }

  void noteOff()
  {
    // next beat
    beat = (beat+1)%16;
    // set the new tempo
    out.setTempo( bpm );
    // play this again right now, with a sixteenth note duration
    out.playNote( 0, 0.25f, this );
  }
}

// simple class for drawing the gui
class Rect 
{
  int x, y, w, h;
  float r, dx, dy;
  boolean[] steps;
  int stepId;
  float angle;

  public Rect(int _x, int _y, boolean[] _steps, int _id)
  {
    angle = map(_id, 0, 16, 0, TWO_PI);
    x = _x;
    y = _y;
    r = y;
    w = 50;
    h = 50;
    steps = _steps;
    stepId = _id;
    dx = r * cos(angle)+ width/2;
    dy = r * sin(angle) + height/2;
  }

  public void draw()
  {
    if ( steps[stepId] )
    {
      fill(255, 200, 210);
    } else
    {
      fill(50, 20, 50);
    } 

    //float angle = map(_id, 0, 16, 0, TWO_PI);




    // rect(x,y,w,h);

    ellipse(dx, dy, w, h);
    
      
  }

  public void mousePressed()
  {
    //if ( mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h )

    if ( dist(dx, dy, mouseX, mouseY)< w*0.5)
    {
      println(dx);
      steps[stepId] = !steps[stepId];
    }
  }
  

}

void setup()
{
  size(800, 800);
noCursor();

  // ellipseMode(CORNERS);

  minim = new Minim(this);
  out   = minim.getLineOut();

  // load all of our samples, using 4 voices for each.
  // this will help ensure we have enough voices to handle even
  // very fast tempos.
  kick  = new Sampler( "BD.wav", 4, minim );
  snare = new Sampler( "SD.wav", 4, minim );
  hat   = new Sampler( "CHH.wav", 4, minim );

  // patch samplers to the output
  kick.patch( out );
  snare.patch( out );
  hat.patch( out );

  for (int i = 0; i < 16; i++)
  {
    buttons.add( new Rect(10+i*48, int(height*0.2), hatRow, i ) );
    buttons.add( new Rect(10+i*48, int(height*0.3), snrRow, i ) );
    buttons.add( new Rect(10+i*48, int(height*0.4), kikRow, i ) );
  }

  beat = 0;

  // start the sequencer
  out.setTempo( bpm );
  out.playNote( 0, 0.25f, new Tick() );
}

void draw()
{
   float BMangle = map(beat, 0, 16, PI+HALF_PI,TWO_PI+PI+HALF_PI);
   
 
   
  background(0);
  fill(255);
  
  
  //noStroke();
  strokeWeight(2);
  stroke(128,25,128);
  //text(frameRate, width - 60, 20);

  for (int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).draw();
  }

  stroke(128);
  if ( beat % 4 == 0 )
  {
    fill(20, 0, 0);
  } else
  {
    fill(0, 200, 0);
  }

  // beat marker  
  float r = height*0.5;
  //float BMangle = map(beat, 0, 16, 0, TWO_PI);
  int BMx = int(r * cos(BMangle)+ width/2);
  int BMy = int(r * sin(BMangle) + height/2);


 // rect(BMx, BMy, 14, 9);
 pushMatrix();
 translate(width/2,height/2);
 rotate(BMangle);
  triangle(0,height*0.15,-5,height*0.15-20,5,height*0.15-20);
  triangle(0,height*0.45,-5,height*0.45+20,5,height*0.45+20);
popMatrix();

stroke(255,255,255);
strokeWeight(2);

line(mouseX-10, mouseY-10, mouseX+10, mouseY+10);
line(mouseX-10, mouseY+10, mouseX+10, mouseY-10);
}

void mousePressed()
{
  for (int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).mousePressed();
  }
}
