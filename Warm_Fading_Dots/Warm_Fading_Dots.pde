void setup(){

size(800,800);
background(0);

}

void draw(){

  blendMode(BLEND);
  
fill(0, 5);
noStroke();
//rect(0,0,width,height);


strokeWeight(128);

int numOfPoints = int(random(4));

if(random(1)>0.97){
blendMode(SCREEN);
for(int i=0; i<numOfPoints; i++){

  strokeWeight(random(80, 180));
  stroke(random(200,255), random(255), random(255));
  
  point(random(width), random(height));
}
}
//if(frameCount % 10 == 0){
  filter(ERODE);
  filter(BLUR);
//}
}
