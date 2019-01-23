Hexagon[][] hexagon;
Hexagon hex_undiscovered;
int rad = 5;
int hexcountx, hexcounty;
int Mstep = 5;
int step;
color black = color(0);
color white = color(255);
color grey = color(100);
color red = color(255,0,0);
color boundary = color(50);
float x1, y1, x0, y0, dx, dy;
int thickness=2;
import processing.opengl.*;

void setup()
{
  size(1000, 1000);
  smooth();
  
  hexcountx = (height/(rad));
  hexcounty = (width/(rad)*2);

  hexagon = new Hexagon [hexcountx][hexcounty];
  for (int i = 0; i < hexcountx; i++){
        for (int j =0; j < hexcounty; j++){
          if ((j % 2) == 0) {
            hexagon[i][j] = new Hexagon((3 * rad * i), (.866 * rad * j), rad);
          } else {
            hexagon[i][j] = new Hexagon(3 * rad * (i + .5), .866 * rad * j, rad);
          }
        }
      }
   
  background(grey);
  //boundary condition
  stroke(boundary);
  for (int j=0; j<hexcounty/3; j++){
   fill(black);
   hexagon[0][j].display();
 }
 for (int j=hexcounty/3; j<hexcounty; j++)
 {
   fill(white);
   hexagon[0][j].display();
 }
 //other hexagon
 noFill();
 stroke(boundary);
  for (int i = 1; i < hexcountx; i ++ ) {     
    for (int j = 0; j < hexcounty; j ++ ) {
      
      hexagon[i][j].display();
    }
  }
  //starting point
  x1 = hexagon[0][hexcounty/3+1].x + rad*cos(radians(60));
  y1 = hexagon[0][hexcounty/3+1].y - rad*sin(radians(60));
  x0 = x1-rad;
  y0 = y1;
  strokeWeight(thickness);
  stroke(red);
  line(x0,y0,x1,y1);
  step = 0;
} // end of setup

void draw(){
  frameRate(50);
  //discover
   //get the color of the ahead hexagon
   // first compute the center.
   if ((x1<width) && (x1>0) && (y1>0) && (y1<height) ){
   float x_temp = 2 * x1 - x0; 
   float y_temp = 2 * y1 - y0;
   color cc = get(round(x_temp), round(y_temp));
   if (cc==grey){
     hex_undiscovered = new Hexagon(x_temp, y_temp, rad);
     int rd = int(random(2));
     strokeWeight(1);
     stroke(boundary);
     
     if (rd == 0) 
     {cc = black;
     fill(black);
     } else {
     cc = white;
     fill(white);
     
     }
     hex_undiscovered.display();
   } 
 if (cc == black){ // turn right
  dx = (x1-x0)/2 - (y1-y0)*sqrt(3)/2;
    dy = (y1-y0)/2 + (x1 -x0)*sqrt(3)/2;
   
   } else{ // white so turn left
   dx = (x1-x0)/2 + (y1-y0)*sqrt(3)/2;
   dy = (y1-y0)/2 - (x1 -x0)*sqrt(3)/2;
   
   }
   x0 = x1;
   y0 = y1;
   x1 = x0 + dx;
   y1 = y0 + dy;
   strokeWeight(thickness);
   stroke (red); //red
   line( x0, y0, x1, y1);
   }
} // end of setup

// Hexagon class
class Hexagon{
   float x,y,radi;
     float angle = 360.0 / 6;
   
 Hexagon(float cx, float cy, float r)
{
  x = cx;
  y = cy;
  radi=r;
}

void display(){
 beginShape();
  for (int i = 0; i < 6; i++)
  {
    vertex(x + radi * cos(radians(angle * i)),
      y + radi * sin(radians(angle * i)));
  }
 
  endShape(CLOSE);
}
}

