import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import org.apache.commons.math3.util.CombinatoricsUtils;

// Implement Kruskals MST using euclidian distance

/* 
 Ideas:
 Instead of creating edges O(n^2), make each node have a set of neighbors
 Use that color lib
 */
import java.util.*;

PeasyCam cam;

int amt = 300;
float padding = 200;
float time_to_complete;
Tree t;

void setup() {
  size(500, 500, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB);
  //ortho();
  cam = new PeasyCam(this, 800);
  //ortho();
  float start = millis();
  t = new Tree(amt, padding);
  background(0);
  int edges = 1;
  for (int i = 1; i <= 2; i++) {
    edges *= (amt - (2 - i))/i;
  }

  //t.genMST();
  //t.genMST();
  //frameRate(1);
}


boolean mst_done = false;
boolean go = true;
boolean nodes = true;
boolean printed = false;

void keyPressed() {
  if (key == ' ') {
    nodes = !nodes;
  }
  if (key == 't') {
    println(t.required);
    println(t.mst_nodes.size());
  }
}

float dx = 0;
float dy = 0;
float dz = 0;

void draw() {
  background(0);
  rotateX(dx += 0.001);
  rotateY(dy += 0.003);
  rotateZ(dz += 0.002);
  //translate(-width/2, -height/2);
  //stroke(255, 0, 0);
  //strokeWeight(2);
  // X red
  //line(0, 0, 0, 10000, 0, 0);
  // Y green
  //stroke(0, 255, 0);
  //line(0, 0, 0, 0, 10000, 0);
  //stroke(0, 0, 255);
  // Z blue
  //line(0, 0, 0, 0, 0, 10000);
  //box(abs(padding));
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
  //saveFrame("frames/img_#####.png");
}

void mouseClicked() {
  //go = !go;
}