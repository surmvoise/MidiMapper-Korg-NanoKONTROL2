import sojamo.midimapper.*;
import controlP5.*;


ControlFrame cf;


float a;

void settings() {
  size(400, 400, P3D);
}


void setup() {
  cf = new ControlFrame(this, 600, 157, "Controls");
  surface.setLocation(420, 10);


}

void draw() {
  background(0);

  //println(nk2.slider1);
  rectMode(CENTER);
  rotate(map(a, 0, 100, 0, TWO_PI));
  translate(width/2, height/2);
  rect(0, 0, width/4, height/4);
}