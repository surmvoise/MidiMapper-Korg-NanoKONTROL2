

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

  void draw() {
    background(10);
    
    rect(20, 20, 20, 20);
  }
}