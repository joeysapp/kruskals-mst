class Node {
  int id;
  PVector pos, vel;
  
  Node(int id_, float x, float y, float z){
    id = id_;
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0);
  }
  
  void display(color c){
    stroke(c);
    strokeWeight(3.5);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotate(pos.x/255);
    noFill();
    sphereDetail(1);
    //fill(255, 75);
    point(0, 0, 0);
    //sphere(4);
    popMatrix();
    //text(id, pos.x-5, pos.y-5);
  }
  
  void update(){
    float n = 64*map(noise(pos.x/256, pos.y/256), 0, 1, -1, 1);
    float x = 1*cos(n);
    float y = 1*sin(n);
    vel.add(new PVector(x, y));
    vel.limit(0.1);
    pos.add(vel);
  }
}