

class NK2 {
  String device = "SLIDER/KNOB";

  float slider1, slider2, slider3, slider4, slider5, slider6, slider7, slider8;
  float knob1, knob2, knob3, knob4, knob5, knob6, knob7, knob8;
  boolean s1, s2, s3, s4, s5, s6, s7, s8;
  boolean m1, m2, m3, m4, m5, m6, m7, m8;
  boolean r1, r2, r3, r4, r5, r6, r7, r8;
  boolean trackP, trackN, cycle, set, markerP, markerN, rewind, ff, stop_, play, rec;

  MidiMapper nk2Mapper;

  NK2(MidiMapper nk2Mapper) {
    this.nk2Mapper = nk2Mapper;
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