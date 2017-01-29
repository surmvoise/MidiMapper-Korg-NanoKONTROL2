

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;


  int cols = 21;
  int rows = 4;
  int[] layoutX = new int[cols]; // layout grid for NanoKONTROL2
  int[] layoutY = new int[rows]; // layout grid for NanoKONTROL2
  //float w;
  //float h;
  int cSize;
  boolean labelVisibility = true;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(displayWidth-w, displayHeight-h-20);
    cp5 = new ControlP5(this);

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
    cp5.addBang("stop_") 
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
  }

  void draw() {
    background(10);
  }
}