

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  NK2 nk2;

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

    nk2 = new NK2(cp5, new MidiMapper(this), w, h);
  }

  void toggleLabelVisibility(boolean theFlag) {
    if (theFlag) nk2.labelVisibility = true;
    else nk2.labelVisibility = false;
    println("toggled Labels");

    if (theFlag) {
      cp5.getGroup("nanoKONTROL2")
        .getController("r1")
        .setLabelVisible(true)
        ;
    } else {
      cp5.getGroup("nanoKONTROL2")
        .getController("r1")
        .setLabelVisible(false)
        ;
    }
  }

  void draw() {
    background(10);
    if (nk2.labelVisibility) fill( 0, 255, 0);
    else fill(255, 0, 0);
    rect(20, 20, 20, 20);
  }
}