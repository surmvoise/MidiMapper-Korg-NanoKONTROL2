import controlP5.*;
import sojamo.midimapper.*;

MidiMapper midi;
ControlP5 cp5;
float a;

void setup() {
  size(400, 400);
  midi = new MidiMapper(this);
  midi.connect("SLIDER/KNOB").assign(16).to("a");

  cp5 = new ControlP5(this);

  // create a slider
  // parameters:
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addKnob("a")
    .setPosition(100, 50)
    .setRange(0, 127)
    ;
}

void draw() {
  background(0);
  fill(255);
  pushMatrix();
  translate(width/2, height/2);
  rotate(map(a, 0, 127, -PI, PI));
  translate(-20, -20);
  rect(0, 0, 40, 40);
  popMatrix();
  println(a);
}