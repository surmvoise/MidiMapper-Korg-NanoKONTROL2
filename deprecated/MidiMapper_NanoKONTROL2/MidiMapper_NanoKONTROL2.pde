

/**
 * ControlP5 MidiMapper
 * 
 * Maps midi input to controlP5 controllers. 
 * This will eventually result in a library. 
 *
 * by Andreas Schlegel, 2013
 * www.sojamo.de/libraries/controlp5
 *
 */

import java.util.HashMap;
import java.util.Map;
import controlP5.*;
import javax.sound.midi.Receiver;
import javax.sound.midi.MidiMessage;

ControlP5 cp5;

Map<String, String> midimapper = new HashMap<String, String>();

int cols = 21;
int rows = 4;
int[] layoutX = new int[cols]; // layout grid for NanoKONTROL2
int[] layoutY = new int[rows]; // layout grid for NanoKONTROL2
float w;
float h;
int cSize;
boolean labelVisibility = true;

boolean trackP, trackN;


void setup() {
  size( 800, 260 );
  w = width;
  h = height;
  cSize = int(w/(cols+1)/2);

  /*
   give each layout colomn and row a absolute x and y
   in order to easily place controller in a layout grid
   */
  for (int x = 0; x < layoutX.length; x++) {
    for (int y = 0; y < layoutY.length; y++) {
      layoutX[x] = int(w/(cols+1) * (x+1));
      layoutY[y] = int(h/(rows+1) * (y+1));
    }
  }


  cp5 = new ControlP5( this );
  cp5.setPosition(-cSize/2, -cSize/2); // serves like rectmode CENTER
  // I'd like to align all the labels at once to the center, but don't know how
  //cp5.getAll().alignLabel(CENTER); 

  cp5.begin();


  // add controllers according to those on the nanoKONTROL2

  int counter = 1; // in order to number the controller independently from their location

  for (int i = 6; i < 21; i += 2) {
    cp5.addKnob("knob"+(counter))
      .setPosition(layoutX[i], layoutY[0])
      .setRadius(cSize/2)
      .setLabelVisible(labelVisibility)
      ;
    counter++;
  }
  counter = 1;
  for (int i = 6; i < 21; i += 2) {
    cp5.addSlider("slider"+(counter))
      .setPosition(layoutX[i], layoutY[1])
      .setSize(cSize, layoutY[3]-layoutY[1])
      .setLabelVisible(labelVisibility)
      ;
    counter++;
  }

  counter = 1;
  for (int i = 5; i < 20; i += 2) {
    cp5.addBang("s"+(counter))
      .setPosition(layoutX[i], layoutY[1])
      .setSize(cSize, cSize)
      .setLabelVisible(labelVisibility)
      ;
    counter++;
  }
  counter = 1;
  for (int i = 5; i < 20; i += 2) {
    cp5.addBang("m"+(counter))
      .setPosition(layoutX[i], layoutY[2])
      .setSize(cSize, cSize)
      .setLabelVisible(labelVisibility)
      ;
    counter++;
  }
  counter = 1;
  for (int i = 5; i < 20; i += 2) {
    cp5.addBang("r"+(counter))
      .setPosition(layoutX[i], layoutY[3])
      .setSize(cSize, cSize)
      .setLabelVisible(labelVisibility)
      ;
    counter++;
  }

  cp5.addBang("trackP")
    .setPosition(layoutX[0], layoutY[1])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("trackN")
    .setPosition(layoutX[1], layoutY[1])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;

  cp5.addBang("cycle")
    .setPosition(layoutX[0], layoutY[2])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;

  cp5.addBang("set")
    .setPosition(layoutX[2], layoutY[2])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("markerP")
    .setPosition(layoutX[3], layoutY[2])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("markerN")
    .setPosition(layoutX[4], layoutY[2])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;

  cp5.addBang("rewind")
    .setPosition(layoutX[0], layoutY[3])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("ff")
    .setPosition(layoutX[1], layoutY[3])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("stop!") 
  // giving name "stop" (without the !) here would cause the program to call 
  // a method which stops the ControlListener I guess or something that 
  // results in the cp5 not responding to anything anymore. the sketch 
  // however doesn't crash. a bug??
    .setPosition(layoutX[2], layoutY[3])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("play")
    .setPosition(layoutX[3], layoutY[3])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;
  cp5.addBang("rec")
    .setPosition(layoutX[4], layoutY[3])
    .setSize(cSize, cSize)
    .setLabelVisible(labelVisibility)
    ;

  cp5.end();


  // all the midi inputs are mapped to controllers 
  final String device = "SLIDER/KNOB";

  midimapper.clear();

  for (int i = 0; i < 8; i++) {
    midimapper.put( ref( device, i + 16 ), "knob"+(i+1) );
  }
  for (int i = 0; i < 8; i++) {
    midimapper.put( ref( device, i ), "slider"+(i+1) );
  }

  for (int i = 0; i < 8; i++) {
    midimapper.put( ref( device, i + 32 ), "s"+(i+1) );
  }
  for (int i = 0; i < 8; i++) {
    midimapper.put( ref( device, i + 48 ), "m"+(i+1) );
  }
  for (int i = 0; i < 8; i++) {
    midimapper.put( ref( device, i + 64), "r"+(i+1) );
  }

  midimapper.put( ref( device, 58 ), "trackP" );
  midimapper.put( ref( device, 59 ), "trackN" );

  midimapper.put( ref( device, 46 ), "cycle" );
  midimapper.put( ref( device, 60 ), "set" );
  midimapper.put( ref( device, 61 ), "markerP" );
  midimapper.put( ref( device, 62 ), "markerN" );

  midimapper.put( ref( device, 43 ), "rewind" );
  midimapper.put( ref( device, 44 ), "ff" );
  midimapper.put( ref( device, 42 ), "stop!" );
  midimapper.put( ref( device, 41 ), "play" );
  midimapper.put( ref( device, 45 ), "rec" );


  boolean DEBUG = false;

  if (DEBUG) {
    new MidiSimple( device );
  } else {
    new MidiSimple( device, new Receiver() {

      @Override public void send( MidiMessage msg, long timeStamp ) {

        byte[] b = msg.getMessage();

        if ( b[ 0 ] != -48 ) {

          Object index = ( midimapper.get( ref( device, b[ 1 ] ) ) );

          if ( index != null ) {

            Controller c = cp5.getController(index.toString());
            if (c instanceof Slider ) {  
              float min = c.getMin();
              float max = c.getMax();
              c.setValue(map(b[ 2 ], 0, 127, min, max) );
            } else if ( c instanceof Knob ) {
              float min = c.getMin();
              float max = c.getMax();
              c.setValue(map(b[ 2 ], 0, 127, min, max) );
            } else if ( c instanceof Button ) {
              if ( b[ 2 ] > 0 ) {
                c.setValue( c.getValue( ) );
                c.setColorBackground( 0xff08a2cf );
              } else {
                c.setColorBackground( 0xff003652 );
              }
            } else if ( c instanceof Bang ) {
              if ( b[ 2 ] > 0 ) {
                c.setValue( b[ 2 ] );
                c.setColorForeground( 0xff08a2cf );
              } else {
                c.setValue(b[ 2 ]);
                c.setColorForeground( 0xff00698c );
              }
            } else if ( c instanceof Toggle ) {
              if ( b[ 2 ] > 0 ) {
                ( ( Toggle ) c ).toggle( );
              }
            }
          }
        }
      }

      @Override public void close( ) {
      }
    }
    );
  }
}


String ref(String theDevice, int theIndex) {
  return theDevice+"-"+theIndex;
}


void draw() {
  background( 0 );

  // for testing purpose
  if (trackP) {
    ellipse(random(width), random(height), 10, 10);
  }
}