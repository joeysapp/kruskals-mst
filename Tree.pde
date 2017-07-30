class Tree {
  ArrayList<Node> tree;
  ArrayList<Edge> edges;
  HashSet<Edge> mst;
  HashSet<Node> mst_nodes;

  HashSet<Edge> starting_edges;

  int required;
  int added = 0;

  Tree(int num, float padding) {
    tree = new ArrayList<Node>();
    edges = new ArrayList<Edge>();
    starting_edges = new HashSet<Edge>();
    mst = new HashSet<Edge>();
    mst_nodes = new HashSet<Node>();
    required = num;
    int n = 0;

    for (int i = 0; i < num; i++) {
      float theta = random(TWO_PI);
      float phi = random(PI);
      float x = padding * cos(theta) * cos(phi);
      float y = padding * cos(theta) * sin(phi);
      float z = padding * sin(theta);
      tree.add(new Node(n++, x, y, z));
    }


    // Completely random
    //for (int i = 0; i < num; i++) {
    //  float x = random(-padding, padding);
    //  float y = random(-padding, padding);
    //  float z = map(noise(x/padding, y/padding), 0, 1, -2*padding, 2*padding);
    //  tree.add(new Node(n++, x, y, z));
    //}

    int count = 0;
    long edge_count = CombinatoricsUtils.binomialCoefficient(amt, 2);
    int div = 30;
    int e_periods = (int)edge_count/div;
    print("P [");
    float fs  = millis();
    for (Node n1 : tree) {
      for (Node n2 : tree) {
        if (n1 != n2) {
          Edge e1 = new Edge(n1, n2);
          if (!starting_edges.contains(e1)) {
            count++;
            starting_edges.add(e1);
            if (count % e_periods == 0) {
              print('.');
            }
          }
        }
      }
    }
    edges = new ArrayList<Edge>(starting_edges);
    float fe = millis();
    println("]\nEdge creation time: " + (fe-fs)/1000);
    Collections.sort(edges, new WeightComp());
    Collections.reverse(edges);
    println("V: "+num+", E: "+edges.size());
  }

  // Cycles:
  /* (N1, N2) (N2, N3), -> (N3, N1).. bad
   (N2, N1) (N2, N6), -> (N6, N1).. bad
   Soln: Upon adding (N1, N2), see if there is a path from N1 -> N2 with BFS/DFS
   If there is, do not add it.
   */

  void genMSTstep() {

    if (mst_nodes.size() == required) {
      mst_done = true;
      return;
    }
    Edge random_start = edges.get(0);
    mst.add(random_start);
    int tries = 0;
    int i = 0;
    tries++;
    Edge current_edge = edges.get(added);
    if (added < edges.size()) {
      added++;
    }
    if (!mst.contains(current_edge)) {
      boolean cycle = false;
      // Check for cycles!
      cycle = isReachable(current_edge);
      if (!cycle) {
        mst.add(current_edge);
        if (!mst_nodes.contains(current_edge.n1)) {
          mst_nodes.add(current_edge.n1);
        }            
        if (!mst_nodes.contains(current_edge.n2)) {
          mst_nodes.add(current_edge.n2);
        }
      }
    }
  }

  void genMST() {
    Edge random_start = edges.get(0);
    mst.add(random_start);
    int tries = 0;
    int i = 0;
    while (mst.size() < 4 && tries < 10) {
      tries++;
      for (Edge current_edge : edges) {
        if (!mst.contains(current_edge)) {
          boolean cycle = false;
          // Check for cycles!
          cycle = isReachable(current_edge);
          if (!cycle) {
            mst.add(current_edge);
            if (!mst_nodes.contains(current_edge.n1)) {
              mst_nodes.add(current_edge.n1);
            }            
            if (!mst_nodes.contains(current_edge.n2)) {
              mst_nodes.add(current_edge.n2);
            }
          }
        }
      }
    }
  }

  int getPlacedVerts() {
    Set<Node> placed_nodes = new HashSet<Node>();
    Iterator<Edge> it = mst.iterator();
    while (it.hasNext()){
      Edge e = it.next();
      placed_nodes.add(e.n1);
      placed_nodes.add(e.n2);
    }
    return placed_nodes.size();
  }

  boolean isReachable(Edge e) {
    Node s = e.n1;
    Node d = e.n2;
    int v = getPlacedVerts();
    if (s == d) {
      return true;
    }
    HashSet<Node> visited = new HashSet<Node>(v);
    //HashSet<Node> visited = new HashSet<Node>(v);
    Queue<Node> queue = new LinkedList<Node>();
    visited.add(e.n1);
    queue.add(s);
    while (!queue.isEmpty()) {
      s = queue.remove();
      for (Node n : getAdjacentNodes(s)) {
        //stroke(0, 255, 0);
        //line(s.pos.x, s.pos.y, s.pos.z, d.pos.x, d.pos.y, d.pos.z);
        if (n == d) {
          return true;
        }
        if (!visited.contains(n)) {
          visited.add(n);
          queue.add(n);
        }
      }
    }
    return false;
  }

  void printMST() {
    for (Edge e : mst) {
      e.printIDs();
    }
  }

  ArrayList<Node> getAdjacentNodes(Node n) {
    ArrayList<Node> adj_nodes = new ArrayList<Node>();
    for (Edge others : mst) {
      if (n == others.n1) {
        adj_nodes.add(others.n2);
      } else if (n == others.n2) {
        adj_nodes.add(others.n1);
      }
    }
    return adj_nodes;
  }

  void displayMST() {
    for (Edge e : mst) {
      e.display(color(255));
    }
  }

  void displayNodes(color c) {
    for (Node n : tree) {
      n.display(c);
    }
  }

  void displayEdges() {
    for (Edge e : edges) {
      e.display(color(0));
    }
  }
}