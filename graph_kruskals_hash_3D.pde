import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import org.apache.commons.math3.util.CombinatoricsUtils;

// Implement Kruskals MST using euclidian distance

import java.util.*;

PeasyCam cam;

int amt = 300;
float padding = 200;
float time_to_complete;

boolean mst_done = false;
boolean go = true;
boolean nodes = true;
boolean printed = false;

Tree t;

float dx = 0;
float dy = 0;
float dz = 0;

void setup() {
  size(500, 500, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB);
  cam = new PeasyCam(this, 800);
  t = new Tree(amt, padding);
  background(0);
}

void keyPressed() {
  if (key == ' ') {
    nodes = !nodes;
  }
  if (key == 't') {
    println(t.required);
    println(t.mst_nodes.size());
  }
  if (key == 'i'){
    saveFrame();
  }
}

void draw() {
  background(0);
  
  rotateX(dx += 0.001);
  rotateY(dy += 0.003);
  rotateZ(dz += 0.002);
  
  if (mst_done && !printed) {
    printed = true;
    float s = (time_to_complete/1000)/60;
    String time = "s";
    if (s > 60){
      s = s/60;
      time = "m";
    }
    println("Time to complete: ", s, time);
  }

  if (go && !mst_done) {
    t.genMSTstep();
    time_to_complete += millis();
  }  
  t.displayMST();

  if (nodes) {
    t.displayNodes(color(255, 50));
  }
}