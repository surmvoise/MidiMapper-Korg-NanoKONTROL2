

class NK2 {
  String device = "SLIDER/KNOB";

  int w, h;
  int cols = 21;
  int rows = 4;
  int[] layoutX = new int[cols]; // layout grid for NanoKONTROL2
  int[] layoutY = new int[rows]; // layout grid for NanoKONTROL2
  int cSize;
  boolean labelVisibility = true;

  // the actual values of the controller
  float slider1, slider2, slider3, slider4, slider5, slider6, slider7, slider8;
  float knob1, knob2, knob3, knob4, knob5, knob6, knob7, knob8;
  float s1, s2, s3, s4, s5, s6, s7, s8;
  float m1, m2, m3, m4, m5, m6, m7, m8;
  float r1, r2, r3, r4, r5, r6, r7, r8;
  float trackP, trackN, cycle, set, markerP, markerN, rewind, ff, stop_, play, rec;

  MidiMapper nk2Mapper;
  ControlP5 cp5;

  NK2(ControlP5 cp5, MidiMapper nk2Mapper, int w, int h) {
    this.cp5 = cp5;
    this.nk2Mapper = nk2Mapper;
    this.w = w;
    this.h = h;

    setupCP5();
  }

  void setupCP5() {

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



    cp5.setPosition(0, 0); // serves like rectmode CENTER

    //cp5.setPosition(-cSize/2, -cSize/2); // serves like rectmode CENTER
    // I'd like to align all the labels at once to the center, but don't know how
    //cp5.getAll().alignLabel(CENTER); 

    cp5.addTab("nanoKONTROL2");


    Group nk2Group = cp5.addGroup("nanoKONTROL2")
      .setPosition(0, 0)
      //.setPosition(-cSize/2, -cSize/2)
      .setSize(w, h)
      .setBackgroundHeight(h)
      .setBackgroundColor(color(255, 50))
      .moveTo("nanoKONTROL2")
      .hideBar();
    ;

    cp5.begin();


    // add controllers according to those on the nanoKONTROL2

    int counter = 1; // in order to number the controller independently from their location

    for (int i = 6; i < 21; i += 2) {
      cp5.addKnob("knob"+(counter))
        .setPosition(layoutX[i], layoutY[0])
        .setRadius(cSize/2)
        .setGroup(nk2Group)
        .setLabelVisible(labelVisibility)
        ;
      counter++;
    }
    counter = 1;
    for (int i = 6; i < 21; i += 2) {
      cp5.addSlider("slider"+(counter))
        .setPosition(layoutX[i], layoutY[1])
        .setSize(cSize, layoutY[3]-layoutY[1])
        .setGroup(nk2Group)
        .setLabelVisible(labelVisibility)
        ;
      counter++;
    }

    counter = 1;
    for (int i = 5; i < 20; i += 2) {
      cp5.addBang("s"+(counter))
        .setPosition(layoutX[i], layoutY[1])
        .setSize(cSize, cSize)
        .setGroup(nk2Group)
        .setLabelVisible(labelVisibility)
        ;
      counter++;
    }
    counter = 1;
    for (int i = 5; i < 20; i += 2) {
      cp5.addBang("m"+(counter))
        .setPosition(layoutX[i], layoutY[2])
        .setSize(cSize, cSize)
        .setGroup(nk2Group)
        .setLabelVisible(labelVisibility)
        ;
      counter++;
    }
    counter = 1;
    for (int i = 5; i < 20; i += 2) {
      cp5.addBang("r"+(counter))
        .setPosition(layoutX[i], layoutY[3])
        .setSize(cSize, cSize)
        .setGroup(nk2Group)
        .setLabelVisible(labelVisibility)
        ;
      counter++;
    }

    cp5.addBang("trackP")
      .setPosition(layoutX[0], layoutY[1])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("trackN")
      .setPosition(layoutX[1], layoutY[1])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;

    cp5.addBang("cycle")
      .setPosition(layoutX[0], layoutY[2])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;

    cp5.addBang("set")
      .setPosition(layoutX[2], layoutY[2])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("markerP")
      .setPosition(layoutX[3], layoutY[2])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("markerN")
      .setPosition(layoutX[4], layoutY[2])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;

    cp5.addBang("rewind")
      .setPosition(layoutX[0], layoutY[3])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("ff")
      .setPosition(layoutX[1], layoutY[3])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("stop_") 
      // giving name "stop" (without the !) here would cause the program to call 
      // a method which stops the ControlListener I guess or something that 
      // results in the cp5 not responding to anything anymore. the sketch 
      // however doesn't crash. a bug??
      .setPosition(layoutX[2], layoutY[3])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("play")
      .setPosition(layoutX[3], layoutY[3])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;
    cp5.addBang("rec")
      .setPosition(layoutX[4], layoutY[3])
      .setSize(cSize, cSize)
      .setGroup(nk2Group)
      .setLabelVisible(labelVisibility)
      ;

    cp5.end();
  }

  void setupNK2() {

    for (int i = 0; i < 8; i++) {
      nk2Mapper.connect(device).assign(i + 16).to("knob"+(i+1));
    }
    for (int i = 0; i < 8; i++) {
      nk2Mapper.connect(device).assign(i + 0).to("slider"+(i+1));
    }

    for (int i = 0; i < 8; i++) {
      nk2Mapper.connect(device).assign(i + 32).to("s"+(i+1));
    }
    for (int i = 0; i < 8; i++) {
      nk2Mapper.connect(device).assign(i + 48).to("m"+(i+1));
    }
    for (int i = 0; i < 8; i++) {
      nk2Mapper.connect(device).assign(i + 64).to("r"+(i+1));
    }

    nk2Mapper.connect(device).assign(58).to("trackP");
    nk2Mapper.connect(device).assign(59).to("trackN");

    nk2Mapper.connect(device).assign(46).to("cycle");
    nk2Mapper.connect(device).assign(60).to("set");
    nk2Mapper.connect(device).assign(61).to("markerP");
    nk2Mapper.connect(device).assign(62).to("markerN");

    nk2Mapper.connect(device).assign(43).to("rewind");
    nk2Mapper.connect(device).assign(44).to("ff");
    nk2Mapper.connect(device).assign(42).to("stop_");
    nk2Mapper.connect(device).assign(41).to("play");
    nk2Mapper.connect(device).assign(45).to("rec");
  }
}