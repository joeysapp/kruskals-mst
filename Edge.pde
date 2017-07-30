class Edge {
  Node n1;
  Node n2;
  float weight;
  float n;
  
  Edge(Node n1_, Node n2_){
    n1 = n1_;
    n2 = n2_;
    weight = n1.pos.dist(n2.pos);
    float div = 32;
    n = noise((n1.pos.x-n2.pos.x)/div, (n1.pos.y-n2.pos.y)/div, (n1.pos.z-n1.pos.z)/div);
  }
  
  String printIDs(){
    return ("("+n1.id+", "+n2.id+")");
  }  
  
  Integer getWeight(){
    return round(weight*1000);
  }
  
  void display(color c){
    strokeWeight(1.1);
    stroke(map(n, 0, 1, 125, 175), 255, 200);
    line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
    //strokeWeight(2);
    //stroke(0, 255, 0);
    //for (int i = 0 ; i <= 5; i++){
    //  float x = lerp(n1.pos.x, n2.pos.x, i/5.0); 
    //  float y = lerp(n1.pos.y, n2.pos.y, i/5.0); 
    //  float z = lerp(n1.pos.z, n2.pos.z, i/5.0); 
    //  point(x, y, z);
      
    //}
  }
  
  @Override
  public boolean equals(Object e){
    Edge tmp = (Edge) e;
    if ((n1 == tmp.n1 && n2 == tmp.n2) || (n1 == tmp.n2 && n2 == tmp.n1)){
      return true;
    } 
    return false;
    
  }
  
  
  
}